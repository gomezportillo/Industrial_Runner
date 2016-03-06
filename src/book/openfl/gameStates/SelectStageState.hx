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

import book.openfl.sound.SoundManager; //for turning off the music

import motion.Actuate;

import flash.events.Event;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import openfl.Assets;

class SelectStageState extends GameState {

  public static var _instance:SelectStageState;
  private var _logo:Bitmap;
  private var _moon_light:Bitmap;
  private var _sun_light:Bitmap;

  private var _sun_illuminated:Int;
  private var _moon_illuminated:Int;

  private function new () {
    super();
    _logo = new Bitmap (Assets.getBitmapData ("img/states/select_stage.png"));
    _sun_light = new Bitmap (Assets.getBitmapData ("img/states/light_menu/select_stage_sun_light.png"));
    _moon_light = new Bitmap (Assets.getBitmapData ("img/states/light_menu/select_stage_moon_light.png"));

    _sun_illuminated = 0;
    _moon_illuminated = 0;
  }

  // Patrón Singleton.
  public static function getInstance():SelectStageState {
    if (SelectStageState._instance == null)
    SelectStageState._instance = new SelectStageState();
    return SelectStageState._instance;
  }

  override function enter() : Void {
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    addChild(_logo);
    addChild(_sun_light);
  }

  override function exit() : Void {
    removeChild(_logo);
    removeChild(_sun_light);
    removeChild(_moon_light);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  }

  private function onMouseMove (event:MouseEvent){
    /*sun light logo*/
    if (checkDayStage(event) == 1) {
      if (_sun_illuminated == 0) {
        addChild(_sun_light);
        _sun_illuminated = 1;
      }
    } else if (_sun_illuminated == 1) {
      removeChild(_sun_light);
      _sun_illuminated = 0;

      /*moon light logo*/
    } else if (checkNightStage(event) == 1) {
      if (_moon_illuminated == 0) {
        addChild(_moon_light);
        _moon_illuminated = 1;
      }
    } else if (_moon_illuminated == 1) {
      removeChild(_moon_light);
      _moon_illuminated = 0;
    }
  }

  override function mouseClicked (event:MouseEvent) : Void { //choose scenario

    var day_time = (checkDayStage(event) == 1) ? "day" : "night";

    SoundManager.getInstance().stopBackgroundMusic();
    popState();
    PlayState.getInstance().setDayTime(day_time);
    pushState(PlayState.getInstance());
  }

  private function checkDayStage(event:MouseEvent):Int {
    if (event.localX>=30 && event.localX<= 280 && event.localY>=150 && event.localY<=370) return 1;
    else return 0;
  }

  private function checkNightStage(event:MouseEvent):Int {
    if (event.localX>=515 && event.localX<= 770 && event.localY>=150 && event.localY<=370) return 1;
    else return 0;
  }
  override function keyPressed (event:KeyboardEvent) : Void {
    if (event.keyCode == Keyboard.SPACE) {
      popState();
      pushState(MainMenuState.getInstance());

    }
  }

  override function pause() : Void { }
  override function resume() : Void {}
  override function keyReleased (event:KeyboardEvent) : Void { }
  private function whenGameOver():Void {}
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
