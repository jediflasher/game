//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.utils {
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                25.06.14 15:05
	 */
	public class Pointer extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static var _bitmapData:BitmapData;

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function Pointer(x:Number = 0, y:Number = 0, text:String = null) {
			super();

			if (!_bitmapData) {
				var s:Shape = new Shape();
				var g:Graphics = s.graphics;
				g.lineStyle(1);
				g.beginFill(0xFFFFFF, 0.6);
				g.drawCircle(6, 6, 6);
				g.endFill();
				g.moveTo(6, 0);
				g.lineTo(6, 12);
				g.moveTo(0, 6);
				g.lineTo(12, 6);

				_bitmapData = new BitmapData(s.width, s.height, true, 0x00000000);
				_bitmapData.draw(s);
			}

			_pt = new Image(Texture.fromBitmapData(_bitmapData));
			_pt.alignPivot(HAlign.CENTER, VAlign.CENTER);
			addChild(_pt);

			text ||= x + ', ' + y;
			_tf = new TextField(40, 20, text);
			addChild(_tf);

			_tf.x = -_tf.width / 2;
			_tf.y = _pt.height + 2;

			this.x = x;
			this.y = y;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _pt:Image;

		private var _tf:TextField;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function dispose():void {
			super.dispose();

			_tf.dispose();
			_pt.dispose();
		}
	}
}
