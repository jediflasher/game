package ru.catAndBall.view.popups {
	import feathers.controls.Button;
	import feathers.controls.ToggleButton;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.FeathersControl;

	import flash.text.TextFormatAlign;

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

		private static const SELECTED_Y:Number = 157;

		private static const DEFAULT_Y:Number = 177;

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

		private var _paperBg:Image;

		private var _tab0:ToggleButton;

		private var _tab1:ToggleButton;

		private var _closeButton:YellowButton;

		private var _content:GridLayoutContainer;

		private const _hashTypeToIcon:Object = {};

		private var _data:ResourceSet;

		private var _title:BaseTextField;

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

			_bg = Assets.getImage(AssetList.inventory_inventoryBg);
			addChild(_bg);

			_w = _bg.texture.width;
			_h = _bg.texture.height;

			_title = new BaseTextField(AssetList.font_large_white_shadow);
			_title.x = Layout.inventory.titlePos.x;
			_title.y = Layout.inventory.titlePos.y;
			_title.text = L.get('inventory.title');
			addChild(_title);

			_closeButton = new YellowButton(AssetList.buttons_close);
			_closeButton.addEventListener(Event.TRIGGERED, handler_closeClick);
			_closeButton.x = _w - _closeButton.width;//Layout.inventory.closeButtonPosition.x;
			_closeButton.y = Layout.inventory.closeButtonY;
			addChild(_closeButton);

			var activeTxt:Texture = Assets.getTexture(AssetList.inventory_inset_on);
			var passiveTxt:Texture = Assets.getTexture(AssetList.inventory_inset_off);
			_tab0 = new ToggleButton();

			_tab0.labelFactory = labelFactory;
			_tab0.isToggle = false;
			_tab0.label = L.get('inventory.tab0');
			_tab0.labelOffsetY = -25;
			_tab0.upSkin = new Image(passiveTxt);
			_tab0.downSkin = new Image(passiveTxt);
			_tab0.hoverSkin = new Image(passiveTxt);
			_tab0.selectedUpSkin = new Image(activeTxt);
			_tab0.selectedDownSkin = new Image(activeTxt);
			_tab0.selectedHoverSkin = new Image(activeTxt);
			_tab0.addEventListener(Event.TRIGGERED, handler_tab0Click);
			_tab0.x = 170;
			_tab0.y = DEFAULT_Y;
			addChild(_tab0);

			_tab1 = new ToggleButton();
			_tab1.isToggle = false;
			_tab1.labelFactory = labelFactory;
			_tab1.label = L.get('inventory.tab1');
			_tab1.labelOffsetY = -25;
			_tab1.upSkin = new Image(passiveTxt);
			_tab1.downSkin = new Image(passiveTxt);
			_tab1.hoverSkin = new Image(passiveTxt);
			_tab1.selectedUpSkin = new Image(activeTxt);
			_tab1.selectedDownSkin = new Image(activeTxt);
			_tab1.selectedHoverSkin = new Image(activeTxt);
			_tab1.addEventListener(Event.TRIGGERED, handler_tab1Click);
			_tab1.x = 616;
			_tab1.y = DEFAULT_Y;
			addChild(_tab1);

			_paperBg = Assets.getImage(AssetList.inventory_inventoryBg1);
			_paperBg.x = 40;
			_paperBg.y = 240;
			_paperBg.touchable = false;
			addChild(_paperBg);

			_content = new GridLayoutContainer(5,
					Layout.inventory.resourceIconSize,
					Layout.inventory.resourceIconSize,
					Layout.inventory.itemsGaps.x,
					Layout.inventory.itemsGaps.y);

			_content.x = Layout.inventory.contentPosition.x;
			_content.y = Layout.inventory.contentPosition.y;
			addChild(_content);

			updateSelection();
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_title.validate();
				_title.x = _w / 2 - _title.width / 2;

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
			}

			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateSelection():void {
			var sel:Boolean = _selectedTab == 0;
			_tab0.isSelected = sel;
			_tab0.touchable = !sel;
			_tab0.y = sel ? SELECTED_Y : DEFAULT_Y;

			sel = _selectedTab == 1;
			_tab1.isSelected = sel;
			_tab1.touchable = !sel;
			_tab1.y = sel ? SELECTED_Y : DEFAULT_Y;
		}

		private function labelFactory():BitmapFontTextRenderer {
			return new BaseTextField(AssetList.font_small_white);
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
			updateSelection();
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_tab0Click(event:Event):void {
			_selectedTab = 0;
			updateSelection();
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_resChange(event:Event):void {
			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
