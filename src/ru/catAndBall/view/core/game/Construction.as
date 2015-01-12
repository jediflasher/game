package ru.catAndBall.view.core.game {
	import feathers.controls.Button;
	import feathers.core.FeathersControl;

	import flash.events.Event;

	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.utils.SecondsTimer;
	import ru.catAndBall.utils.TimeUtil;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.TextFieldTest;
	import ru.catAndBall.view.core.ui.Hint;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
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
	public class Construction extends Sprite {

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

		public function Construction(data:ConstructionData, assetId:String) {
			super();
			this.data = data;
			_assetId = assetId;

			init();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _assetId:String;

		private var _view:Image;

		private var _constructing:Boolean = false;

		private var _constructionTextField:TextFieldTest;

		private var _constructionProgress:MovieClip;

		private var _attentionIcon:Image;

		private var _hint:FeathersControl;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var data:ConstructionData;

		public function get hint():FeathersControl {
			if (!_hint) {
				_hint = new FeathersControl();
				_hint.addChild(new Image(Assets.DUMMY_TEXTURE_2));
			}
			return _hint;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function init():void {
			addEventListener(TouchEvent.TOUCH, this.handler_touch);

			update();
		}

		public override function dispose():void {
			data.removeEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, handler_buildingComplete);
			if (_constructing) Starling.juggler.remove(_constructionProgress);

			SecondsTimer.removeCallback(updateConstructionTime);
			super.dispose();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function update(event:Event = null):void {
			_constructing = data.startBuildingTime > 0;

			updateHandlers();

			if (_constructing) {
				if (!_constructionProgress) _constructionProgress = new MovieClip(Assets.DUMMY_MOVIE_CLIP);
				if (!_constructionTextField) _constructionTextField = new TextFieldTest();

				Starling.juggler.add(_constructionProgress);
				addChild(_constructionProgress);
				addChild(_constructionTextField);

				if (_view && _view.parent) removeChild(_view);
				updateConstructionTime();

				SecondsTimer.addCallBack(updateConstructionTime);
			} else {
				if (_constructionTextField && _constructionTextField.parent) {
					removeChild(_constructionTextField);
				}

				if (_constructionProgress && _constructionProgress.parent) {
					Starling.juggler.remove(_constructionProgress);
					removeChild(_constructionProgress);
				}

				var stateIndex:int = data.state ? data.state.index : 0;
				var txt:Texture = Assets.getTexture(this._assetId + int(stateIndex + 1));
				if (!txt) txt = Assets.getTexture(this._assetId);
				if (!_view) _view = new Image(txt);

				_view.texture = txt;
				addChild(_view);
				_view.visible = data.visible;

				SecondsTimer.removeCallback(updateConstructionTime);

				if (data.canCollectBonus) {
					if (!_attentionIcon) {
						_attentionIcon = Assets.getImage(AssetList.Room_collect_exp_icon);
						_attentionIcon.x = _view.width / 2 - _attentionIcon.width / 2;
						_attentionIcon.y = _view.height / 2 - _attentionIcon.height / 2;
					}
					addChild(_attentionIcon);
				} else {
					if (_attentionIcon) {
						removeChild(_attentionIcon);
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
			_constructionTextField.text = TimeUtil.stringify(data.constructTimeLeft);
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
					var h:FeathersControl = hint;
					// show hint if can't collect bonus only
					if (h && !data.canCollectBonus) {
						Hint.showHint(h, touch.globalX, touch.globalY);
					}
					super.dispatchEventWith(EVENT_TOUCH, true);
				} else if (touch.phase == TouchPhase.ENDED) {
					Hint.hide();
				}
			}
		}
	}
}
