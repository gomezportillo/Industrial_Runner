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

package book.openfl.scrollParallax;

import book.openfl.scrollParallax.graphics.ParallaxManager;
import book.openfl.sound.SoundManager;

import aze.display.TileLayer;
import aze.display.SparrowTilesheet;

import flash.system.Capabilities;
import openfl.Assets;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLRequest;

class ParallaxMenu extends Sprite {

  var parallaxManager:ParallaxManager;
  var layer:TileLayer;
  var previousTime:Int;
  var sheetData:String;

  // Constructor =====================================================
  public function new() {
    super();
    haxe.Timer.delay(init, 150);
  }

  function init():Void {
    //createScene();
    #if js
    // workaround for binary data loading bug in html5
    var ul = new URLLoader(new URLRequest("img/parallax_menu/Parallas_menu.xml"));
    ul.addEventListener(Event.COMPLETE, ul_complete);
    #else
    sheetData = Assets.getText("img/parallax_menu/Parallax_menu.xml");
    createScene();
    loadMusic();
    #end

  }

  function ul_complete(e) {
    sheetData = e.target.data;
    createScene();
    loadMusic();
  }

  // Scene creation ===========================================
  function createScene():Void {

    /*var dpi = Capabilities.screenDPI;
    var zoom:Float=0;

    if (dpi < 200) zoom = 1;
    else if (dpi < 300) zoom = 1.5;
    else zoom = 2; */

    var zoom = 1;
    var tilesheet:SparrowTilesheet = new SparrowTilesheet (Assets.getBitmapData("img/parallax_menu/Parallax_menu.png"), sheetData);
    layer = new TileLayer(tilesheet);
    addChild(layer.view);

    parallaxManager = new ParallaxManager(layer);
    parallaxManager.addSky("sky");			//name, ?, zoom, ypos, veloc)
    parallaxManager.addBackgroundStrip("metal-background", 4, zoom, 200, 10);
    parallaxManager.addBackgroundStrip("strip", 4, zoom, 50, -10);
    parallaxManager.addBackgroundStrip("strip", 4, zoom, 450, -10);

    addListeners();
  }

  // Main loop =================================================
  function mainLoop(eTime:Int):Void {
    parallaxManager.update(stage.stageWidth, stage.stageHeight, eTime);
    layer.render();
  }

  // Listeners =======================================================
  function addListeners():Void {
    stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    previousTime = Lib.getTimer();
  }

  function onEnterFrame(event:Event):Void {
    var now = Lib.getTimer();
    var elapsedTime = now - previousTime;
    previousTime = now;
    mainLoop(elapsedTime);
  }

  // Music ===========================================================
  public function loadMusic () {
    #if !flash
    SoundManager.getInstance().loadBackgroundMusic("music/the_spanish_ninja.ogg");
    #else
    SoundManager.getInstance().loadBackgroundMusic("music/the_spanish_ninja.mp3");
    #end
    SoundManager.getInstance().playBackgroundMusic();
  }

  public function stopMusic(){
    SoundManager.getInstance().stopBackgroundMusic();
  }
}
