/*********************************************************************
 * Capítulo 3. Tutorial de desarrollo con OpenFL. Simulación Física.
 * PhSprite. Clase de utilidad. Sprite con propiedades Físicas.
 * Programación Multimedia y Juegos
 * Autor: David Vallejo Fernández    david.vallejo@openflbook.com
 * Autor: Carlos González Morcillo   carlos.gonzalez@openflbook.com
 * Autor: David Frutos Talavera      david.frutos@openflbook.com
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

package book.openfl.physics;

import aze.display.TileSprite;
import aze.display.TileLayer;

import phx.World;
import phx.Body;
import phx.Shape;
import phx.Circle;
import phx.Vector;

class PhSpriteVector extends TileSprite {
  var _root:TileLayer;   // layer where the sprite will be drawn
  var _world:World;      // physical simulation world
  var _body:Body;        // physical simuñation body associated to the sprite
  var previous_x:Float;


  public function new(id:String, l:TileLayer, w:World, px:Float,  py:Float,  ?vect:phx.Vector):Void {
    super(l, id); 
    _root = l; _world = w; 
    x = px; y = py; 
    
    _root.addChild(this);   			// add the sprite to the drawn layer
    _body = new Body(x,y);  			// creating the physical simulation body
    scale = 1 + Std.random(2);   	// size bewteen 1 and 2
    
    if(id == "box")   _body.addShape(Shape.makeBox(width, height));
        else          _body.addShape(new phx.Circle(width/2.0, new phx.Vector(0,0)));
    
     _body.w = -0.25;   					// angular velocity
     _body.v = vect;
     _body.a = (Math.PI / 90.0); 	//rotation  

    _body.updatePhysics();			  // body update
    _world.addBody(_body);  			// adding the body to the world
 
  }

	public function destroy():Void {
    _world.removeBody(_body);
    _root.removeChild(this);    
  }
  
  // Update =======================================================
  public function update(w:Int, h:Int):Void { //1.4
    if (previous_x - _body.x < 9 ) 
    	_body.x = x = x - 9;
    else 
    	x =_body.x; 
      
    y =_body.y;               
    rotation = _body.a;      
    _body.updatePhysics();    
    previous_x = x;
  }

}

