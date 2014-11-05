//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core {

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;

	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                14.06.14 12:34
	 */
	public class TextureFill extends Image {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		private var _texture:Texture;

		public function TextureFill(bmd:BitmapData, w:Number, h:Number) {
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginBitmapFill(bmd);
			g.drawRect(0, 0, w, h);
			g.endFill();

			var newBmd:BitmapData = new BitmapData(w, h);
			newBmd.draw(s);

			_texture = Texture.fromBitmapData(newBmd, false);
			super(_texture);

			bmd.dispose();
		}
	}
}
