//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall {

	import dragonBones.animation.WorldClock;

	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.IPopUpManager;
	import feathers.core.PopUpManager;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import flash.desktop.NativeApplication;
	import flash.events.Event;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import flash.net.SharedObject;
	import flash.utils.setInterval;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.controller.screen.ScreenBallsFieldController;
	import ru.catAndBall.controller.screen.ScreenCraftController;
	import ru.catAndBall.controller.screen.ScreenMenuController;
	import ru.catAndBall.controller.screen.ScreenRoomController;
	import ru.catAndBall.controller.screen.ScreenRugFieldController;
	import ru.catAndBall.data.DefaultUserState;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.data.game.screens.BaseScreenFieldData;
	import ru.catAndBall.utils.TimeInterval;
	import ru.catAndBall.view.core.ui.CatPopupManager;
	import ru.catAndBall.view.core.ui.Hint;
	import ru.catAndBall.view.screens.BaseScreen;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.ballsField.ScreenBallsField;
	import ru.catAndBall.view.screens.craft.ScreenCraft;
	import ru.catAndBall.view.screens.mainMenu.ScreenMenu;
	import ru.catAndBall.view.screens.preloader.ScreenPreloader;
	import ru.catAndBall.view.screens.room.ScreenRoom;
	import ru.catAndBall.view.screens.rugField.ScreenRugField;

	import starling.animation.Juggler;
	import starling.core.Starling;

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
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function AppController(view:AppView) {
			super();
			_view = view;

			this.init();
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

		private function init():void {
			Hint.layer = _view;

			Starling.juggler.add(new DragonBonesEnterFramer());

			PopUpManager.popUpManagerFactory = function():IPopUpManager {
				return new CatPopupManager();
			};

			var screen:BaseScreen = new ScreenPreloader(new BaseScreenData(ScreenType.PRELOADER));
			var item:ScreenNavigatorItem = new BaseScreenController(_view, screen);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenMenu(new BaseScreenData(ScreenType.MAIN_MENU));
			item = new ScreenMenuController(_view, screen as ScreenMenu);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenRoom(new BaseScreenData(ScreenType.ROOM));
			item = new ScreenRoomController(_view, screen as ScreenRoom);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenCraft(new BaseScreenData(ScreenType.COMMODE_CRAFT));
			item = new ScreenCraftController(_view, screen as ScreenCraft);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenRugField();
			item = new ScreenRugFieldController(_view, screen as ScreenRugField);
			_view.addScreen(screen.data.type, item);

			screen = new ScreenBallsField();
			item = new ScreenBallsFieldController(_view, screen as ScreenBallsField);
			_view.addScreen(screen.data.type, item);

			new ScreenFadeTransitionManager(_view);
		}

		private function loadComplete():void {
			try {
				var so:SharedObject = SharedObject.getLocal('game');
				var data:Object = so.data['game'];
				if (data) {
					GameData.deserialize(data);
				} else {
					GameData.deserialize(new DefaultUserState());
				}
			} catch (error:Error) {
				trace('Wtf error!');
				GameData.deserialize(new DefaultUserState());
			}

			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, saveData);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, saveData);
			setInterval(saveData, TimeInterval.MINUTE * 3000);

			_view.showScreen(ScreenType.MAIN_MENU);
		}

		private function saveData(event:* = null):void {
			var f:File = File.applicationStorageDirectory.resolvePath("game.dat");

			if (!f.exists) {
				this.saveInSharedObject();
			} else {
				var fs:FileStream = new FileStream();
				try {
					fs.openAsync(f, FileMode.WRITE);
					fs.position = 0;
					fs.writeObject(GameData.serialize());
					fs.close();
					trace('Data saved to game.dat! Horray');
				} catch (error:Error) {
					trace(error);
					saveInSharedObject();
				}
			}
		}

		private function saveInSharedObject():void {
			try {
				var so:SharedObject = SharedObject.getLocal('game');
				so.data['game'] = GameData.serialize();
				so.flush();
				trace('Data saved to Shared Object! Horray!');
			} catch (error:Error) {
				trace(error);
				trace('Data dont saved!Wtf!');
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}

import dragonBones.animation.WorldClock;

import starling.animation.IAnimatable;

class DragonBonesEnterFramer implements IAnimatable {
	public function advanceTime(time:Number):void {
		WorldClock.clock.advanceTime(time);
	}
}