//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.utils {
	
	import feathers.display.TiledImage;
	
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                27.06.14 14:16
	 */
	public class Line extends TiledImage {

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

		public function Line() {
			super(Assets.getTexture(AssetList.connection_line_elements));
			useSeparateBatch = false;
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
			var distance:int = Math.ceil(Math.sqrt((toX - fromX) * (toX - fromX) + (toY - fromY) * (toY - fromY)));
			var angle:Number = Math.atan2(toY - fromY, toX - fromX);

			width = distance + 10;
			rotation = angle;
			x = fromX + (toX - fromX) / 2;
			y = fromY + (toY - fromY) / 2;

			alignPivot(HAlign.CENTER, VAlign.CENTER);
		}
	}
}
