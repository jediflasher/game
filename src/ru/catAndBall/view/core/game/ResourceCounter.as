package ru.catAndBall.view.core.game {

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
	public class ResourceCounter extends BaseSprite {

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
			size ||= Layout.baseResourceiconSize;

			_resourceType = resourceType;
			_bg = new ResourceImage(resourceType, size);
			addChild(_bg);

			if (resourceSet) {
				_resourceSet = resourceSet;

				var img:Image = Assets.getImage(AssetList.Tools_amount_components_on);
				_tf = new TextFieldBackground(AssetList.font_xsmall_milk_bold, img, true, true);
				_tf.alignPivot();
				_bg.getBounds(_bg, HELPER_RECT);
				_tf.x = size - img.texture.width * 0.75;
				_tf.y = size - img.texture.height * 0.75;
				addChild(_tf);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:ResourceImage;

		private var _resourceType:String;

		private var _resourceSet:ResourceSet;

		private var _tf:TextFieldBackground;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get disabled():Boolean {
			return _bg.disabled;
		}

		public function set disabled(value:Boolean):void {
			_bg.disabled = value;
		}

		private var _gray:Boolean = false;

		public function get gray():Boolean {
			return _gray;
		}

		public function set gray(value:Boolean):void {
			if (_gray == value) return;

			_gray = value;
			if (_tf) _tf.visible = !_gray;

			_bg.gray = _gray;
		}

		private var _isPriceFor:ResourceSet;

		public function get isPriceFor():ResourceSet {
			return _isPriceFor;
		}

		public function set isPriceFor(value:ResourceSet):void {
			if (_isPriceFor === value) return;

			_isPriceFor = value;
			if (stage) added();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		protected override function added(event:* = null):void {
			super.added(event);
			if (_resourceSet) {
				_resourceSet.addEventListener(Event.CHANGE, updateCount);
			}

			if (_isPriceFor) {
				_isPriceFor.addEventListener(Event.CHANGE, updateCount);
			}

			updateCount();
		}

		protected override function removed(event:* = null):void {
			if (_resourceSet) {
				_resourceSet.removeEventListener(Event.CHANGE, updateCount);
			}

			if (_isPriceFor) {
				_isPriceFor.removeEventListener(Event.CHANGE, updateCount);
			}

			super.removed();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateCount(event:Event = null):void {
			if (!_tf) return;

			const count:int = _resourceSet.get(_resourceType);
			_tf.text = String(count);
			_tf.visible = !gray;
			_bg.disabled = count <= 0;

			if (_isPriceFor && _resourceSet) {
				if (_isPriceFor.get(_resourceType) >= count) {
					_tf.background.texture = Assets.getTexture(AssetList.Tools_amount_components_on);
				} else {
					_tf.background.texture = Assets.getTexture(AssetList.Tools_amount_components_off);
				}
			}
		}
	}
}
