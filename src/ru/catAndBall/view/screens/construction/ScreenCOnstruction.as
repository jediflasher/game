package ru.catAndBall.view.screens.construction {
	
	import airlib.view.core.BaseScreen;
	
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.SimpleScreenFooterBar;
	import ru.catAndBall.view.screens.room.header.RoomHeaderBar;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.11.14 13:41
	 */
	public class ScreenConstruction extends BaseScreen {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenConstruction() {
			super(new BaseScreenData(ScreenType.CONSTRUCTION), AssetList.building_buildingWallpaper);

			headerClass = RoomHeaderBar;
			footerClass = SimpleScreenFooterBar;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _items:List;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_items = new List();
			var l:VerticalLayout = new VerticalLayout();
			_items.layout = l;
			_items.itemRendererFactory = itemFactory;
			_items.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_items.scrollBarDisplayMode = SCROLL_BAR_DISPLAY_MODE_NONE;
			_items.x = 0;
			_items.y = Layout.headerHeight;
			_items.width = AppProperties.baseWidth;

			var provider:ListCollection = new ListCollection();
			var constructions:Vector.<ConstructionData> = GameData.player.constructions.list;
			for each(var construction:ConstructionData in constructions) {
				provider.addItem(construction);
			}

			_items.dataProvider = provider;
			addRawChild(_items);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_LAYOUT)) {

				var height:Number = AppProperties.viewRect.height - Layout.footerHeight - Layout.headerHeight;
				_items.height = height;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function itemFactory():IListItemRenderer {
			return new ConstructionItem();
		}

	}
}
