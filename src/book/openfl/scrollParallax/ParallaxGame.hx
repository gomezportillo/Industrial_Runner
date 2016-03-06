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

package book.openfl.scrollParallax;

import book.openfl.scrollParallax.graphics.ParallaxManager;
import book.openfl.sound.SoundManager;

import aze.display.TileLayer;
import aze.display.SparrowTilesheet;

import flash.system.Capabilities;
import openfl.Assets;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLRequest;


import flash.display.Bitmap;
class ParallaxGame extends Sprite {

  var _parallaxManager:ParallaxManager;
  var _layer:TileLayer;
  var _previousTime:Int;
  var _sheetData:String;
  var _day_time:String;
  var _moving:Bool;

  var _logoPause:Bitmap;
  var _logoGameOver:Bitmap;

  // Builder =====================================================
  public function new(time_of_day:String) {
    _day_time = time_of_day;
    _moving = true;
    super();
    haxe.Timer.delay(init, 150);
    //images should be added from here for being over the parallax
    _logoPause = new Bitmap(Assets.getBitmapData("img/states/pause.png"));
    _logoGameOver = new Bitmap(Assets.getBitmapData("img/states/game_over.png"));

  }

  function init():Void {
    //createScene();
    #if js
    // workaround for binary data loading bug in html5
    var ul:URLLoader;
    if (_day_time == "day")
    ul = new URLLoader(new URLRequest("img/parallax_game/Parallax_day.xml"));
    else
    ul = new URLLoader(new URLRequest("img/parallax_game/Parallax_night.xml"));

    ul.addEventListener(Event.COMPLETE, ul_complete);

    #else
    if (_day_time == "day") _sheetData = Assets.getText("img/parallax_game/Parallax_day.xml");
    else _sheetData = Assets.getText("img/parallax_game/Parallax_night.xml");

    createScene();
    loadMusic();
    #end

  }

  function ul_complete(e){
    _sheetData = e.target.data;
    createScene();
    loadMusic();
  }

  // Scene creation ===========================================
  function createScene():Void {

    var tilesheet:SparrowTilesheet;
    if (_day_time == "day")
    tilesheet = new SparrowTilesheet (Assets.getBitmapData("img/parallax_game/Parallax_day.png"), _sheetData);
    else
    tilesheet = new SparrowTilesheet (Assets.getBitmapData("img/parallax_game/Parallax_night.png"), _sheetData);

    _layer = new TileLayer(tilesheet);
    addChild(_layer.view);
    _parallaxManager = new ParallaxManager(_layer);
    _parallaxManager.addSky("sky");			//name, ?, zoom, ypos, veloc)
    _parallaxManager.addBackgroundStrip("buildings0", 4, 2*1.3, 150, -10);
    _parallaxManager.addBackgroundStrip("buildings1", 4, 2, 150, 125); //
    _parallaxManager.addBackgroundStrip("flats", 4, 2, 165, 200); //50
    _parallaxManager.addBackgroundStrip("ground", 4, 2.5, 30, 300); //80

    addListeners();

  }

  // Main loop =================================================
  function mainLoop(eTime:Int):Void {
    if(_moving) _parallaxManager.update(stage.stageWidth, stage.stageHeight, eTime);
    _layer.render();
  }

  // Controll the movement of the parallax ================================================================
  public function pauseParallax():Void{
    _moving = false;
  }

  public function continueParallax():Void{
    _moving = true;
  }

  public function addLogoPausa():Void {
    addChild(_logoPause);
  }

  public function removeLogoPausa():Void {
    removeChild(_logoPause);
  }

  public function addLogoGameOver():Void {
    addChild(_logoGameOver);
  }

  public function removeLogoGameOver():Void {
    removeChild(_logoGameOver);
  }

  public function removeParallax(){
    removeChild(_layer.view);
    _parallaxManager.removeParallax();
    SoundManager.getInstance().stopBackgroundMusic();
  }


  // Listeners =======================================================
  function addListeners():Void {
    stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    _previousTime = Lib.getTimer();
  }

  function onEnterFrame(event:Event):Void {
    var now = Lib.getTimer();
    var elapsedTime = now - _previousTime;
    _previousTime = now;
    mainLoop(elapsedTime);
  }

  // Music ===========================================================
  private function loadMusic () {
    #if !flash
    if (_day_time == "day")
    SoundManager.getInstance().loadBackgroundMusic("music/8bits_adventure.ogg");
    else
    SoundManager.getInstance().loadBackgroundMusic("music/melancholic_theme.ogg");

    #else
    if (_day_time == "day")
    SoundManager.getInstance().loadBackgroundMusic("music/8bits_adventure.mp3");
    else
    SoundManager.getInstance().loadBackgroundMusic("music/melancholic_theme.mp3");
    #end
    SoundManager.getInstance().playBackgroundMusic();
  }
}
