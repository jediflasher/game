package ru.catAndBall.view.core.ui {
	
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.layout.Layout;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 17:40
	 */
	public class Hint extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static var layer:DisplayObjectContainer;

		private static var instance:Hint;

		private static var _hint:DisplayObject;

		private static var _startX:int;

		private static var _startY:int;

		private static const RECT:Rectangle = new Rectangle(60, 60, 130, 94);

		private static const HELPER_POINT:Point = new Point();

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function showHint(content:DisplayObject, x:Number, y:Number, localCoordinateSpace:DisplayObject = null):void {
			if (!instance) instance = new Hint();

			HELPER_POINT.setTo(x, y);

			if (localCoordinateSpace) localCoordinateSpace.localToGlobal(HELPER_POINT, HELPER_POINT);

			_startX = HELPER_POINT.x;
			_startY = HELPER_POINT.y;

			instance.setContent(content);
			show(instance);
		}

		public static function show(hint:DisplayObject):void {
			_hint = hint;
			layer.addChild(_hint);
		}

		public static function hide():void {
			if (!_hint) return;

			_hint.parent.removeChild(_hint);
			_hint = null;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Hint() {
			super();

			var s9t:Scale9Textures = new Scale9Textures(Assets.getTexture('hintBg'), RECT);
			_bg = new Scale9Image(s9t);
			addChild(_bg);

			_tail = Assets.getImage('angle');
			addChild(_tail);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:Scale9Image;

		private var _tail:Image;

		private var _content:DisplayObject;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				var marginX:Number = RECT.x;
				var marginY:Number = RECT.y;

				if (_content is FeathersControl) {
					FeathersControl(_content).validate();
				}
				_content.x = marginX;
				_content.y = marginY;

				var b:Rectangle = _content.getBounds(_content);

				_bg.width = b.width + (marginX * 2);
				_bg.height = b.height + (marginY * 2);
				_bg.validate();

				_tail.x = _bg.width / 2 - _tail.width / 2;
				_tail.y = _bg.height - 41;

				var baseX:Number = Hint._startX - _bg.width / 2;

				var minX:Number = AppProperties.viewRect.x + Layout.baseGap;
				var maxX:Number = AppProperties.viewRect.right - _bg.width - Layout.baseGap;

				if (baseX < minX) {
					_tail.x -= minX - baseX;
					baseX = AppProperties.viewRect.x + Layout.baseGap;
				} else if (baseX > maxX) {
					_tail.x += baseX - maxX;
					baseX = maxX;
				}

				instance.validate();
				instance.x = baseX;
				instance.y = Hint._startY - _bg.height;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function setContent(content:DisplayObject):void {
			if (_content && _content !== content) removeChild(_content);

			_content = content;
			addChild(_content);

			_bg.x = 0;
			_bg.y = 0;

			invalidate(FeathersControl.INVALIDATION_FLAG_LAYOUT);
		}
	}
}
