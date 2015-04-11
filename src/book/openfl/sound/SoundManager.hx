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

package book.openfl.sound;

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.Assets;

// Clase encargada de la gestión del sonido.
class SoundManager {

  // Variable estática para implementar Singleton.
  public static var _instance:SoundManager;
  
  private var _backgroundMusic:Sound; // Música de fondo.
  private var _channel:SoundChannel;  // Canal de la música de fondo.
  private var _volume:Float;          // Nivel de volumen.
  private var _balance:Float;         // Nivel de balance.

  private function new () {
    _backgroundMusic = null;
    _channel = null;
    _volume = 1.0;
    _balance = 0.0;
  }

  // Patrón Singleton.
  public static function getInstance () : SoundManager {
    if (SoundManager._instance == null)
      SoundManager._instance = new SoundManager();
    return SoundManager._instance;
  }

  // Carga de sonido =================================================

  public function loadBackgroundMusic (url:String) : Void {
    _backgroundMusic = Assets.getSound(url);
  }

  public function playBackgroundMusic () : Void {
    // Reproducción de la música de fondo.
    _channel = _backgroundMusic.play();
    // Retrollamada para efecto loop.
    _channel.addEventListener(Event.SOUND_COMPLETE, 
			      channel_onSoundComplete);
  }

  public function stopBackgroundMusic () : Void {
    if (_channel != null) {
      _channel.removeEventListener(Event.SOUND_COMPLETE, 
				   channel_onSoundComplete);
      _channel.stop();
      _channel = null;
    }
  }

  // Reproducción de efecto de sonido puntual.
  public function playSoundEffect (url:String) : Void {
    var soundFX = openfl.Assets.getSound(url);
    // Sound Transform para conservar volumen y balance.
    soundFX.play(0, 0, new SoundTransform(_volume, _balance));
  }

  // Control de sonido ===============================================

  public function setVolume (volume:Float) : Void {
    _volume = volume > 1 ? 1 : volume;
    if (_channel != null) {
      _channel.soundTransform = new SoundTransform(_volume, _balance);
    }
  }

  public function getVolume () : Float {    
    return _volume;
  }

  public function turnVolumeUp (delta:Float = 0.1) : Void {
    setVolume(_volume + delta);
  }

  public function turnVolumeDown (delta:Float = 0.1) : Void {
    setVolume(_volume - delta);
  }

  public function mute () : Void {
    setVolume(0.0);
    if (_channel != null) {
      _channel.removeEventListener(Event.SOUND_COMPLETE, 
				   channel_onSoundComplete);
    }
  }

  public function unmute () : Void {
    setVolume(1.0);
    if (_channel != null) {
      _channel.addEventListener(Event.SOUND_COMPLETE, 
				channel_onSoundComplete);
    }
  }

  public function isMuted () : Bool {
    return _volume == 0.0;
  }

  // Control de balance ==============================================

  public function setBalance (balance:Float) : Void {
    _balance = balance;
    if (_channel != null) {
      _channel.soundTransform = new SoundTransform(_volume, _balance);
    }
  }

  public function getBalance () : Float {
    return _balance;
  }

  public function increaseRightBalance (delta:Float = 0.1) : Void {
    if (_balance + delta <= 1.0)
      setBalance(_balance + delta);
  }

  public function increaseLeftBalance (delta:Float = 0.1) : Void {
    if (_balance - delta >= -1.0)
      setBalance(_balance - delta);
  }

  // Listeners =======================================================

  private function channel_onSoundComplete (event:Event) {
    playBackgroundMusic();
  }

}
