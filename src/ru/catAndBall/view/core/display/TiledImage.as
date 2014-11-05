//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.display {

	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 15:52
	 */
	public class TiledImage extends QuadBatch {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function TiledImage(texture:Texture, width:Number = NaN, height:Number = NaN) {
			super();
			touchable = false;

			_texture = texture;
			width = width || _texture.width;
			height = height || _texture.height;

			setTo(width, height);
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _width:Number;

		public override function get width():Number {
			return _width;
		}

		public override function set width(value:Number):void {
			if (_width == value) return;

			_width = value;
			update();
		}

		private var _height:Number;

		public override function get height():Number {
			return _height;
		}

		public override function set height(value:Number):void {
			if (_height == value) return;

			_height = value;
			update();
		}

		private var _realWidth:Number = 0;

		public function get realWidth():Number {
			return _realWidth;
		}

		private var _realHeight:Number = 0;

		public function get realHeight():Number {
			return _realHeight;
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _texture:Texture;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public function setTo(width:Number, height:Number):void {
			if (_width == width && _height == height) return;

			_width = width;
			_height = height;

			update();
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function update():void {
			reset();

			var x:int = 0;
			var y:int = 0;

			var xStep:Number = _texture.width;
			var yStep:Number = _texture.height;

			while (y < _height - 1) {
				x = 0;
				while (x < _width - 1) {
					var img:Image = new Image(_texture);
					img.x = x;
					img.y = y;
					addImage(img);
					x += xStep - 0.1;
				}
				y += yStep - 0.1; // to prevent float overflow
			}

			_realWidth = x;
			_realHeight = y;
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
