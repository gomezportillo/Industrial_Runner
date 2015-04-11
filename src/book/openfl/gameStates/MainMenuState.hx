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
import flash.text.TextField;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Bitmap; 
import openfl.Assets; 
import flash.display.StageAlign; 
import flash.display.StageScaleMode; 

class MainMenuState extends GameState {

  public static var _instance:MainMenuState;
  
  private var _logo:Bitmap;
  private var _play_light:Bitmap;
  private var _credits_light:Bitmap;
  private var _controls_light:Bitmap;

  private var _play_illuminated:Int;
  private var _credits_illuminated:Int;
  private var _controls_illuminated:Int;
  
  public var label:TextField;
   
  private function new () {
    super();  
    _logo = new Bitmap (Assets.getBitmapData ("img/states/main_menu.png"));
    
    _play_light = new Bitmap (Assets.getBitmapData ("img/states/light_menu/light_play.png"));
    _play_illuminated = 0;
    
    _credits_light = new Bitmap (Assets.getBitmapData ("img/states/light_menu/light_credits.png"));
    _credits_illuminated = 0;
    
    _controls_light = new Bitmap (Assets.getBitmapData ("img/states/light_menu/light_controls.png"));
    _controls_illuminated = 0;
        
    label = new TextField();
    label.width = 200;
    label.text = "Debugging";
  }

  public static function getInstance():MainMenuState {
    if (MainMenuState._instance == null)
      MainMenuState._instance = new MainMenuState();
    return MainMenuState._instance;
  }

  override function enter() : Void { 
    Lib.current.stage.align = StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
    addChild(_logo);
    stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  }

  override function exit() : Void { 
    removeChild(_logo);
    removeChild(_play_light);    
    removeChild(_credits_light); 
    removeChild(_controls_light);     
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  }
  
  private function onMouseMove(event:MouseEvent) {
    /*play button*/
    if (checkPlayButton(event) == 1){
      if (_play_illuminated == 0) {
        _play_illuminated = 1;        
        addChild(_play_light);  
      }
    } else if (_play_illuminated == 1){
      _play_illuminated = 0;
      removeChild(_play_light);
    
    /*credits button*/     
    } else if (checkCreditsButton(event) == 1) {
        if (_credits_illuminated == 0) {
          _credits_illuminated = 1; 
          addChild(_credits_light); 
        }
    } else if (_credits_illuminated == 1) {
        _credits_illuminated = 0;
        removeChild(_credits_light);
    
    /*controls button*/      
    } else if (checkControlsButton(event) == 1) {
        if (_controls_illuminated == 0) {
           _controls_illuminated = 1;        
          addChild(_controls_light);
        } 
    } else if (_controls_illuminated == 1) {
         _controls_illuminated = 0;
         removeChild(_controls_light);
    }
    
  }
  
 override function mouseClicked (event:MouseEvent) : Void {
    
    if (checkPlayButton(event) == 1) {
      popState();
      pushState(SelectStageState.getInstance());
      
    } else if (checkCreditsButton(event) == 1) {
      popState();  
      pushState(CreditsState.getInstance());
      
    } else if (checkControlsButton(event) == 1) { 
      popState(); 
      pushState(ControlsState.getInstance());
    }
 }
  
  private function checkPlayButton(event:MouseEvent):Int{
    if (event.localX>=60 && event.localX<= 360 && event.localY>=130 && event.localY<=340) return 1;
    else return 0;
  }
  
  private function checkCreditsButton(event:MouseEvent):Int{
    if (event.localX>=410 && event.localX<= 720 && event.localY>=235 && event.localY<=375) return 1;
    else return 0;
  }
  
  private function checkControlsButton(event:MouseEvent):Int{
    if (event.localX>=410 && event.localX<= 760 && event.localY>=90 && event.localY<=220) return 1;
    else return 0;
  }
  
 
  override function pause() : Void { }
  override function resume() : Void {}
  override function keyPressed (event:KeyboardEvent) : Void { }
  override function keyReleased (event:KeyboardEvent) : Void { }
  private  function whenGameOver():Void {}
  override function frameStarted (event:Event) : Void { }
  override function frameEnded (event:Event) : Void { }

}
