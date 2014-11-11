//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.room {

	import flash.utils.Dictionary;

	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.FieldFooterBar;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.layout.room.RoomLayout;
	import ru.catAndBall.view.screens.BaseScreen;
	import ru.catAndBall.view.screens.room.drop.DropLayer;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 14:27
	 */
	public class ScreenRoom extends BaseScreen {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static var HD_PROPS:Vector.<Object>;
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_WINDOW_CLICK:String = 'windowClick';

		public static const EVENT_RUG_CLICK:String = 'rugClick';

		public static const EVENT_BALLS_CLICK:String = 'ballsClick';

		public static const EVENT_COMMODE_CLICK:String = 'commodeClick';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenRoom(data:BaseScreenData) {
			super(data, "room");
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _hashButtonToEvent:Dictionary = new Dictionary(true);

		private const _childrenToAdd:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		private var _catHouse:CatHouse;

		private var _window:Window;

		private var _carpet:Carpet;

		private var _tangles:Tangles;

		private var _commode:Commode;

		private var _dropLayer:DropLayer;

		private var _granny:Granny;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			headerClass = RoomHeaderBar;
			footerClass = RoomFooterBar;

			_catHouse = new CatHouse();
			_granny = new Granny();
			_window = new Window();
			_carpet = new Carpet();
			_commode = new Commode();
			_tangles = new Tangles();

			var l:RoomLayout = Layout.room;

			if (!HD_PROPS) {
				HD_PROPS = new <Object>[
					{obj: _window, x: l.window.x, y: l.window.y, onClickEvent: EVENT_WINDOW_CLICK},
					{obj: _carpet, x: l.rug.x, y: l.rug.y, onClickEvent: EVENT_RUG_CLICK},
					//{obj: Assets.getImage(AssetList.screenGame_curtain), x: 800, y: 720},
					//{obj: Assets.getImage(AssetList.screenGame_catBlack), x: 716, y: 782},
					//{obj: Assets.getImage(AssetList.screenGame_clock), x: 207, y: 493},
					//{obj: Assets.getImage(AssetList.screenGame_pictures), x: 1400, y: 500},
					{obj: _commode, x: l.commode.x, y: l.commode.y, onClickEvent:EVENT_COMMODE_CLICK},
					{obj: _catHouse, x: l.catHouse.x, y: l.catHouse.y},
					{obj: _granny, x: l.granny.x, y: l.granny.y},
					{obj: _tangles, x: l.tangles.x, y:l.tangles.y, onClickEvent: EVENT_BALLS_CLICK}
					//{obj: Assets.getImage(AssetList.screenGame_catRed), x: 312, y: 806},
					//{obj: Assets.getImage(AssetList.screenGame_tree), x: 156, y: 1221},
					//{obj: Assets.getButton(AssetList.screenGame_ballBox), x: 1253, y: 1474, onClickEvent: EVENT_BALLS_CLICK},
					//{obj: Assets.getImage(AssetList.screenGame_catWhite), x: 331, y: 1594},
					//{obj: Assets.getImage(AssetList.screenGame_bowl), x: 1336, y: 1768, onClickEvent: EVENT_BOWL_CLICK}
				];

				for each (var obj:Object in HD_PROPS) {
					var display:DisplayObject = obj.obj;
					//display.alignPivot(HAlign.CENTER, VAlign.CENTER);

					var eventName:String = obj.onClickEvent;

					if (eventName) {
						_hashButtonToEvent[display] = eventName;
						display.addEventListener(Event.TRIGGERED, handler_buttonClick);
					}

					display.x = obj.x;
					display.y = obj.y;
					_childrenToAdd.push(display);
				}

				_dropLayer = new DropLayer();
				addRawChild(_dropLayer);

				super.initialize();
			}

			for each (var child:DisplayObject in _childrenToAdd) {
				addRawChild(child);
			}

		}

		public function drop(resources:ResourceSet, fromX:int, fromY:int):void {
			_dropLayer.drop(resources, fromX, fromY);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_buttonClick(event:Event):void {
			var btn:DisplayObject = event.target as DisplayObject;
			if (btn && btn in _hashButtonToEvent) {
				dispatchEventWith(_hashButtonToEvent[btn]);
			}
		}
	}
}
