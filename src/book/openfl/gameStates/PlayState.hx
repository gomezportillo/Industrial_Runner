/*********************************************************************
* Author: Pedro-M. Gómez-Portillo López    pedroma.almagro@gmail.com
*
* You can redistribute and/or modify this file under the terms of the
* GNU General Public License ad published by the Free Software
* Foundation, either version 3 of the License, or (at your option)
* and later version. See <http://www.gnu.org/licenses/>.
*
* This file is distributed in the hope that it will be useful, but
* WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*********************************************************************/

package book.openfl.gameStates;

import book.openfl.scrollParallax.ParallaxGame;
import book.openfl.physics.PhSpriteVector;
import book.openfl.util.ScoreBoard;
import book.openfl.sprites.SimpleOverlay;
import book.openfl.sprites.Player;

import motion.Actuate;

import aze.display.TileLayer;
import aze.display.TileSprite;
import aze.display.SparrowTilesheet;

import openfl.Assets;
import flash.events.Event;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import flash.utils.Timer;
import flash.events.TimerEvent;

import phx.World;
import phx.col.AABB;
import phx.col.SortedList;
import phx.Shape;

class PlayState extends GameState {

  public static var _instance:PlayState;
  public static var _parallax:ParallaxGame;
  public static var _day_time:String;

  private var _layer:TileLayer;             			// main draw layer
  private var _vPhSprite:Array<PhSpriteVector>;		// when the physical boxes will be stored
  private static var _world:World;                // physic simulation world
  private var physic_sheetData:String;
  public var _player:Player;
  public var _invincibility:Bool;

  public var _secondTimer:Timer;
  public var _invincibilityTimer:Timer;

  public var _remaining_lifes:Int;

  public var _scoreBoard:ScoreBoard;
  public var _scoreboard_layer:SimpleOverlay;
  public var _heart1:SimpleOverlay;
  public var _heart2:SimpleOverlay;
  public var _heart3:SimpleOverlay;


  private function new () {
    super();
  }

  public static function getInstance():PlayState {
    if (PlayState._instance == null)
    PlayState._instance = new PlayState();
    return PlayState._instance;
  }

  public function setDayTime(time_of_day:String):Void {
    _day_time = time_of_day;
  }

  override function enter() : Void {
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    _parallax = new ParallaxGame(_day_time);
    addChild(_parallax);
    loadResources();
  }

  function loadResources() {
    physic_sheetData = Assets.getText("img/sprites/sprites.xml");
    var tilesheet:SparrowTilesheet = new SparrowTilesheet (Assets.getBitmapData("img/sprites/sprites.png"), physic_sheetData);
    _layer = new TileLayer(tilesheet);
    _player = new Player(_layer, "man");

    _remaining_lifes = 3;
    _invincibility = false;

    Lib.current.stage.addChild(_layer.view);
    _vPhSprite = new Array<PhSpriteVector>();
    createPhysicWorld();

    setTimers();
    setScoreboard();
    setHeartContainers();
  }

  public function setTimers() {
    _secondTimer = new Timer(1000);
    _secondTimer.addEventListener(TimerEvent.TIMER, timeListener); //each time will throw a boxxx
    _secondTimer.start();

    _invincibilityTimer = new Timer(1000);
    _invincibilityTimer.addEventListener(TimerEvent.TIMER, invincibilityTimer); //for restarting the invincibility
    _invincibilityTimer.start();
    _invincibilityTimer.removeEventListener(TimerEvent.TIMER, invincibilityTimer); //for restarting the invincibility
  }

  public function setScoreboard(){
    _scoreboard_layer = new SimpleOverlay(_layer, "scoreboard", 100, 80);  //the background image
    _layer.addChild(_scoreboard_layer);

    var color:Int = _day_time == "day" ? 0xff0000 : 0x003E80; //red : blue
    _scoreBoard = new ScoreBoard(50, 50, color, "font/cafeta.ttf"); //the number counter

    addChild(_scoreBoard);
  }

  public function setHeartContainers() {
    //Red part of the hearts
    _heart1 = new SimpleOverlay(_layer, "heart-within", 550, 50);
    _heart2 = new SimpleOverlay(_layer, "heart-within", 625, 50);
    _heart3 = new SimpleOverlay(_layer, "heart-within", 700, 50);
    _layer.addChild(_heart1);
    _layer.addChild(_heart2);
    _layer.addChild(_heart3);

    //Oulining the hearts
    _layer.addChild(new SimpleOverlay(_layer, "heart-outline", 550, 50));
    _layer.addChild(new SimpleOverlay(_layer, "heart-outline", 625, 50));
    _layer.addChild(new SimpleOverlay(_layer, "heart-outline", 700, 50));
  }


  function createPhysicWorld():Void {
    var size = new AABB(-1000, -1000, 1000, 1000);
    var bp = new SortedList();
    _world = new World(size, bp);
    createLimits(stage.stageWidth, stage.stageHeight);
    _world.gravity = new phx.Vector(0,0.3);
  }

  function createLimits(w:Float, h:Float):Void {
    //makeBox(width, height, X pos, Y pos) (x and y beggining from top left)

    var s = Shape.makeBox(w,200,0,h-63);
    s.material.restitution = 0;  			// ground bouncing
    s.material.density = 0.5;        	//  ground density
    _world.addStaticShape(s);

    //_world.addStaticShape(Shape.makeBox(200,h,-200,0)); //left
    //_world.addStaticShape(Shape.makeBox(200,h,w,0)); //right
  }

  override function exit() : Void {
    removeItems();
    _parallax.removeParallax();
    InitialState.getInstance().restartMainMenu();
  }

  public function popPlayState(){ //when pop calls exit, which removes parallax, music and restart mainmenu
    popState();
  }

  override function pause() : Void {
    _secondTimer.removeEventListener(TimerEvent.TIMER, timeListener);
    _invincibilityTimer.removeEventListener(TimerEvent.TIMER, invincibilityTimer);
    _parallax.pauseParallax();

    //the rest of the things get also stopped as in state change they stop being rendered
  }

  public function addLogoPausa(){
    _parallax.addLogoPausa();
  }

  public function addLogoGameOver(){
    _parallax.addLogoGameOver();
  }

  public function removeItems(){
    /*for (i in _vPhSprite){ //this step may be avoided as later we remove the whole _layer
    i.destroy();
    _layer.removeChild(i);
    _vPhSprite.remove(i);
  }
  */

  _secondTimer.removeEventListener(TimerEvent.TIMER, timeListener);
  removeChild(_scoreBoard);
  Lib.current.stage.removeChild(_layer.view);

}

override function resume() : Void {
  _secondTimer.addEventListener(TimerEvent.TIMER, timeListener);
  _parallax.continueParallax();
  _parallax.removeLogoPausa(); //dont know from where we are restarting, so deleting both of them
  _parallax.removeLogoGameOver();
}

public function restartLevel() {
  removeItems();
  loadResources();

}

override function keyPressed (event:KeyboardEvent) : Void {
  if (event.keyCode == Keyboard.SPACE) {
    pushState(PauseState.getInstance()); //on pushState, GameManager pauses the previous one
  }

  else _player.onKeyPressed(event);
}

override function keyReleased (event:KeyboardEvent) : Void {
  _player.onKeyReleased(event);
}

private function whenGameOver():Void {
  pushState(GameOverState.getInstance());
}

override function frameStarted (event:Event) : Void {
  _world.step(1,10);

  checkCollisions();

  _player.update();
  _layer.render();

}

public function checkCollisions(){
  for (p in _vPhSprite) {
    p.update(stage.stageWidth, stage.stageHeight);

    if(!_invincibility) {
      if (_player.checkCollision(p) == true) {
        switch(_remaining_lifes) {
          case 3:
          _layer.removeChild(_heart1);
          case 2:
          _layer.removeChild(_heart2);
          case 1:
          _layer.removeChild(_heart3);
          whenGameOver();
        }
        _remaining_lifes -= 1;
        _invincibility = true;
        _invincibilityTimer.addEventListener(TimerEvent.TIMER, invincibilityTimer); //for restarting the invincibility
        break;
      }
    }
  }
}
public function timeListener(event:TimerEvent) { //each second
  _scoreBoard.update(1);
  addBox();
}

public function invincibilityTimer(event:TimerEvent) {
  _invincibility = false;
  _invincibilityTimer.removeEventListener(TimerEvent.TIMER, invincibilityTimer); //for restarting the invincibility
}

public function addBox(){
  if (Std.random(3) < 2 ) {
    var p:PhSpriteVector;
    var vector_y = -5 - Std.random(7);
    var vector_x = -10 - Std.random(5);
    var pos_y = 400 - Std.random(150);


    if (Std.random(2) == 0) //throwing randombly a box or a ball
      p = new PhSpriteVector("ball", _layer, _world, 1000, pos_y, new phx.Vector(vector_x, vector_y));
    else
      p = new PhSpriteVector("box", _layer, _world, 1000, pos_y, new phx.Vector(vector_x, vector_y));

    _vPhSprite.push(p);
  }
}

override function frameEnded (event:Event) : Void { }
override function mouseClicked (event:MouseEvent) : Void { }

}
