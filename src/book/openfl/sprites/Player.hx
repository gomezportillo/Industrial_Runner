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

package book.openfl.sprites;

import book.openfl.physics.PhSpriteVector;
import book.openfl.gameStates.PlayState;

import aze.display.TileClip;
import aze.display.TileLayer;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import flash.geom.Point;

// Running man states ===============================================
enum PState {
  Srun;
  Sjump;
  Sfall;
}

class Player {
  var _root:TileLayer;              		// main drawing layer
  public var _x:Int;  
  public var _y:Int;      							// player position
  var _MapState:Map<String,Int>;        // player's states id
  var _vStateClip:Array<TileClip>;  		// states animations
  var _currentState:PState;             // current state
	var  _d_pressed:Bool;
	var  _a_pressed:Bool;
	
  // Builder =====================================================
  public function new(layer:TileLayer, id:String):Void {
    _root = layer;
    _x = 50; 
    _y = 385; 
    _vStateClip = new Array<TileClip>();
    _MapState = new Map<String,Int>();
    _currentState = Srun;

	  _d_pressed = _a_pressed = false;
		
    var i = 0; // loading the animations for each step
    for (value in Type.getEnumConstructs(PState)) {
      var sClip = new TileClip(layer, id + "-" + value);
      _root.addChild(sClip);
      _vStateClip.push(sClip);
      _MapState.set(value, i);
      i++;
    }
    
    updateVisibleClip();
  }
	
	// Working with clips ===============================================
  function getClipIndex(id:PState):Int {
    if (_MapState.exists(Std.string(id))) 
      return (_MapState.get(Std.string(id)));
    return -1;
  }

  function updateVisibleClip():Void {
    for (elem in _vStateClip) {
			#if js
			elem.alpha = 0.0;
			#else
			elem.visible = false;
			#end
		}
  	 	#if js
			_vStateClip[getClipIndex(_currentState)].alpha = 1.0;
			#else
			_vStateClip[getClipIndex(_currentState)].visible = true;
			#end
  }

  // checkCollision ==================================================
  public function checkCollision(box:PhSpriteVector):Bool {
  	if (Math.abs(_x - box.x) < (box.width / 1.5)) { 
      if (Math.abs(_y - box.y) < (box.height / 1.5)) return true;
    }
    return false;
  }

  // Update ==========================================================
  public function update():Void {
    updateVisibleClip();
		
		//---------------------------------------------Y position
		switch (_currentState) { 
			case Srun: //do nothing
			case Sjump:	if (_y > 200) _y-=10; else _currentState = Sfall;
			case Sfall: if (_y < 385) _y+=10; else _currentState = Srun;
		}
		
		//---------------------------------------------X position
		if (_d_pressed) { 
			if (_x < 790) _x += 10; } 
		else 
			if (_a_pressed) if (_x > 0 ) _x -= 8; 
		
    _vStateClip[getClipIndex(_currentState)].x = _x;
    _vStateClip[getClipIndex(_currentState)].y = _y;
  }
  
  // Events ==========================================================
  public function onKeyPressed(event:KeyboardEvent):Void {
  	var delta = 16;
  		switch(event.keyCode){  
				case Keyboard.W: 
					if (_currentState != Sjump && _currentState != Sfall) {
						_currentState = Sjump;
					}
					
				case Keyboard.D: 
					_d_pressed = true;
				case Keyboard.A:
					_a_pressed = true;
				case Keyboard.S:
					if (_currentState == Sjump) _currentState = Sfall;	
					
  		}
  }

	public function onKeyReleased(event:KeyboardEvent) {
		if (event.keyCode == Keyboard.D) _d_pressed = false;
		else if (event.keyCode == Keyboard.A) _a_pressed = false;
	
	}

}


