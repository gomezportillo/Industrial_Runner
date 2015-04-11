/*********************************************************************
 * Capítulo 3. Tutorial de desarrollo con OpenFL. Scroll Parallax.
 * Parallax Manager. Clase de utilidad.
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

package book.openfl.scrollParallax.graphics;

import book.openfl.scrollParallax.graphics.Sky;
import book.openfl.scrollParallax.graphics.BackgroundStrip;

import aze.display.TileLayer;

class ParallaxManager {
  var _root:TileLayer;
  var _sky:Sky;    
  var _vBackgroundStrip:Array<BackgroundStrip>;

  // Constructor =====================================================
  public function new(layer:TileLayer) {
    _root = layer;
    _vBackgroundStrip = new Array<BackgroundStrip>();
  }

  // Añadir Elementos ================================================
  public function addSky(id:String) {
    _sky = new Sky(_root, id);
    _root.addChild(_sky);
  }

  public function addBackgroundStrip(id:String, nTiles:Int, fScale:Float, yPos:Int, speed:Float) {
    var bgStrip = new BackgroundStrip(_root, id, nTiles, fScale, yPos, speed);
    _root.addChild(bgStrip); 
    // Solo se puede calcular la posicion de los substrips depues de
    // añadirlos a la capa principal. 
    bgStrip.update();   
    _vBackgroundStrip.push(bgStrip); 
  }

  // Update ==========================================================
  public function update(w:Int, h:Int, eTime:Int):Void {
    _sky.update(w, h);
    for (bgStrip in _vBackgroundStrip) bgStrip.update(w, h, eTime);
  }
  
  public function removeParallax(){
    for (bg in _vBackgroundStrip) _root.removeChild(bg);    
    _root.removeChild(_sky);
  }
  
}
