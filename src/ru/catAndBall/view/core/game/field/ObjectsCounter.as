//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {
	
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	
	import feathers.core.FeathersControl;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.layout.Layout;
	
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                14.08.14 22:59
	 */
	public class ObjectsCounter extends FeathersControl {

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

		private var _progressBar:Scale3Image;

		private var _icon:ResourceCounter;

		private var _resourseType:String;

		private var _stackSize:int;

		private var _startY:int;

		private var _vPadding:int;

		private var _mMinHeight:int;

		private var _mMaxHeight:int;

		private var _bgHeight:int;

		private var _overLoad:Boolean = false;

		private const _helperVector:Vector.<int> = new Vector.<int>(2, true);

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			if (!_progressBar) {
				_startY = Layout.baseResourceIconSize * 0.75;

				var t:Texture = Assets.getTexture(AssetList.Panel_components_componentsProgressBg);
				var a:Array = Layout.field.counterBgScaleGridSizes;
				var bg:Scale3Image = new Scale3Image(new Scale3Textures(t, a[0], a[1], Scale3Textures.DIRECTION_VERTICAL));
				bg.smoothing = TextureSmoothing.NONE;
				bg.x = 0;
				bg.y = _startY;
				bg.height = Layout.field.counterBgHeight;
				addChild(bg);

				const bgWidth:Number = bg.textures.texture.width;
				_bgHeight = Layout.field.counterBgHeight;

				t = Assets.getTexture(AssetList.Panel_components_milkProgress);
				a = Layout.field.counterMilkScaleGridSizes;
				_progressBar = new Scale3Image(new Scale3Textures(t, a[0], a[1], Scale3Textures.DIRECTION_VERTICAL));
				_progressBar.smoothing = TextureSmoothing.NONE;
				addChild(_progressBar);

				_vPadding = (_bgHeight - Layout.field.counterProgressMaxHeight) / 2;
				_mMinHeight = _progressBar.textures.texture.height;
				_mMaxHeight = Layout.field.counterProgressMaxHeight - _mMinHeight;

				getValuesByProgress(0);
				_progressBar.x = (bgWidth - _progressBar.textures.texture.width) / 2;
				_progressBar.y = _helperVector[0];
				_progressBar.height = _helperVector[1];

				_icon = new ResourceCounter(_resourseType, _resourceSet);
				addChild(_icon);
			}

			_resourceSet.addEventListener(Event.CHANGE, handler_countChange);

			updateProgress();
		}


		override protected function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				_icon.validate();
				_progressBar.validate();
				setSizeInternal(_icon.width, _progressBar.y + _progressBar.height, false);
			}
		}

		protected override function feathersControl_removedFromStageHandler(event:Event):void {
			super.feathersControl_removedFromStageHandler(event);

			_resourceSet.removeEventListener(Event.CHANGE, updateProgress);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateProgress(event:* = null):void {
			if (!stage) return;

			const progress:Number = ((_stackSize + _stack) % _stackSize) / _stackSize;

			if (_overLoad && progress >= 0 && progress < 1) {
				// сначала прогрессбар доедет до полного значения,затем сбросится в 0 и поедет к текущему
				getValuesByProgress(1);
				TweenNano.to(_progressBar, 0.3, {
					height: _helperVector[1],
					y: _helperVector[0],
					ease: Linear.easeNone,
					onComplete: overloadComplete
				});
				_overLoad = false;
			} else {
				getValuesByProgress(progress);
				TweenNano.to(_progressBar, 0.3, {height: _helperVector[1], y: _helperVector[0], ease: Linear.easeNone});
			}
		}

		private function overloadComplete():void {
			getValuesByProgress(0);
			_progressBar.y = _helperVector[0];
			_progressBar.height = _helperVector[1];
			updateProgress();
		}

		private function getValuesByProgress(progress:Number):Vector.<int> {
			_helperVector[1] = _mMaxHeight * progress + _mMinHeight; // height;
			_helperVector[0] = _startY + _bgHeight - _vPadding - _helperVector[1]; // y
			return _helperVector;
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------

		private function handler_countChange(event:*):void {
			_overLoad = true;
		}
	}
}
