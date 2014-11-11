package ru.catAndBall.view.screens.craft {
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.text.BitmapFontTextFormat;

	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.dict.Dictionaries;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.*;
	import ru.catAndBall.view.screens.room.RoomFooterBar;
	import ru.catAndBall.view.screens.room.RoomHeaderBar;

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
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenCraft(data:BaseScreenData) {
			super(data, AssetList.Tools_name_tools_background);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _tabRug:Button;

		private var _tabRolls:Button;

		private var _tabWindow:Button;

		private var _rollArea:List;

		private var _rugArea:List;

		private var _rollDataProvider:ListCollection = new ListCollection([
			Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_BOWL),
			Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_BROOM),
			Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_SPOKES)
		]);

		private var _rugDataProvider:ListCollection = new ListCollection([
			Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_SPOOL),
			Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_TEA),
			Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_TOY_BOX)
		]);

		private var _selectedTab:Button;

		private var _newSelectedTab:Button;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			headerClass = RoomHeaderBar;
			footerClass = CraftFooterBar;

			super.initialize();

			(_backgroundSkin as Image).smoothing = TextureSmoothing.NONE;

			_tabRolls = tabFactory(L.get('screen.craft.tabRolls.title'));
			addChild(_tabRolls);

			_tabRug = tabFactory(L.get('screen.craft.tabRug.title'));
			addChild(_tabRug);

			_tabWindow = tabFactory(L.get('screen.craft.tabWindow.title'));
			_tabWindow.isEnabled = false;
			addChild(_tabWindow);

			_rollArea = new List();
			var l:VerticalLayout = new VerticalLayout();
			l.gap = Layout.baseGap;
			_rollArea.layout = l;

			_rollArea.x = 0;
			_rollArea.width = AppProperties.appWidth;
			_rollArea.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_rollArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_NONE;
			_rollArea.itemRendererFactory = itemFactory;
			_rollArea.visible = false;
			_rollArea.dataProvider = _rollDataProvider;

			_rugArea = new List();
			l = new VerticalLayout();
			l.gap = Layout.baseGap;

			_rugArea.layout = l;
			_rugArea.x = 0;
			_rugArea.width = AppProperties.appWidth;
			_rugArea.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_rugArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_NONE;
			_rugArea.itemRendererFactory = itemFactory;
			_rugArea.visible = false;
			_rugArea.dataProvider = _rugDataProvider;

			selectTab(_tabRolls);
			addChild(_rollArea);
			addChild(_rugArea);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				_tabRolls.validate();
				_tabRug.validate();
				_tabWindow.validate();

				_tabRolls.x = AppProperties.viewRect.x + Layout.craft.tabGap;
				_tabRug.x = _tabRolls.x + _tabRolls.width + Layout.craft.tabGap;
				_tabWindow.x = _tabRug.x + _tabRug.width + Layout.craft.tabGap;
				_rollArea.y = _tabRolls.y + _tabRolls.height;
				_rugArea.y = _rollArea.y;

				const height:Number = AppProperties.viewRect.height - _tabRolls.height - header.height - footer.height;
				_rollArea.height = height;
				_rugArea.height = height;
			}

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (_newSelectedTab) {
					if (_selectedTab) {
						_selectedTab.isSelected = false;
						_selectedTab = null;
					}

					_selectedTab = _newSelectedTab;
					_selectedTab.isSelected = true;
					_newSelectedTab = null;
				}
			}
		}

		private function tabFactory(label:String):Button {
			const result:Button = new CraftTab(label);
			result.width = (AppProperties.viewRect.width - (Layout.craft.tabGap * 4)) / 3;
			result.addEventListener(Event.TRIGGERED, handler_tabClick);
			return result;
		}

		private function itemFactory():IListItemRenderer {
			return new CraftItem();
		};

		private function selectTab(tab:Button):void {
			_newSelectedTab = tab;
			if (_newSelectedTab == _tabRolls) {
				_rollArea.visible = true;
				_rugArea.visible = false;
			} else if (_newSelectedTab == _tabRug) {
				_rollArea.visible = false;
				_rugArea.visible = true;
			}

			invalidate(INVALIDATION_FLAG_DATA);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_tabClick(event:Event):void {
			selectTab(event.target as Button);
		}
	}
}
