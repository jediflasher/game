package ru.catAndBall.view.screens.construction {
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.events.Event;

	import flash.geom.Rectangle;

	import ru.catAndBall.data.GameData;

	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.core.game.ResourceCounter;

	import ru.catAndBall.view.core.game.ResourceImage;
	import ru.catAndBall.view.core.game.factory.ConstructionViewFactory;

	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;

	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.12.14 15:31
	 */
	public class ConstructionItem extends DefaultListItemRenderer {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const BUILD_CLICK:String = 'buildClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionItem() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _title:BaseTextField;

		private var _description:BaseTextField;

		private var _icon:Construction;

		private var _resContainer:GridLayoutContainer;

		private var _iconBg:Scale9Image;

		private var _buttonConstruct:MediumGreenButton;

		private var _constructionData:ConstructionData;

		private const _hashTypeToItem:Object = {};


		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public override function set data(value:Object):void {
			if (super.data === value) {
				super.data.removeEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, handler_buildingComplete);
			}

			super.data = value;

			if (super.data === value) {
				super.data.addEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, handler_buildingComplete);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_title = new BaseTextField(AssetList.font_large_white_bold);
			_title.x = Layout.craft.titlePos.x;
			_title.y = Layout.craft.titlePos.y;
			addChild(_title);

			_description = new BaseTextField(AssetList.font_small_milk_bold);
			_description.x = Layout.craft.descBounds.x;
			_description.y = Layout.craft.descBounds.y;
			_description.wordWrap = true;
			_description.maxWidth = Layout.craft.descBounds.width;
			addChild(_description);

			_iconBg = new Scale9Image(new Scale9Textures(Assets.getTexture(AssetList.Tools_tool_icon_background), new Rectangle(60, 60, 10, 10)));
			_iconBg.x = Layout.craft.iconPos.x;
			_iconBg.y = Layout.craft.iconPos.y;
			_iconBg.width = Layout.craft.iconSize;
			_iconBg.height = Layout.craft.iconSize;
			addChild(_iconBg);

			_buttonConstruct = new MediumGreenButton(L.get('screen.craft.makeButton'));
			_buttonConstruct.addEventListener(starling.events.Event.TRIGGERED, handler_constructClick);
			addChild(_buttonConstruct);

			_resContainer = new GridLayoutContainer(2, Layout.craft.priceIconSize, Layout.craft.priceIconSize, Layout.craft.priceIconGaps.x, Layout.craft.priceIconGaps.y);
			_resContainer.x = Layout.craft.priceX;
			_resContainer.y = _iconBg.y;
			addChild(_resContainer);

			GameData.player.resources.addEventListener(flash.events.Event.CHANGE, handler_resourceChange);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				updateByData();
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateByData():void {
			_constructionData = _data as ConstructionData;
			if (_icon) removeChild(_icon);

			defaultSkin = Assets.getImage(AssetList.Tools_tool_background_1);

			var bgRect:Rectangle = _iconBg.getBounds(this);

			_buttonConstruct.x = bgRect.x;
			_buttonConstruct.y = bgRect.y + bgRect.height;
			_buttonConstruct.width = bgRect.width;

			_icon = ConstructionViewFactory.createConstruction(_constructionData);
			_icon.x = bgRect.x + bgRect.width / 2 - Layout.craft.iconSize / 2;
			_icon.y = bgRect.y + bgRect.height / 2 - Layout.craft.iconSize / 2;
			addChild(_icon);

			_title.text = _constructionData.name;
			_description.text = _constructionData.description;

			var price:ResourceSet = _constructionData.nextState.price;
			for each (var type:String in ResourceSet.TYPES) {
				if (!price.has(type)) continue;
				if (type in _hashTypeToItem) continue;

				var item:ResourceCounter = new ResourceCounter(type, price, Layout.craft.priceIconSize);
				item.maxResources = GameData.player.resources;
				_resContainer.addChild(item);
				_hashTypeToItem[type] = item;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_resourceChange(event:*):void {
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_constructClick(event:*):void {
//			dispatchEventWith(EVENT_MAKE_CLICK, true, _toolData);
		}

		private function handler_buildingComplete(event:*):void {
			super.invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
