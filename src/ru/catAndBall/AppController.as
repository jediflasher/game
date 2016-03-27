//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall {
	
	import airlib.view.core.BaseScreen;

	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.IPopUpManager;
	import feathers.core.PopUpManager;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.utils.getDefinitionByName;
	
	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.controller.screen.ScreenBallsFieldController;
	import ru.catAndBall.controller.screen.ScreenBankController;
	import ru.catAndBall.controller.screen.ScreenConstructionController;
	import ru.catAndBall.controller.screen.ScreenCraftController;
	import ru.catAndBall.controller.screen.ScreenMenuController;
	import ru.catAndBall.controller.screen.ScreenRoomController;
	import ru.catAndBall.controller.screen.ScreenRugFieldController;
	import ru.catAndBall.data.DefaultUserState;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.utils.Logger;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.ui.CatPopupManager;
	import ru.catAndBall.view.core.ui.Hint;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.ballsField.ScreenBallsField;
	import ru.catAndBall.view.screens.bank.ScreenBank;
	import ru.catAndBall.view.screens.construction.ScreenConstruction;
	import ru.catAndBall.view.screens.craft.ScreenCraft;
	import ru.catAndBall.view.screens.mainMenu.ScreenMenu;
	import ru.catAndBall.view.screens.preloader.ScreenPreloader;
	import ru.catAndBall.view.screens.room.ScreenRoom;
	import ru.catAndBall.view.screens.rugField.ScreenRugField;
	
	import starling.events.EventDispatcher;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                07.06.14 19:20
	 */
	public class AppController extends EventDispatcher {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		private static var _instance:AppController;

		public static function saveData():void {
			if (!_instance) return;

			_instance.saveData();
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function AppController(view:AppView) {
			super();
			_instance = this;
			_view = view;

			this.initPreloader();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _view:AppView;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function progress(progress:Number):void {
			if (progress == 1) {
				loadComplete();
				return;
			}

			if (this._view.activeScreenID != ScreenType.PRELOADER) {
				this._view.showScreen(ScreenType.PRELOADER);
			}

			(this._view.activeScreen as ScreenPreloader).progress = progress;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function initPreloader():void {
			var screen:BaseScreen = new ScreenPreloader(new BaseScreenData(ScreenType.PRELOADER));
			var item:ScreenNavigatorItem = new BaseScreenController(_view, screen);
			_view.addScreen(screen.data.type, item);
		}

		private function init():void {
			Hint.layer = _view;

			PopUpManager.popUpManagerFactory = function ():IPopUpManager {
				return new CatPopupManager();
			};

			PurchaseController.init(_view);

			var screen:BaseScreen = new ScreenMenu();
			var item:ScreenNavigatorItem = new ScreenMenuController(_view, screen as ScreenMenu);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenRoom();
			item = new ScreenRoomController(_view, screen as ScreenRoom);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenCraft();
			item = new ScreenCraftController(_view, screen as ScreenCraft);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenRugField();
			item = new ScreenRugFieldController(_view, screen as ScreenRugField);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenBallsField();
			item = new ScreenBallsFieldController(_view, screen as ScreenBallsField);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenBank();
			item = new ScreenBankController(_view, screen);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenConstruction();
			item = new ScreenConstructionController(_view, screen);
			_view.addScreen(screen.data.type, item);

			new ScreenFadeTransitionManager(_view);
		}

		private function loadComplete():void {
			var defaultUserState:DefaultUserState = new DefaultUserState();
			var dictionaries:Object = Assets.getJSON('dict.json');
			GameData.dictionaries.deserialize(dictionaries);
			GameData.player.init();

			try {
				var so:SharedObject = SharedObject.getLocal('game');
				delete so.data['game'];

				var data:Object = so.data['game'];

				if (data) {
					GameData.deserialize(data);
				} else {
					GameData.deserialize(defaultUserState);
				}
			} catch (error:Error) {
				Logger.logError('Cant load data from SharedObject');
				GameData.deserialize(defaultUserState);
			}

			if (!AppProperties.isWeb) {
				var cl:Class = getDefinitionByName('flash.desktop.NativeApplication') as Class;
				cl['nativeApplication'].addEventListener(Event['DEACTIVATE'], saveData);
				cl['nativeApplication'].addEventListener(Event['EXITING'], saveData);
			}

			this.init();

			_view.showScreen(ScreenType.MAIN_MENU);
		}

		private function saveData(event:* = null):void {
			this.saveInSharedObject();
		}

		private function saveInSharedObject():void {
			try {
				var so:SharedObject = SharedObject.getLocal('game');
				so.data['game'] = GameData.serialize();
				so.flush();
				trace('Data saved to Shared Object! Horray!');
			} catch (error:Error) {
				Logger.logError('Cant save data to shared object' + error);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}