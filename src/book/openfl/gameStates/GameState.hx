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
 
package book.openfl.gameStates;

import flash.display.Sprite;
import flash.events.Event;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

class GameState extends Sprite {
  
  private function new () {
    super();
  }
  
  /* States management */
  public function enter  () : Void { }
  public function exit   () : Void { }
  public function pause  () : Void { }
  public function resume () : Void { }

  /* Mouse and keyboard events management */
  public function keyPressed    (event:KeyboardEvent) : Void { }
  public function keyReleased   (event:KeyboardEvent) : Void { }
  public function mouseClicked  (event:MouseEvent)    : Void { } 

  /* Frames management */
  public function frameStarted (event:Event) : Void { }
  public function frameEnded   (event:Event) : Void { }
	
  /* Transition between states */
  public function changeState (state:GameState) : Void { 
    GameManager.getInstance().changeState(state);
  }

  public function pushState (state:GameState) : Void { 
    GameManager.getInstance().pushState(state);
  }

  public function popState () : Void {  
    GameManager.getInstance().popState();
  }
  
}
