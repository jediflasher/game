//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall {

	import com.greensock.TweenNano;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;

	import ru.catAndBall.view.assets.Assets;

	import starling.core.Starling;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;

	[SWF(frameRate=30, width=480, height=800)]
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

		private var _url:String;

		private var _assetlistLoaded:Boolean = false;

		private var _rootCreated:Boolean = false;

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
			AppProperties.isWeb = !SystemUtil.isAIR;

			_url = stage.loaderInfo.parameters['url'] || '.';
			AppProperties.dev = _url ? _url.search(/(localhost|127\.0\.0\.1)/) >= 0 : false;

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = AppProperties.fps;

			Starling.multitouchEnabled = false;
			Starling.handleLostContext = !AppProperties.iOS;

			var stageWidth:Number = AppProperties.isWeb ? stage.stageWidth : stage.fullScreenWidth;
			var stageHeight:Number = AppProperties.isWeb ? stage.stageHeight : stage.fullScreenHeight;

			var r:Rectangle = RectangleUtil.fit(
					new Rectangle(0, 0, AppProperties.appWidth, AppProperties.appHeight),
					new Rectangle(0, 0, stageWidth, stageHeight),
					ScaleMode.NO_BORDER);

			AppProperties.starlingRect = r;

			var mW:Number = AppProperties.appWidth / stageWidth;
			var mH:Number = AppProperties.appHeight / stageHeight;
			var deltaX:int = r.x * mW;
			var deltaY:int = r.y * mH;

			AppProperties.viewRect.setTo(-deltaX, -deltaY, AppProperties.appWidth + deltaX * 2, AppProperties.appHeight + deltaY * 2);

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

			if (AppProperties.isWeb) {
				var folderName:String = AppProperties.isHD ? 'hd' : 'ld';
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE, handler_loadAssetListComplete);
				urlLoader.load(new URLRequest(_url + '/assets/' + folderName));
			} else {
				_assetlistLoaded = true;
				initAssets();
			}
		}

		private function initAssets(assets:Array = null):void {
			var folderName:String = AppProperties.isHD ? 'hd' : 'ld';

			_assetManager = new AssetManager();
			_assetManager.verbose = Capabilities.isDebugger;
			Assets.init(_assetManager);

			if (!AppProperties.isWeb) {
				var file:Class = getDefinitionByName('flash.filesystem.File') as Class;
				var appDir:Object = file['applicationDirectory'];
				_assetManager.enqueue(
						appDir['resolvePath']("audio"),
						appDir['resolvePath']("graphics/" + folderName)
				);
			} else {
				_assetManager.enqueue(assets);
			}

			_assetManager.enqueueWithName(_url + '/dict.json', 'dict.json');
			tryLoadResources();
		}

		private function rootCreated(event:Object, app:AppView):void {
			_starling.removeEventListener('rootCreated', rootCreated);
			_starling.start();

			_rootCreated = true;

			_controller = new AppController(app);

			tryLoadResources();
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

		private function tryLoadResources():void {
			if (!_rootCreated || !_assetlistLoaded) return;
			_assetManager.loadQueue(progress);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_loadAssetListComplete(event:Event):void {
			var loader:URLLoader = event.target as URLLoader;
			var json:Object = JSON.parse(loader.data);
			_assetlistLoaded = true;
			initAssets(json as Array);
		}
	}
}
