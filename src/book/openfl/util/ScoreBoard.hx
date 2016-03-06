/*********************************************************************
* Capítulo 3. Tutorial de desarrollo con OpenFL. Mini-Juego: Bee Adv.
* Clase de Utilidad: Marcador.
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

package book.openfl.util;

import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

class ScoreBoard extends TextField {

  var _score:Int;

  // Builder =====================================================
  public function new(XPos:Int=20, YPos:Int=20, col:Int = 0xFFFFFF, font:String = "_sans"):Void {
    super();
    selectable = false;   // text cannot be selected
    embedFonts = true;    // embed font in flash

    x = XPos; y = YPos;
    font = Assets.getFont (font).fontName;
    var tf:TextFormat = new TextFormat(font, 80, col, true);
    tf.align = TextFormatAlign.CENTER;
    defaultTextFormat = tf;
    _score = 0;
    update();
  }

  // Update ==========================================================
  public function update(delta:Int = 0):Void {
    _score += delta;
    htmlText = Std.string(_score);
  }
}
