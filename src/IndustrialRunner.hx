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

package;

import book.openfl.gameStates.GameManager;
import book.openfl.gameStates.GameState;
import book.openfl.gameStates.InitialState;
import book.openfl.gameStates.MainMenuState;
import book.openfl.gameStates.CreditsState;
import book.openfl.gameStates.ControlsState;
import book.openfl.gameStates.SelectStageState;
import book.openfl.gameStates.PlayState;
import book.openfl.gameStates.PauseState;
import book.openfl.gameStates.GameOverState;

import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.Lib;
import openfl.Assets;

#if flash
import kong.Kongregate;
import kong.KongregateApi;
#end

class IndustrialRunner extends Sprite {

  public static var _instance:IndustrialRunner;

  #if flash
  var _kongApi:KongregateApi; 		  //Kongregate's API
  #end

  private function new () {
    super ();

    var gameManager:GameManager = GameManager.getInstance();
    var initialState:InitialState = InitialState.getInstance();
    var mainMenuState:MainMenuState = MainMenuState.getInstance();
    var creditsState:CreditsState = CreditsState.getInstance();
    var controlsState:ControlsState = ControlsState.getInstance();
    var selectStageState:SelectStageState = SelectStageState.getInstance();
    var playState:PlayState = PlayState.getInstance();
    var pauseState:PauseState = PauseState.getInstance();
    var gameOverState:GameOverState = GameOverState.getInstance();

    addChild(initialState);
    addChild(mainMenuState);
    addChild(controlsState);
    addChild(creditsState);
    addChild(selectStageState);
    addChild(playState);
    addChild(pauseState);
    addChild(gameOverState);

    // let's start fellas!
    gameManager.start(initialState);


    #if flash
    Kongregate.loadApi(kongregateLoad);
    #end
  }

  #if flash
  private function kongregateLoad(api:KongregateApi):Void {
    trace("KongregateApi loaded");
    _kongApi = api;
    _kongApi.services.connect();
  }
  #end

  // Singleton pattern
  public static function getInstance() : IndustrialRunner {
    if (IndustrialRunner._instance == null)
    IndustrialRunner._instance = new IndustrialRunner();
    return IndustrialRunner._instance;
  }

  public static function main () {
    Lib.current.addChild (IndustrialRunner.getInstance ());
  }

}
