//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller {

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.screens.BaseScreen;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.SimpleScreenFooterBar;

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

		public function BaseScreenController(navigator:ScreenNavigator, screen:BaseScreen) {
			super(screen);
			this._eventDispatcher = new EventDispatcher(this);
			this._view = screen;
			this._navigator = navigator;

			this._view.addEventListener(FeathersEventType.CREATION_COMPLETE, handler_creationComplete);
			this._view.addEventListener(Event.ADDED_TO_STAGE, handler_addedToStage);
			this._view.addEventListener(Event.REMOVED_FROM_STAGE, handler_removedFromStage);

			events[SimpleScreenFooterBar.EVENT_BACK_CLICK] = backClick;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _eventDispatcher:EventDispatcher;

		private var _creatinComplete:Boolean = false;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _view:BaseScreen;

		public function get view():BaseScreen {
			return _view;
		}

		public function get data():BaseScreenData {
			return _view.data;
		}

		private var _navigator:ScreenNavigator;

		public function get navigator():ScreenNavigator {
			return _navigator;
		}

		public var previousScreen:String = ScreenType.ROOM;

		public var purchaseController:PurchaseController;

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

		protected function backClick():void {
			if (previousScreen) {
				navigator.showScreen(previousScreen);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_creationComplete(event:*):void {
			_creatinComplete = true;
			added();
		}

		private function handler_addedToStage(event:*):void {
			if (_creatinComplete) added();
		}

		private function handler_removedFromStage(event:*):void {
			removed();
		}
	}
}
