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
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.Lib;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import openfl.Assets;

class GameOverState extends GameState {

  public static var _instance:GameOverState;

  private function new () {
    super();
    //cannot add images in this class as they will end bellow the parallax; 
    //gotta delegate on parallax class for doing so
  }

  public static function getInstance() : GameOverState {
    if (GameOverState._instance == null)
      GameOverState._instance = new GameOverState();
    return GameOverState._instance;
  }

  override function enter () : Void { 
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    PlayState.getInstance().addLogoGameOver();
  }

  override function keyPressed (event:KeyboardEvent) : Void { 
    if (event.keyCode == Keyboard.ESCAPE) {
      popState();
      PlayState.getInstance().popPlayState(); //ends playstate and this last restarts the mainmenustate
    }
    
    if (event.keyCode == Keyboard.SPACE) {
      popState();
			PlayState.getInstance().restartLevel();
    }
  }

	override function exit() : Void {}
  override function pause() : Void { }
  override function resume() : Void { }
  override function keyReleased (event:KeyboardEvent) : Void { }
  override function mouseClicked (event:MouseEvent) : Void { } 
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
