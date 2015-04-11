/*********************************************************************
 * Capítulo 3. Tutorial de desarrollo con OpenFL. Scroll Parallax.
 * BackgroundStrip. Clase de utilidad.
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

import aze.display.TileGroup;
import aze.display.TileSprite;
import aze.display.TileLayer;

class BackgroundStrip extends TileGroup {
  var _vbgTiles:Array<TileSprite>;   // Array de sprites que forman el Grupo
  public var _yPos:Int;              // Posicion en vertical (desde borde inferior)
  public var _speed:Float;           // Velocidad del Scroll

  public function new(l:TileLayer, id:String, nTiles:Int, fScale:Float, yPos:Int, speed:Float) {
    super(l);
    this._yPos = yPos;  this._speed = speed;
    _vbgTiles = new Array<TileSprite>();
    for (i in 0...nTiles) {  // Añadimos los subtrips sin posicionarlos
      var bgTile = new TileSprite(l, id);
      bgTile.scale = fScale;
      addChild(bgTile);
      _vbgTiles.push(bgTile);
    }
  }
  
  public function update(w:Int=0, h:Int=0, eTime:Int=0):Void {
      var pos:Int;
      
    if(_speed >= 0) {
      
       if (eTime == 0) {   // Inicializacion de los substrips
          for (i in 0..._vbgTiles.length) {
         	if (i == 0) pos = Std.int(_vbgTiles[i].width / 2.0);
         	else pos = Std.int(_vbgTiles[i-1].x + _vbgTiles[i-1].width);
         	_vbgTiles[i].x = pos;
          }
        }
        else { // Actualización del strip (general) 
          x -= (eTime / 1000.0) * _speed;   
          if (x < -width / _vbgTiles.length) x = 0;
        }
        y = h - _yPos;
    
    }else { //si la velocidad es negativa va hacia la derecha, y hay que reiniciarlo como tal
    
    
    //lo que hay que hacer al inicilizarlo (si v<0) es hacer que sea la 2º imagen la que empiece primero
     if (eTime == 0) {   // Inicializacion de los substrips
        for (i in 0..._vbgTiles.length) {
         	if (i == 0) pos = Std.int(_vbgTiles[i].width);
         	else pos = Std.int(_vbgTiles[i-1].x - _vbgTiles[i-1].width);
         	_vbgTiles[i].x = pos;
          }
        }
        else { // Actualización del strip (general) 
          x -= (eTime / 1000.0) * _speed;   
          if (x > width / _vbgTiles.length) x = 0;
        }
        
   y = h - _yPos;
         
}
}
}
