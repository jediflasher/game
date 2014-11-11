package ru.catAndBall.view.core.text {
	import feathers.core.FeathersControl;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                06.11.14 19:23
	 */
	public class TextFieldBackground extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function TextFieldBackground(fontId:String, background:Image, fixedWidth:Boolean = false, fixedHeight:Boolean = false, paddingW:Number = 5, paddingH:Number = 5) {

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

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get text():String {
			return _textField.text;
		}

		public function set text(value:String):void {
			if (_textField.text == value) return;

			_textField.text = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _background:Image;

		public function get background():Image {
			return _background;
		}

		public function set background(value:Image):void {
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

				if (_fixedWidth) {
					_textField.x = _background.texture.width / 2 - _textField.width / 2;
				} else {
					_background.width = _textField.width + _paddingW * 2;
					_textField.x = _paddingW;
				}

				if (_fixedHeight) {
					_textField.y = _background.texture.height / 2 - _textField.height / 2;
				} else {
					_background.height = _textField.height + _paddingH * 2;
					_textField.y = _paddingH;
				}
			}

			super.draw();
		}
	}
}
