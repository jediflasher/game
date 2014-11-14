package ru.catAndBall.view.core.game {

	import feathers.core.FeathersControl;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import flash.events.Event;
	import flash.geom.Rectangle;

	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;
	import ru.catAndBall.view.core.text.TextFieldBackground;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                12.10.14 19:38
	 */
	public class ResourceCounter extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const HELPER_RECT:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceCounter(resourceType:String, resourceSet:ResourceSet = null, size:int = 0) {
			super();
			size ||= Layout.baseResourceIconSize;

			_resourceType = resourceType;
			_size = size;
			_icon = new ResourceImage(resourceType, _size);
			addChild(_icon);

			if (resourceSet) {
				_resourceSet = resourceSet;

				_brownTextures = new Scale3Textures(Assets.getTexture(AssetList.Tools_amount_components_on), 33, 5);
				_redTextures = new Scale3Textures(Assets.getTexture(AssetList.Tools_amount_components_off), 33, 5);

				var img:Scale3Image = new Scale3Image(_brownTextures);
				_tf = new TextFieldBackground(AssetList.font_xsmall_milk_bold, img, false, true, 15);
				_tf.bgMinWidth = _brownTextures.texture.width;
				addChild(_tf);

				updateCount();
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _icon:ResourceImage;

		private var _resourceType:String;

		private var _resourceSet:ResourceSet;

		private var _tf:TextFieldBackground;

		private var _brownTextures:Scale3Textures;

		private var _redTextures:Scale3Textures;

		private var _size:int;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get disabled():Boolean {
			return _icon.disabled;
		}

		public function set disabled(value:Boolean):void {
			_icon.disabled = value;
		}

		private var _gray:Boolean = false;

		public function get gray():Boolean {
			return _gray;
		}

		public function set gray(value:Boolean):void {
			if (_gray == value) return;

			_gray = value;
			if (_tf) _tf.visible = !_gray;

			_icon.gray = _gray;
		}

		private var _isPriceFor:ResourceSet;

		public function get isPriceFor():ResourceSet {
			return _isPriceFor;
		}

		public function set isPriceFor(value:ResourceSet):void {
			if (_isPriceFor === value) return;

			if (_isPriceFor) _isPriceFor.removeEventListener(Event.CHANGE, updateCount);
			_isPriceFor = value;
			if (_isPriceFor) _isPriceFor.addEventListener(Event.CHANGE, updateCount);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();
			if (_resourceSet) {
				_resourceSet.addEventListener(Event.CHANGE, updateCount);
			}

			if (_isPriceFor) {
				_isPriceFor.addEventListener(Event.CHANGE, updateCount);
			}
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				const count:int = _resourceSet.get(_resourceType);
				_tf.text = String(count < 0 ? 0 : count);
				_tf.visible = !gray;
				_icon.disabled = count <= 0;

					if (_isPriceFor && _resourceSet && _isPriceFor.get(_resourceType) >= count) {
						if (_tf.background is Image) {
							(_tf.background as Scale3Image).textures = _brownTextures
						}
					} else if (count < 0) {
						if (_tf.background is Image) {
							(_tf.background as Scale3Image).textures = _redTextures;
						}
					}

				_tf.validate();

				_tf.x = _size - _tf.width * 0.75;
				_tf.y = _size - _tf.height * 0.75;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateCount(event:Event = null):void {
			if (!_tf) return;

			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
