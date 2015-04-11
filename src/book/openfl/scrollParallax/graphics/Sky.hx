/*********************************************************************
 * Capítulo 3. Tutorial de desarrollo con OpenFL. Scroll Parallax.
 * Sky. Clase de utilidad. Escala un sprite al tamaño total de la capa.
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

import aze.display.TileSprite;
import aze.display.TileLayer;

class Sky extends TileSprite {

  public function new(l:TileLayer, id:String):Void {
    super(l, id); x = 0; y = 0;
  }

  public function update(w:Int, h:Int):Void {
    scaleX = 1; scaleY = 1; 
    scaleX = 2*w / width;   scaleY = 2*h / height;
  }

}
