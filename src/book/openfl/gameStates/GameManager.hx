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

import book.openfl.gameStates.PlayState;

import motion.Actuate; 

import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent; 
import flash.events.MouseEvent;
import flash.Lib;

class GameManager {

  public static var _instance:GameManager;
  
  private var _states:Array<GameState>; //states stack

  private function new () { 
    _states = new Array<GameState>();
  }

  public static function getInstance() : GameManager {
    if (GameManager._instance == null)
      GameManager._instance = new GameManager();
    return GameManager._instance;
  }

  public function start (state:GameState) : Void {
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		//adding the listeners for all the different events to take into account
    Lib.current.stage.addEventListener(Event.ENTER_FRAME, frameStarted);
    Lib.current.stage.addEventListener(MouseEvent.CLICK, mouseClicked);
    Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
    Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);

    changeState(state);
  }

  public function changeState (state:GameState) : Void { 
    if (_states.length > 0) {
      _states.pop().exit();
    }
    
    _states.push(state);
    state.enter();
  }

  public function pushState (state:GameState) : Void { 
    if (_states.length > 0) {
      _states[_states.length -1].pause();
    }

    _states.push(state);
    state.enter();
  }

  public function popState () : Void {  
    if (_states.length > 0)
      _states.pop().exit();
    else 
    	trace("No more states to pop. This last state will be keept");

    if 	(_states.length > 0) _states[_states.length -1].resume();
  }

  public function keyPressed (event:KeyboardEvent) : Void {
    _states[_states.length -1].keyPressed(event);
  }

  public function keyReleased (event:KeyboardEvent) : Void {
    _states[_states.length -1].keyReleased(event);
  }

  public function mouseClicked (event:MouseEvent) : Void { 
    _states[_states.length -1].mouseClicked(event);
  } 

  public function frameStarted (event:Event) : Void { 
    _states[_states.length -1].frameStarted(event);
  }

  public function frameEnded (event:Event) : Void { 
    _states[_states.length -1].frameEnded(event);
  }

}
