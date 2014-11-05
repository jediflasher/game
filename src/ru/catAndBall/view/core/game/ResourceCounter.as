package ru.catAndBall.view.core.game {

	import flash.events.Event;

	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	import ru.catAndBall.view.core.text.TextFieldTest;

	import starling.display.Image;

	import starling.display.Image;

	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.textures.Texture;

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
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceCounter(resourceType:String, resourceSet:ResourceSet = null) {
			super();
			_resourceType = resourceType;
			_bg = new ResourceImage(resourceType);
			addChild(_bg);

			if (resourceSet) {
				_resourceSet = resourceSet;

				_tf = new TextFieldIcon(new BaseTextField(AssetList.font_xsmall_milk_bold), null, Assets.getImage(AssetList.Tools_amount_components_on));
				_tf.alignPivot();
				_tf.x = _bg.width;
				_tf.y = _bg.height;
				addChild(_tf);
			}

			updateCount();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:ResourceImage;

		private var _resourceType:String;

		private var _resourceSet:ResourceSet;

		private var _tf:TextFieldIcon;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

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
		}

		protected override function removed(event:* = null):void {
			if (_resourceSet) {
				_resourceSet.removeEventListener(Event.CHANGE, updateCount);
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
			_bg.disabled = count <= 0;
		}
	}
}
