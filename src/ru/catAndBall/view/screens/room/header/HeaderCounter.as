package ru.catAndBall.view.screens.room.header {
	
	import feathers.core.FeathersControl;
	
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.BaseTextField;
	
	import starling.display.Image;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                31.01.15 15:25
	 */
	public class HeaderCounter extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function HeaderCounter(background:String, icon:String) {
			super();

			this._iconId = icon;
			this._bgId = background;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _iconId:String;

		private var _bgId:String;

		private var _icon:Image;

		private var _bg:Image;

		private var _text:BaseTextField;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _value:int;

		public function get value():int {
			return _value;
		}

		public function set value(value:int):void {
			if (_value == value) return;

			_value = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _length:int = 4;

		public function get length():int {
			return _length;
		}

		public function set length(value:int):void {
			_length = value;
		}

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

		protected override function initialize():void {
			super.initialize();

			_bg = Assets.getImage(_bgId);
			addChild(_bg);

			_icon = Assets.getImage(_iconId, 76, 76);
			addChild(_icon);

			_text = new BaseTextField(AssetList.font_medium_green);
			addChild(_text);
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				this.updateText();
			}

			if (isInvalid(INVALIDATION_FLAG_LAYOUT)) {
				_icon.x = 18;
				_icon.y = _bg.texture.height / 2 - _icon.height / 2 - 5;

				_text.validate();
				_text.x = _icon.x + _icon.width + 2;
				_text.y = _bg.texture.height / 2 - _text.height / 2;
			}

			super.setSizeInternal(_bg.texture.width, _bg.texture.height, false);
			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateText():void {
			var str:String = String(_value);

			while (str.length < _length) {
				str = '0' + str;
			}

			_text.text = str;
		}
	}
}
