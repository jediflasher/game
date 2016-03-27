package ru.catAndBall.view.screens.craft {
	
	import airlib.view.core.BaseScreen;

	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.*;
	import ru.catAndBall.view.screens.room.header.RoomHeaderBar;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                12.10.14 16:41
	 */
	public class ScreenCraft extends BaseScreen {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenCraft() {
			super(ScreenType.COMMODE_CRAFT);

			headerClass = RoomHeaderBar;
			footerClass = SimpleScreenFooterBar;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _tabRug:ToggleButton;

		private var _tabRolls:ToggleButton;

		private var _tabWindow:ToggleButton;

		private var _rollArea:List;

		private var _rugArea:List;

		private var _rollDataProvider:ListCollection = new ListCollection();

		private var _rugDataProvider:ListCollection = new ListCollection();

		private var _selectedTab:ToggleButton;

		private var _baseTabHeight:Number;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_rollDataProvider.data = GameData.player.constructions.commode1.tools;
			_rugDataProvider.data = GameData.player.constructions.commode2.tools;

			if (_backgroundSkin) {
				(_backgroundSkin as Image).smoothing = TextureSmoothing.NONE;
			}

			var shelfBg:Image = Assets.getImage(AssetList.Tools_shelfBg);
			shelfBg.x = 0;
			shelfBg.y = Layout.headerHeight;
			addRawChild(shelfBg);

			_tabRolls = tabFactory(L.get('screen.craft.tabRolls.title'));
			_tabRug = tabFactory(L.get('screen.craft.tabRug.title'));
			_tabWindow = tabFactory(L.get('screen.craft.tabWindow.title'));
			_tabWindow.isEnabled = false;

			_rollArea = new List();
			var l:VerticalLayout = new VerticalLayout();
			l.gap = 0;
			_rollArea.layout = l;

			_rollArea.x = 0;
			_rollArea.y = Layout.headerHeight;
			_rollArea.width = AppProperties.baseWidth;
			_rollArea.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_rollArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_NONE;
			_rollArea.itemRendererFactory = itemFactory;
			_rollArea.visible = false;
			_rollArea.dataProvider = _rollDataProvider;

			_rugArea = new List();
			l = new VerticalLayout();
			l.gap = 0;

			_rugArea.layout = l;
			_rugArea.x = 0;
			_rugArea.y = _rollArea.y;
			_rugArea.width = AppProperties.baseWidth;
			_rugArea.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_rugArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_NONE;
			_rugArea.itemRendererFactory = itemFactory;
			_rugArea.visible = false;
			_rugArea.dataProvider = _rugDataProvider;

			selectTab(_tabRolls);
			addRawChild(_rollArea);
			addRawChild(_rugArea);

			addRawChild(_tabRug);
			addRawChild(_tabWindow);
			addRawChild(_tabRolls);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				_tabRolls.validate();
				_tabRug.validate();
				_tabWindow.validate();

				_baseTabHeight = 107;

				_tabRolls.x = AppProperties.baseWidth / 2 - (_tabRolls.width * 3) / 2;
				_tabRug.x = _tabRolls.x + _tabRolls.width;
				_tabWindow.x = _tabRug.x + _tabRug.width;

				_tabRolls.y = _tabRug.y = _tabWindow.y = Layout.headerHeight;

				_rollArea.y = _tabRolls.y + _baseTabHeight;
				_rugArea.y = _rollArea.y;

				var height:Number = AppProperties.viewRect.height - Layout.headerHeight - Layout.footerHeight - _baseTabHeight;
				_rollArea.height = height;
				_rugArea.height = height;
			}
		}

		private function tabFactory(label:String):ToggleButton {
			var result:ToggleButton = new CraftTab(label);
			result.labelOffsetY = -20;
			result.addEventListener(Event.TRIGGERED, handler_tabClick);
			return result;
		}

		private function itemFactory():IListItemRenderer {
			return new CraftItem();
		}

		private function selectTab(tab:ToggleButton):void {
			if (_selectedTab === tab) return;

			if (_selectedTab) _selectedTab.isSelected = false;

			if (tab == _tabRolls) {
				_rollArea.visible = true;
				_rugArea.visible = false;
			} else if (tab == _tabRug) {
				_rollArea.visible = false;
				_rugArea.visible = true;
			}

			_selectedTab = tab;
			_selectedTab.isSelected = true;
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_tabClick(event:Event):void {
			selectTab(event.target as ToggleButton);
		}
	}
}
