//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller {

	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.screens.BaseScreen;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                22.07.14 11:35
	 */
	public class CompositeScreenController extends BaseScreenController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function CompositeScreenController(containerScreen:BaseScreen) {
			super(containerScreen);
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		/**
		 * @private
		 */
		private var _currentScreen:BaseScreenController;

		public function get currentScreen():BaseScreenController {
			return _currentScreen;
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _hash:Object = {}; // ScreenType -> BaseScreen

		private var _viewStack:Vector.<BaseScreenController> = new Vector.<BaseScreenController>();

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public function addScreen(screen:BaseScreenController):void {
			var data:BaseScreenData = screen.view.data;
			_hash[data.type] = screen;

			screen.addEventListener(BaseScreenController.EVENT_BACK, back);
		}

		public function removeScreen(screenType:String):void {
			var screen:BaseScreenController = _hash[screenType];
			if (!screen) throw new IllegalOperationError('There is no screen ' + screenType);

			if (screen.isActive) throw new IllegalOperationError('Can not remove active screen');

			var index:int = _viewStack.indexOf(screen);
			if (index >= 0) _viewStack.splice(index, 1);

			screen.removeEventListener(BaseScreenController.EVENT_BACK, back);

			delete _hash[screenType];
		}

		public function getScreen(screenType:String):BaseScreenController {
			return _hash[screenType];
		}

		public function show(screenType:String):void {
			if (!(screenType in _hash)) throw new Error('Screen ' + screenType + ' is not added');

			if (_currentScreen) {
				view.removeChild(_currentScreen.view);
				_currentScreen.removed();
			}

			_currentScreen = _hash[screenType];

			// вытаскиваем из предыдущей позиции в стэке, чтобы засунуть в начало
			var index:int = _viewStack.indexOf(_currentScreen);
			if (index >= 0) _viewStack.splice(index, 1);

			_viewStack.push(_currentScreen);
			view.addChild(_currentScreen.view);
			_currentScreen.added();
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected function back(event:Event = null):void {
			if (!_currentScreen) {
				parentBack();
				return;
			}

			_viewStack.pop();
			view.removeChild(_currentScreen.view);
			_currentScreen.removed();

			var len:int = _viewStack.length;
			_currentScreen = len ? _viewStack[len - 1] : null;

			if (_currentScreen) {
				view.addChild(_currentScreen.view);
				_currentScreen.added();
			} else {
				parentBack();
			}
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
