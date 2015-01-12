package ru.catAndBall.view.popups {
	import feathers.controls.Button;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.FeathersControl;

	import ru.catAndBall.data.GameData;

	import ru.catAndBall.data.game.ResourceSet;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.ui.YellowButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 15:50
	 */
	public class InventoryPopup extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_CLOSE_CLICK:String = 'inventoryCloseClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function InventoryPopup() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _selectedTab:int = 0;

		private var _bg:Image;

		private var _bg2:Image;

		private var _tab0:Button;

		private var _tab1:Button;

		private var _closeButton:YellowButton;

		private var _content:GridLayoutContainer;

		private const _hashTypeToIcon:Object = {};

		private var _data:ResourceSet;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _w:Number;

		public override function get width():Number {
			return _w;
		}

		private var _h:Number;

		public override function get height():Number {
			return _h;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_data = GameData.player.resources;

			_bg = Assets.getImage(AssetList.inventory_shcatulka);
			addChild(_bg);

			_w = _bg.texture.width;
			_h = _bg.texture.height;

			_closeButton = new YellowButton(AssetList.buttons_close);
			_closeButton.addEventListener(Event.TRIGGERED, handler_closeClick);
			_closeButton.x = Layout.inventory.closeButtonPosition.x;
			_closeButton.y = Layout.inventory.closeButtonPosition.y;
			addChild(_closeButton);

			const activeTxt:Texture = Assets.getTexture(AssetList.inventory_activ);
			const passiveTxt:Texture = Assets.getTexture(AssetList.inventory_pasiv);
			_tab0 = new Button();
			_tab0.labelFactory = labelFactory;
			_tab0.label = L.get('inventory.tab0');
			_tab0.upSkin = new Image(passiveTxt);
			_tab0.downSkin = new Image(passiveTxt);
			_tab0.hoverSkin = new Image(passiveTxt);
			_tab0.selectedUpSkin = new Image(activeTxt);
			_tab0.selectedDownSkin = new Image(activeTxt);
			_tab0.selectedHoverSkin = new Image(activeTxt);
			_tab0.addEventListener(Event.TRIGGERED, handler_tab0Click);
			_tab0.x = Layout.inventory.tab0Position.x;
			_tab0.y = Layout.inventory.tab0Position.y;
			addChild(_tab0);

			_tab1 = new Button();
			_tab1.labelFactory = labelFactory;
			_tab1.label = L.get('inventory.tab1');
			_tab1.upSkin = new Image(passiveTxt);
			_tab1.downSkin = new Image(passiveTxt);
			_tab1.hoverSkin = new Image(passiveTxt);
			_tab1.selectedUpSkin = new Image(activeTxt);
			_tab1.selectedDownSkin = new Image(activeTxt);
			_tab1.selectedHoverSkin = new Image(activeTxt);
			_tab1.addEventListener(Event.TRIGGERED, handler_tab1Click);
			_tab1.x = Layout.inventory.tab1Position.x;
			_tab1.y = Layout.inventory.tab1Position.y;
			addChild(_tab1);

			_bg2 = Assets.getImage(AssetList.inventory_fon_pod_ikonki);
			_bg2.x = Layout.inventory.bg2Position.x;
			_bg2.y = Layout.inventory.bg2Position.y;
			addChild(_bg2);

			_content = new GridLayoutContainer(5,
					Layout.inventory.resourceIconSize,
					Layout.inventory.resourceIconSize,
					Layout.inventory.itemsGaps.x,
					Layout.inventory.itemsGaps.y);

			_content.x = Layout.inventory.contentPosition.x;
			_content.y = Layout.inventory.contentPosition.y;
			addChild(_content);
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_content.unflatten();
				_content.clear();

				for each (var resourceType:String in ResourceSet.TYPES) {
					if (ResourceSet.isResource(resourceType)) continue;

					if (!(resourceType in _hashTypeToIcon)) {
						_hashTypeToIcon[resourceType] = new ResourceCounter(resourceType, _data, Layout.inventory.resourceIconSize);
					}

					if (_selectedTab == 0 && !ResourceSet.isTool(resourceType)) continue;
					else if (_selectedTab == 1 && !ResourceSet.isComponent(resourceType)) continue;

					var counter:ResourceCounter = _hashTypeToIcon[resourceType];
					counter.gray = !_data.has(resourceType);
					_content.addChild(counter);
				}

				_content.flatten();
				updateSelection();
			}

			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateSelection():void {
			const diff:int = Layout.inventory.inactiveTabDeltaY;
			_tab0.isSelected = _selectedTab == 0;
			_tab0.y = Layout.inventory.tab0Position.y + (_selectedTab ? diff : 0);

			_tab1.isSelected = _selectedTab == 1;
			_tab1.y = Layout.inventory.tab1Position.y + (_selectedTab ? 0 : diff);
		}

		private function labelFactory():BitmapFontTextRenderer {
			return new BaseTextField(AssetList.font_small_milk_bold);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_closeClick(event:Event):void {
			dispatchEventWith(EVENT_CLOSE_CLICK);
		}

		private function handler_tab1Click(event:Event):void {
			_selectedTab = 1;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_tab0Click(event:Event):void {
			_selectedTab = 0;
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_resChange(event:Event):void {
			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
