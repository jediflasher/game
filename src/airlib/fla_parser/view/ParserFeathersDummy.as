package airlib.fla_parser.view {

	import flash.geom.Rectangle;

	import ru.airlib.util.t;
	import ru.swfReader.descriptors.DisplayObjectDescriptor;

	import starling.core.RenderSupport;
	import starling.display.DisplayObject;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                02.11.2015 19:35
	 */
	public class ParserFeathersDummy extends DisplayObject {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const BOUNDS:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ParserFeathersDummy(source:DisplayObjectDescriptor) {
			super();
			touchable = false;

			if (source is DisplayObjectDescriptor) {
				var dod:DisplayObjectDescriptor = source as DisplayObjectDescriptor;
				var b:Rectangle = dod.getFrameBounds();
				x = t(b.x);
				y = t(b.y);
				width = t(b.width * dod.transform.a);
				height = t(b.height * dod.transform.d);
				name = dod.name;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _width:Number;

		public override function get width():Number {
			return _width;
		}

		public override function set width(value:Number):void {
			if (_width == value) return;

			_width = value;
		}
		
		/**
		 * @private
		 */
		private var _height:Number;
		
		public override function get height():Number {
			return _height;
		}
		
		public override function set height(value:Number):void {
			if (_height == value) return;
			
			_height = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function render(support:RenderSupport, parentAlpha:Number):void {
			// nothing
		}

		public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle {
			BOUNDS.setTo(x, y, width, height);
			return BOUNDS;
		}
	}
}
