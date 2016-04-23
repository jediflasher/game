package ru.catAndBall.view.core.game {
	
	import feathers.core.FeathersControl;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.event.data.ConstructionDataEvent;
	import ru.catAndBall.event.data.ConstructionDataEvent;
	import ru.catAndBall.view.core.ui.Hint;
	import ru.catAndBall.view.hint.BaseConstructionHint;
	import ru.flaswf.parsers.feathers.view.ParserFeathersImage;
	import ru.flaswf.parsers.feathers.view.ParserFeathersMovieClip;
	import ru.flaswf.reader.descriptors.DisplayObjectDescriptor;

	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 11:49
	 */
	public class Construction extends ParserFeathersMovieClip {

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

		public function Construction(source:DisplayObjectDescriptor) {
			super(source);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		public var _hint:DisplayObject;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var showIfNotAvailable:Boolean = false;

		private var _data:ConstructionData;

		public function get data():ConstructionData {
			return _data;
		}

		public function set data(value:ConstructionData):void {
			if (_data == value) return;

			_data = value;
			invalidateData();
		}

		public function get hint():DisplayObject {
			if (!_hint) {
				_hint = new BaseConstructionHint(data);
			}
			return _hint;
		}

		private var _dropPoint:Point = new Point();

		public function get dropPoint():Point {
			var bounds:Rectangle = getFrameBounds();
			_dropPoint.x = bounds.width / 2;
			_dropPoint.y = bounds.height / 2;
			return _dropPoint;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function dispose():void {
			data.removeEventListener(ConstructionDataEvent.BUILDING_COMPLETE, invalidateData);
			super.dispose();
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();
			addEventListener(TouchEvent.TOUCH, this.handler_touch);
		}
		
		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_DATA)) {
				if (data) updateHandlers();
				visible = data && data.visible;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateHandlers():void {
			if (data.startBuildingTime) {
				data.addEventListener(ConstructionDataEvent.BUILDING_COMPLETE, invalidateData);
			} else {
				data.removeEventListener(ConstructionDataEvent.BUILDING_COMPLETE, invalidateData);
			}

			if (data.bonusTimeLeft > 0) {
				data.addEventListener(ConstructionDataEvent.BONUS_READY, invalidateData);
			} else {
				if (data.canCollectBonus) {
					data.addEventListener(ConstructionDataEvent.BONUS_COLLECTED, invalidateData);
				} else {
					data.removeEventListener(ConstructionDataEvent.BONUS_COLLECTED, invalidateData);
				}
				data.removeEventListener(ConstructionDataEvent.BONUS_READY, invalidateData);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_touch(event:TouchEvent):void {
			if (!data) return;

			var touch:Touch = event.getTouch(stage);
			if (touch) {
				if (touch.phase == TouchPhase.BEGAN) {
					var h:DisplayObject = hint;
					// show hint if can't collect bonus only
					if (h && !data.canCollectBonus) {
//						Hint.showHint(h, hintX, hintY, this);
					}
					super.dispatchEventWith(EVENT_TOUCH, true);
				} else if (touch.phase == TouchPhase.ENDED) {
//					Hint.hide();
				}
			}
		}
	}
}
