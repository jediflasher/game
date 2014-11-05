package ru.catAndBall.view.core.ui {
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

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

		private static const MARGIN_HD:int = 50;

		private static const MARGN_LD:int = 30;

		private static const RECT_HD:Rectangle = new Rectangle(121, 120, 120, 23);

		private static const RECT_LD:Rectangle = new Rectangle(121, 120, 120, 23);

		private static var instance:Hint;

		private static var _hint:DisplayObject;

		private static var _startX:int;

		private static var _startY:int;

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function showHint(content:FeathersControl, mouseX:int, mouseY:int):void {
			if (!instance) instance = new Hint();

			_startX = mouseX;
			_startY = mouseY;

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

			var s9t:Scale9Textures = new Scale9Textures(Assets.getTexture(AssetList.hint_hint_bg), AppProperties.getValue(RECT_HD, RECT_LD));
			_bg = new Scale9Image(s9t);
			addChild(_bg);

			alignPivot();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:Scale9Image;

		private var _content:FeathersControl;

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
				var margin:Number = AppProperties.getValue(MARGIN_HD, MARGN_LD);

				_content.validate();
				_content.x = margin;
				_content.y = margin;

				_bg.width = _content.width + (margin * 2);
				_bg.height = _content.height + (margin * 2);
				_bg.validate();

				instance.x = Hint._startX - _bg.width / 2;
				instance.y = Hint._startY - 200;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function setContent(content:FeathersControl):void {
			if (_content && _content !== content) removeChild(_content);

			_content = content;
			addChild(_content);

			_bg.x = 0;
			_bg.y = 0;

			invalidate(FeathersControl.INVALIDATION_FLAG_LAYOUT);
		}
	}
}
