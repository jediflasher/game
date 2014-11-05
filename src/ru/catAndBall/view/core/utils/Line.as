//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.utils {

	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                27.06.14 14:16
	 */
	public class Line extends Image {

		private static const HASH:Object = {}; // width_color -> Texture

		private static function getTexture(color:int, thickness:int):Texture {
			var key:String = thickness + '_' + color.toString(16);
			if (!(key in HASH)) {
				HASH[key] = Texture.fromColor(1, thickness, color);
			}

			return HASH[key];
		}

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function Line(color:int, thickness:int) {
			super(getTexture(color, thickness));
			smoothing = TextureSmoothing.NONE;
			_color = color;
			_thickness = thickness;
			alignPivot(HAlign.CENTER, VAlign.CENTER);
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _color:int;

		private var _thickness:int;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function draw(fromX:int, fromY:int, toX:int, toY:int):void {
			var distance:int = Math.sqrt((toX - fromX) * (toX - fromX) + (toY - fromY) * (toY - fromY));
			var angle:Number = Math.atan2(toY - fromY, toX - fromX);

			width = distance;
			rotation = angle;
			x = fromX + (toX - fromX) / 2;
			y = fromY + (toY - fromY) / 2;

			alignPivot(HAlign.CENTER, VAlign.CENTER);
		}
	}
}
