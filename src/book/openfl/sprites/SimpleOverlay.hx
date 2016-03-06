/*********************************************************************
* Capítulo 3. Tutorial de desarrollo con OpenFL. Mini-Juego: Bee Adv.
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

package book.openfl.sprites;

import aze.display.TileClip;
import aze.display.TileLayer;

class SimpleOverlay extends TileClip {
  public function new(l:TileLayer, id:String, sx:Int, sy:Int) {
    super(l, id);
    x = sx; y = sy;
  }

  public function update(eTime:Int):Void { }

}
