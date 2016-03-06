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

import book.openfl.sound.SoundManager;

import motion.Actuate;
import flash.events.Event;

import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

class ControlsState extends GameState {

  public static var _instance:ControlsState;
  private var _logo:Bitmap;

  private function new () {
    super();
    _logo = new Bitmap (Assets.getBitmapData ("img/states/controls.png"));
  }

  public static function getInstance():ControlsState {
    if (ControlsState._instance == null)
    ControlsState._instance = new ControlsState();
    return ControlsState._instance;
  }

  override function enter() : Void {
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    addChild(_logo);
  }

  override function exit() : Void {
    removeChild(_logo);
  }

  override function keyPressed (event:KeyboardEvent) : Void {
    if (event.keyCode == Keyboard.SPACE) {
      popState();
      pushState(MainMenuState.getInstance());
    }
  }

  override function mouseClicked (event:MouseEvent) : Void { }
  override function pause() : Void { }
  override function resume() : Void {}
  override function keyReleased (event:KeyboardEvent) : Void { }
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
