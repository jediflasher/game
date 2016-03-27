package ru.catAndBall.view.core.text {
	
	import feathers.controls.LayoutGroup;
	import feathers.core.FeathersControl;
	import feathers.layout.HorizontalLayout;
	
	import ru.catAndBall.AppProperties;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.10.14 10:56
	 */
	public class TextFieldIcon extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const PADDING_H:int = AppProperties.getValue(10, 20);

		private static const PADDING_V:int = AppProperties.getValue(10, 20);

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function TextFieldIcon(textField:BaseTextField, icon:Image = null, background:Image = null, fixedWidth:Number = 0, fixedHeight:Number = 0) {
			super();

			this.textField = textField;
			this.icon = icon;

			_background = background;
			_fixedHeight = fixedHeight;
			_fixedWidth = fixedWidth;

			if (_background) addChild(_background);

			if (this.icon) {
				var l:HorizontalLayout = new HorizontalLayout();
				l.gap = 5;
				l.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
				_layoutGroup = new LayoutGroup();
				_layoutGroup.layout = l;
				_layoutGroup.addChild(this.icon);
				_layoutGroup.addChild(this.textField);

				addChild(_layoutGroup);
			} else {
				addChild(this.textField);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _layoutGroup:LayoutGroup;

		private var _background:DisplayObject;

		private var _fixedHeight:Number = 0;

		private var _fixedWidth:Number = 0;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var textField:BaseTextField;

		public var icon:Image;

		public function get text():String {
			return textField.text;
		}

		public function set text(value:String):void {
			if (textField.text == value) return;

			textField.text = value;
			invalidate(FeathersControl.INVALIDATION_FLAG_SIZE);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_SIZE)) {
				if (_layoutGroup) _layoutGroup.validate();
				textField.validate();

				if (_background) {
					if (_layoutGroup) {
						_layoutGroup.x = PADDING_H;
						_layoutGroup.y = PADDING_V;
					} else {
						textField.x = _background.width / 2 - textField.width / 2;
						textField.y = _background.height / 2 - textField.height / 2;
					}

					if (_fixedWidth >= 0) {
						_background.width = _fixedWidth ? _fixedWidth : _layoutGroup.width + PADDING_H * 2;
					}

					if (_fixedHeight >= 0) {
						_background.height = _fixedHeight ? _fixedHeight : _layoutGroup.height + PADDING_V * 2;
					}
				}

				var resultWidth:Number = _background ? _background.width : _layoutGroup.width;
				var resultHeight:Number = _background ? _background.height : _layoutGroup.height;

				setSizeInternal(resultWidth, resultHeight, false);
			}
		}
	}
}
