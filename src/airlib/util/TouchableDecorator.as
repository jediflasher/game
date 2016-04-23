////////////////////////////////////////////////////////////////////////////////
//
//  © 2015 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////
package airlib.util {

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * @author                    Obi
	 * @langversion                3.0
	 * @date                    01.06.2015
	 */
	public class TouchableDecorator extends EventDispatcher {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_ROLL_OVER:String = 'eventRollOver';

		public static const EVENT_ROLL_OUT:String = 'eventRollOut';

		public static const EVENT_CLICK:String = 'eventClick';

		/**
		 * @private
		 */
		private static const HELPER_POINT:Point = new Point();

		/**
		 * @private
		 */
		private static const HELPER_RECT:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function TouchableDecorator(object:DisplayObject, eventDispatcher:EventDispatcher = null) {
			super();

			this._object = object;
			this._eventDispatcher = eventDispatcher || this;
			this._object.addEventListener(TouchEvent.TOUCH, this.button_touchHandler);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var touchPointID:int = -1;

		/**
		 * @private
		 */
		private var _eventDispatcher:EventDispatcher;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _object:DisplayObject;

		public function get object():DisplayObject {
			return this._object;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		/**
		 * Triggers the button.
		 */
		protected function triggerClick():void {
			this._eventDispatcher.dispatchEventWith(Event.TRIGGERED);
			if (this._eventDispatcher.hasEventListener(EVENT_CLICK)) this._eventDispatcher.dispatchEventWith(EVENT_CLICK);
		}

		/**
		 * @private
		 */
		protected function triggerRollOver():void {
			if (this._eventDispatcher.hasEventListener(EVENT_ROLL_OVER)) this._eventDispatcher.dispatchEventWith(EVENT_ROLL_OVER);
		}

		/**
		 * @private
		 */
		protected function triggerRollOut():void {
			if (this._eventDispatcher.hasEventListener(EVENT_ROLL_OUT)) this._eventDispatcher.dispatchEventWith(EVENT_ROLL_OUT);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		protected function button_touchHandler(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this._object, TouchPhase.HOVER);
			if (!touch) this.triggerRollOut();
			else this.triggerRollOver();

			if(this.touchPointID >= 0) {
				touch = event.getTouch(this._object, null, this.touchPointID);
				if(!touch) {
					//this should never happen
					return;
				}

				touch.getLocation(Starling.current.stage, HELPER_POINT);

				var isInBounds:Boolean;
				if (this._object is DisplayObjectContainer) {
					var doc:DisplayObjectContainer = this._object as DisplayObjectContainer;
					isInBounds = doc.contains(Starling.current.stage.hitTest(HELPER_POINT, true))
				} else {
					var b:Rectangle = this._object.getBounds(Starling.current.stage, HELPER_RECT);
					isInBounds = b.containsPoint(HELPER_POINT);
				}

				if(touch.phase == TouchPhase.ENDED) {
					//we we dispatched a long press, then triggered and change
					//won't be able to happen until the next touch begins
					if(isInBounds) {
						this.triggerClick();
					}
				}
			} else {
				touch = event.getTouch(this._object, TouchPhase.BEGAN);
				if(touch) {
					this.touchPointID = touch.id;
				}
			}
		}
	}
}
