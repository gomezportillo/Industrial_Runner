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

import book.openfl.scrollParallax.ParallaxMenu;

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

class InitialState extends GameState {

  public static var _instance:InitialState;
  private var _logo:Bitmap;
  private var _parallax_menu:ParallaxMenu;

  private function new () {
    super();
    _logo = new Bitmap(Assets.getBitmapData("img/states/init_screen.png"));
  }

  public static function getInstance():InitialState {
    if (InitialState._instance == null)
    InitialState._instance = new InitialState();
    return InitialState._instance;
  }


  override function enter() : Void {
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    _parallax_menu = new ParallaxMenu();
    Lib.current.addChild(_parallax_menu);
    addChild(_logo);
  }

  override function exit() : Void {
    //initialState never goes out the states stack
  }

  override function keyPressed (event:KeyboardEvent) : Void {
    if (event.keyCode == Keyboard.SPACE) {
      removeChild(_logo); //cannot remove the initalState as the stack would get empty
      pushState(MainMenuState.getInstance());
    }
  }

  public function restartMainMenu() {
    addChild(_logo);
    _parallax_menu.loadMusic();
  }

  override function resume() : Void { }
  override function pause() : Void {}
  override function keyReleased (event:KeyboardEvent) : Void { }
  override function mouseClicked (event:MouseEvent) : Void { }
  private function whenGameOver():Void { }
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
