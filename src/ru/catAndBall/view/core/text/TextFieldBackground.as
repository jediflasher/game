package ru.catAndBall.view.core.text {
	import feathers.core.FeathersControl;

	import flash.geom.Rectangle;

	import starling.display.DisplayObject;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                06.11.14 19:23
	 */
	public class TextFieldBackground extends FeathersControl {

		private static const HELPER_BOUNDS:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function TextFieldBackground(fontId:String, background:DisplayObject, fixedWidth:Boolean = false, fixedHeight:Boolean = false, paddingW:Number = 5, paddingH:Number = 5) {

			super();
			_textField = new BaseTextField(fontId);
			_background = background;
			_fixedWidth = fixedWidth;
			_fixedHeight = fixedHeight;
			_paddingW = paddingW;
			_paddingH = paddingH;

			addChild(_background);
			addChild(_textField);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _textField:BaseTextField;

		private var _fixedWidth:Boolean = false;

		private var _fixedHeight:Boolean = false;

		private var _paddingW:Number = 5;

		private var _paddingH:Number = 5;

		public var bgMinWidth:Number = 0;

		public var bgMinHeigh:Number = 0;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _w:Number = 0;

		public override function get width():Number {
			return _w;
		}

		private var _h:Number = 0;

		public override function get height():Number {
			return _h;
		}

		public function get text():String {
			return _textField.text;
		}

		public function set text(value:String):void {
			if (_textField.text == value) return;

			_textField.text = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _background:DisplayObject;

		public function get background():DisplayObject {
			return _background;
		}

		public function set background(value:DisplayObject):void {
			if (_background === value) return;

			if (_background) removeChild(_background);
			_background = value;
			addChildAt(_background, 0);

			invalidate(INVALIDATION_FLAG_DATA);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_textField.validate();

				var bounds:Rectangle = _textField.getBounds(_textField, HELPER_BOUNDS);
				if (_fixedWidth) {
					_w = 0;
					_textField.x = _background.width / 2 - bounds.width / 2;
				} else {
					_w = Math.max(_textField.width + _paddingW * 2, bgMinWidth);
					_background.width = _w;
					_textField.x = _w / 2 - bounds.width / 2;
				}

				if (_fixedHeight) {
					_textField.y = _background.height / 2 - bounds.height / 2;
					_h = 0;
				} else {
					_h = Math.max(bounds.height + _paddingH * 2, bgMinHeigh);
					_background.height = _h;
					_textField.y = _paddingH;
				}

				if (!_w || !_h) {
					bounds = _background.getBounds(_background, HELPER_BOUNDS);

					if (!_w) _w = bounds.width;
					if (!_h) _h = bounds.height;
				}
			}

			super.draw();
		}
	}
}
