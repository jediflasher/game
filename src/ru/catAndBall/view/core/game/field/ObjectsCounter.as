//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {

	import com.greensock.TweenNano;

	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import flash.events.Event;

	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.layout.Layout;

	import starling.textures.Texture;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                14.08.14 22:59
	 */
	public class ObjectsCounter extends BaseSprite {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ObjectsCounter(resourceSetType:String, resourceSet:ResourceSet, stackSize:int) {
			super();
			_resourseType = resourceSetType;
			_resourceSet = resourceSet;
			_stackSize = stackSize;
			touchable = false;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _resourceSet:ResourceSet;

		public function get resourceSet():ResourceSet {
			return _resourceSet;
		}

		private var _stack:int = 0;

		public function get stack():int {
			return _stack;
		}

		public function set stack(value:int):void {
			if (_stack == value) return;

			_stack = value;
			updateProgress();
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _resourseType:String;

		private var _stackSize:int;

		private var _maxHeight:Number;

		private var _progressBar:Scale3Image;

		private var _icon:ResourceCounter;

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		protected override function added(event:* = null):void {
			if (!_progressBar) {
				var t:Texture = Assets.getTexture(AssetList.Panel_components_components_level_bg);
				var a:Array = Layout.fieldCounterBgScaleGridSizes;
				var bg:Scale3Image = new Scale3Image(new Scale3Textures(t, a[0], a[1], Scale3Textures.DIRECTION_VERTICAL));
				bg.x = 0;
				bg.y = 0;
				bg.height = Layout.fieldCounterBgHeight;
				addChild(bg);

				const bgWidth:Number = bg.textures.texture.width;
				const bgHeight:Number = bg.textures.texture.height;
				_maxHeight = bgHeight * 0.9;

				t = Assets.getTexture(AssetList.Panel_components_milk2);
				a = Layout.fieldCounterMilkScaleGridSizes;
				_progressBar = new Scale3Image(new Scale3Textures(t, a[0], a[1], Scale3Textures.DIRECTION_VERTICAL));
				_progressBar.pivotY = _progressBar.textures.texture.height;
				_progressBar.x = (bgWidth - _progressBar.textures.texture.width) / 2;
				_progressBar.y = _maxHeight;
				addChild(_progressBar);

				_icon = new ResourceCounter(_resourseType);
				addChild(_icon);
			}

			_resourceSet.addEventListener(Event.CHANGE, updateProgress);

			updateProgress();
		}

		protected override function removed(event:* = null):void {
			_resourceSet.removeEventListener(Event.CHANGE, updateProgress);
			super.removed(event);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateProgress(event:* = null):void {
			if (!stage) return;

			const progress:Number = ((_stackSize + _stack) % _stackSize) / _stackSize;
			TweenNano.to(_progressBar, 0.2, {height: _maxHeight * progress});
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
