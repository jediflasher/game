package ru.catAndBall.view.screens.craft {
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TabBar;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;

	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.data.game.tools.BaseToolData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.*;

	import starling.display.Image;
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

		private var _tabBar:TabBar;

		private var _craftsArea:List;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();
			(_backgroundSkin as Image).smoothing = TextureSmoothing.NONE;

			_tabBar = new TabBar();
			var r:Rectangle = AppProperties.viewRect;
			_tabBar.x = r.x;
			_tabBar.width = r.width;
			_tabBar.tabProperties.gap = Layout.baseGap;
			_tabBar.gap = Layout.baseGap;
			_tabBar.paddingTop = Layout.baseGap;
			_tabBar.tabFactory = function ():Button {
				return new CraftTab();
			};
			_tabBar.dataProvider = new ListCollection([
				{label: L.get('Pan 1')},
				{label: L.get('Pan 2')},
				{label: L.get('Pan 3')}
			]);
			addChild(_tabBar);

			_craftsArea = new List();
			var l:VerticalLayout = new VerticalLayout();
			l.paddingTop = Layout.baseGap;
			l.gap = Layout.baseGap;
			_craftsArea.layout = l;

			_craftsArea.x = r.x;
			_craftsArea.width = r.width;
			_craftsArea.itemRendererFactory = function ():IListItemRenderer {
				return new CraftItem();
			};
			_craftsArea.dataProvider = new ListCollection([
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources),
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources),
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources),
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources),
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources),
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources),
				new BaseToolData(ResourceSet.TOOL_COLLECT_SOCKS, GameData.player.resources)
			]);
			addChild(_craftsArea);
		}

		protected override function draw():void {
			if (isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE)) {
				_tabBar.validate();

				_craftsArea.y = _tabBar.y + _tabBar.height;
				_craftsArea.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
				_craftsArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FLOAT;
				_craftsArea.height = AppProperties.viewRect.height - _tabBar.height;
			}

			super.draw();
		}
	}
}
