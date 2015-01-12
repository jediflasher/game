package ru.catAndBall.view.screens.construction {
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.buildings.ConstructionData;

	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.BaseScreen;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.SimpleScreenFooterBar;
	import ru.catAndBall.view.screens.craft.CraftItem;
	import ru.catAndBall.view.screens.room.RoomHeaderBar;

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
			super(new BaseScreenData(ScreenType.CONSTRUCTION), AssetList.Tools_name_tools_background);

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
			l.gap = Layout.baseGap;
			_items.layout = l;
			_items.itemRendererFactory = itemFactory;

			var provider:ListCollection = new ListCollection();
			var constructions:Vector.<ConstructionData> = GameData.player.constructions.list;
			for each(var construction:ConstructionData in constructions) {
				provider.addItem(construction);
			}

			_items.dataProvider = provider;
			addChild(_items);
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
