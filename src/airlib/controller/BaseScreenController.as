//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package airlib.controller {

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                03.07.14 12:28
	 */
	public class BaseScreenController extends ScreenNavigatorItem implements IEventDispatcher {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseScreenController(navigator:ScreenNavigator, screen:Object) {
			super(screen);
			this._eventDispatcher = new EventDispatcher(this);
			this._view = screen;
			this._navigator = navigator;

			this._view.addEventListener(FeathersEventType.CREATION_COMPLETE, handler_creationComplete);
			this._view.addEventListener(Event.ADDED_TO_STAGE, handler_addedToStage);
			this._view.addEventListener(Event.REMOVED_FROM_STAGE, handler_removedFromStage);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _eventDispatcher:EventDispatcher;

		private var _creationComplete:Boolean = false;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _view:Object;

		public function get view():Object {
			return _view;
		}

		private var _navigator:ScreenNavigator;

		public function get navigator():ScreenNavigator {
			return _navigator;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		public function dispatchEvent(event:Event):Boolean {
			return _eventDispatcher.dispatchEvent(event);
		}

		public function hasEventListener(type:String):Boolean {
			return _eventDispatcher.hasEventListener(type);
		}

		public function willTrigger(type:String):Boolean {
			return _eventDispatcher.willTrigger(type);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function added():void {

		}

		protected function removed():void {

		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_creationComplete(event:*):void {
			_creationComplete = true;
			added();
		}

		private function handler_addedToStage(event:*):void {
			if (_creationComplete) added();
		}

		private function handler_removedFromStage(event:*):void {
			removed();
		}
	}
}
