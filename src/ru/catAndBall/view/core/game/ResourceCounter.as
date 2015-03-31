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

				_brownTextures = new Scale3Textures(Assets.getTexture(AssetList.ToolsOption_numderComponentsGreen), 33, 5);
				_redTextures = new Scale3Textures(Assets.getTexture(AssetList.ToolsOption_numderComponentsRed), 33, 5);

				var img:Scale3Image = new Scale3Image(_brownTextures);
				_tf = new TextFieldBackground(AssetList.font_small_white_greenstroke, img, false, true, 15);
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

		private var _minResources:ResourceSet;

		/**
		 * Если текущее значение меньше этого, будет загораться красный
		 */
		public function get minResources():ResourceSet {
			return _minResources;
		}

		public function set minResources(value:ResourceSet):void {
			if (_minResources === value) return;

			if (_minResources) _minResources.removeEventListener(Event.CHANGE, updateCount);
			_minResources = value;
			if (_minResources) _minResources.addEventListener(Event.CHANGE, updateCount);
		}

		private var _maxResources:ResourceSet;

		/**
		 * * Если текущее значение больше этого, будет загораться красный
		 */
		public function get maxResources():ResourceSet {
			return _maxResources;
		}

		public function set maxResources(value:ResourceSet):void {
			if (_maxResources === value) return;

			if (_maxResources) _maxResources.removeEventListener(Event.CHANGE, updateCount);
			_maxResources = value;
			if (_maxResources) _maxResources.addEventListener(Event.CHANGE, updateCount);
		}

		private var _disableOnZero:Boolean = true;

		public function get disableOnZero():Boolean {
			return _disableOnZero;
		}

		public function set disableOnZero(value:Boolean):void {
			if (_disableOnZero == value) return;

			_disableOnZero = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		public function get count():int {
			return _resourceSet.get(_resourceType);
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

			if (_minResources) {
				_minResources.addEventListener(Event.CHANGE, updateCount);
			}
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_tf.text = String(count);//String(count < 0 ? 0 : count);
				_tf.visible = !gray;
				_icon.disabled = _disableOnZero && count <= 0;

				var minValue:int = _minResources ? _minResources.get(_resourceType) : int.MIN_VALUE;
				var maxValue:int = _maxResources ? _maxResources.get(_resourceType) : int.MAX_VALUE;

				if (count >= minValue && count <= maxValue) {
					if (_tf.background is Scale3Image) {
						(_tf.background as Scale3Image).textures = _brownTextures
					}
				} else  {
					if (_tf.background is Scale3Image) {
						(_tf.background as Scale3Image).textures = _redTextures;
					}
				}

				_tf.validate();

				_tf.x = _size - _tf.width * 0.75;
				_tf.y = _size - _tf.height * 0.75;

				setSizeInternal(_size + _tf.width * 0.75, _size + _tf.height * 0.75, false);
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
