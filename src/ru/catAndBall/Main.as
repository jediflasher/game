//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall {

	import com.greensock.TweenNano;

	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.system.Capabilities;
	import flash.utils.setInterval;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.utils.TimeInterval;
	import ru.catAndBall.view.assets.Assets;

	import starling.core.Starling;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	[SWF(frameRate=30)]
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                03.06.14 12:31
	 */
	public class Main extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Main() {
			super();

			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _controller:AppController;

		private var _assetManager:AssetManager;

		private var _starling:Starling;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function init(event:Event = null):void {
			AppProperties.fps = 60;
			AppProperties.appWidth = 1536;
			AppProperties.appHeight = 2048;
			AppProperties.iOS = Capabilities.manufacturer.indexOf("iOS") > -1;

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = AppProperties.fps;

			Starling.multitouchEnabled = false;
			Starling.handleLostContext = !AppProperties.iOS;

			var r:Rectangle = RectangleUtil.fit(
					new Rectangle(0, 0, AppProperties.appWidth, AppProperties.appHeight),
					new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
					ScaleMode.NO_BORDER);

			AppProperties.starlingRect = r;

			var mW:Number = AppProperties.appWidth / stage.fullScreenWidth;
			var mH:Number = AppProperties.appHeight / stage.fullScreenHeight;
			var deltaX:int = r.x * mW;
			var deltaY:int = r.y * mH;

			AppProperties.viewRect.setTo(-deltaX, -deltaY, AppProperties.appWidth + deltaX * 2, AppProperties.appHeight + deltaY * 2);

			//NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
//			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, saveData);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, saveData);
			setInterval(saveData, TimeInterval.MINUTE * 1000);

			var folderName:String = AppProperties.isHD ? 'hd' : 'hd';//'ld';

			var appDir:File = File.applicationDirectory;
			_assetManager = new AssetManager();
			_assetManager.verbose = Capabilities.isDebugger;
			_assetManager.enqueue(
					appDir.resolvePath("audio"),
					appDir.resolvePath("graphics/" + folderName)
			);

			Assets.init(_assetManager);

			_starling = new Starling(AppView, stage, AppProperties.starlingRect);
			_starling.stage.stageWidth = AppProperties.appWidth;
			_starling.stage.stageHeight = AppProperties.appHeight;
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.addEventListener('rootCreated', rootCreated);
			//_starling.showStats = true;

			var bg:DisplayObject = new Assets.bgHD();
			bg.x = AppProperties.starlingRect.x;
			bg.y = AppProperties.starlingRect.y;
			bg.width = AppProperties.starlingRect.width;
			bg.height = AppProperties.starlingRect.height;
			addChild(bg);
		}

		private function rootCreated(event:Object, app:AppView):void {
			_starling.removeEventListener('rootCreated', rootCreated);
			_starling.start();

			_controller = new AppController(app);
			_assetManager.loadQueue(progress);

			Assets.initComplete();
		}

		private function progress(progress:Number):void {
			_controller.progress(progress);

			if (progress == 1) {
				TweenNano.delayedCall(1, function ():void {
					while (numChildren) removeChildAt(0);
				})
			}
		}

		private function saveData(event:Event = null):void {
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
	}
}
