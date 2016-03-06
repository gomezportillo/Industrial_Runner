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

import flash.display.Bitmap;
import openfl.Assets;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.Lib;

import flash.display.StageAlign;
import flash.display.StageScaleMode;

class PauseState extends GameState {

  public static var _instance:PauseState;

  private function new () {
    super();
  }

  public static function getInstance() : PauseState {
    if (PauseState._instance == null)
    PauseState._instance = new PauseState();
    return PauseState._instance;
  }

  override function enter () : Void {
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    PlayState.getInstance().addLogoPausa();
  }

  override function exit() : Void {
    PlayState.getInstance().resume();
  }

  override function keyPressed (event:KeyboardEvent) : Void {
    if (event.keyCode == Keyboard.SPACE) {
      popState();
    }

    if (event.keyCode == Keyboard.ESCAPE){
      popState();
      PlayState.getInstance().popPlayState();
    }
  }

  override function pause() : Void { }
  override function resume() : Void { }
  override function keyReleased (event:KeyboardEvent) : Void { }
  override function mouseClicked (event:MouseEvent) : Void { }
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
