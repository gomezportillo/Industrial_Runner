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

import flash.net.URLRequest; //for opening an URL in the browser

class CreditsState extends GameState {

  public static var _instance:CreditsState;
  private var _logo:Bitmap;
   
  private function new () {
    super();  
    _logo = new Bitmap (Assets.getBitmapData ("img/states/credits.png"));      
  }

  public static function getInstance():CreditsState {
    if (CreditsState._instance == null)
      CreditsState._instance = new CreditsState();
    return CreditsState._instance;
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
  
 override function mouseClicked (event:MouseEvent) : Void { 
      
    if (checkPedroma(event) == 1) {
      Lib.getURL(new URLRequest("https://github.com/pedroma-gomezp/Industrial_Runner/tree/master"));

    } else if (checkAnsimuz(event) == 1) {
      Lib.getURL(new URLRequest("https://twitter.com/ansimuz"));

    } else if (checkCurso_Openfl(event) == 1) {
      Lib.getURL(new URLRequest("http://curso-openfl.com"));
      
    } else if (checkBackgroundMusic(event) == 1) {
      Lib.getURL(new URLRequest("http://opengameart.org/users/skrjablin"));
      Lib.getURL(new URLRequest("http://opengameart.org/users/revampedpro"));
    }  
     
 } 
 
  private function checkPedroma(event:MouseEvent):Int{
    if (event.localX>= 25 && event.localX<= 350 && event.localY>=140 && event.localY<= 220) return 1;
    else return 0;
  }
  
  private function checkAnsimuz(event:MouseEvent):Int{
    if (event.localX>= 25 && event.localX<= 330 && event.localY>= 300 && event.localY<= 360) return 1;
    else return 0;
  }
  
  private function checkCurso_Openfl(event:MouseEvent):Int{
    if (event.localX>= 400 && event.localX<= 700 && event.localY>= 140 && event.localY<= 220) return 1;
    else return 0;
  }
  
  private function checkBackgroundMusic(event:MouseEvent):Int{
    if (event.localX>= 400 && event.localX<= 800 && event.localY>= 300 && event.localY<= 360) return 1;
    else return 0;
  }
  
  override function pause() : Void { }
  override function resume() : Void {}
  override function keyReleased (event:KeyboardEvent) : Void { }
  private function whenGameOver():Void {}
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
