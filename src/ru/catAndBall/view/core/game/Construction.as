package ru.catAndBall.view.core.game {
	import flash.events.Event;

	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.utils.EverySecond;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;
	import ru.catAndBall.view.core.game.factory.ConstructionViewFactory;
	import ru.catAndBall.view.core.ui.Hint;
	import ru.catAndBall.view.hint.BaseConstructionHint;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 11:49
	 */
	public class Construction extends BaseSprite {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_TOUCH:String = 'eventBuildingTouch';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Construction(data:ConstructionData) {
			super();
			this.data = data;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _view:Image;

		private var _constructing:Boolean = false;

		private var _dropIcon:Image;

		private var _constructIcon:Image;

		private var _hint:DisplayObject;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var data:ConstructionData;

		public var showIfNotAvailable:Boolean = false;

		public function get hint():DisplayObject {
			if (!_hint) {
				_hint = new BaseConstructionHint(data);
			}
			return _hint;
		}

		public function get hintX():int {
			return 100;
		}

		public function get hintY():int {
			return 100;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function dispose():void {
			data.removeEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, handler_buildingComplete);

			EverySecond.removeCallback(updateConstructionTime);
			super.dispose();
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function added(event:* = null):void {
			addEventListener(TouchEvent.TOUCH, this.handler_touch);

			update();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function update(event:Event = null):void {
			_constructing = data.startBuildingTime > 0;

			updateHandlers();

			var txt:Texture = ConstructionViewFactory.getIcon(data);
			if (!_view) {
				_view = new Image(txt);
			} else {
				_view.texture = txt;
			}
			addChild(_view);

			if (_constructing) {
				if (!_constructIcon) {
					_constructIcon = Assets.getImage(AssetList.Room_buildingIcon);
				}

				updateConstructionTime();

				EverySecond.addCallBack(updateConstructionTime);

				_constructIcon.x = _view.width / 2 - _constructIcon.width / 2;
				_constructIcon.y = _view.height / 2 - _constructIcon.height / 2;
				addChild(_constructIcon);
			} else {
				if (_constructIcon && _constructIcon.parent) {
					_constructIcon.parent.removeChild(_constructIcon);
				}

				if (!showIfNotAvailable && !data.visible) {
					_view.visible = false
				} else {
					_view.visible = true;
				}

				EverySecond.removeCallback(updateConstructionTime);

				if (data.canCollectBonus) {
					if (!_dropIcon) {
						_dropIcon = Assets.getImage(AssetList.Room_CollectExpIcon);
						_dropIcon.x = _view.width / 2 - _dropIcon.width / 2;
						_dropIcon.y = _view.height / 2 - _dropIcon.height / 2;
					}
					addChild(_dropIcon);
				} else {
					if (_dropIcon) {
						removeChild(_dropIcon);
					}
				}
			}
		}

		private function updateHandlers():void {
			if (data.startBuildingTime) {
				data.addEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, update);
			} else {
				data.removeEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, update);
			}

			if (data.bonusTimeLeft > 0) {
				data.addEventListener(ConstructionData.EVENT_BONUS_TIME_COMPLETE, update);
			} else {
				if (data.canCollectBonus) {
					data.addEventListener(ConstructionData.EVENT_BONUS_COLLECTED, update);
				} else {
					data.removeEventListener(ConstructionData.EVENT_BONUS_COLLECTED, update);
				}
				data.removeEventListener(ConstructionData.EVENT_BONUS_TIME_COMPLETE, update);
			}
		}

		private function updateConstructionTime():void {

		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_buildingComplete(event:Event):void {
			update(event);
		}

		private function handler_touch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(stage);
			if (touch) {
				if (touch.phase == TouchPhase.BEGAN) {
					var h:DisplayObject = hint;
					// show hint if can't collect bonus only
					if (h && !data.canCollectBonus) {
						Hint.showHint(h, hintX, hintY, this);
					}
					super.dispatchEventWith(EVENT_TOUCH, true);
				} else if (touch.phase == TouchPhase.ENDED) {
					Hint.hide();
				}
			}
		}
	}
}
