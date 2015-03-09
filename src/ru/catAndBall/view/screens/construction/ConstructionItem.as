package ru.catAndBall.view.screens.construction {
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.events.Event;
	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.utils.EverySecond;
	import ru.catAndBall.utils.EverySecond;
	import ru.catAndBall.utils.TimeUtil;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.core.game.PriceButtonDecorator;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.game.factory.ConstructionViewFactory;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;

	import starling.display.Image;
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

		public static const EVENT_BUILD_CLICK:String = 'buildClick';

		public static const EVENT_SPEEDUP_CLICK:String = 'eventSpeedUpClick';

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

		private var _icon:Image;

		private var _resContainer:GridLayoutContainer;

		private var _buttonConstruct:Button;

		private var _buttonSpeedUp:PriceButtonDecorator;

		private var _level:BaseTextField;

		private var _constructionData:ConstructionData;


		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public override function set data(value:Object):void {
			if (super.data === value) {
				super.data.removeEventListener(ConstructionData.EVENT_BUILDING_START, handler_buildingStart);
				super.data.removeEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, handler_buildingComplete);
			}

			super.data = value;

			if (super.data) {
				super.data.addEventListener(ConstructionData.EVENT_BUILDING_START, handler_buildingStart);
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

			_title = new BaseTextField(AssetList.font_large_brown);
			_title.x = AppProperties.baseWidth / 2;
			_title.y = 30;
			addChild(_title);

			_description = new BaseTextField(AssetList.font_medium_brown);
			_description.x = 180;
			_description.y = 200;
			_description.wordWrap = true;
			_description.maxWidth = 355;
			addChild(_description);

			_buttonConstruct = new MediumGreenButton(L.get('screen.craft.makeButton'));
			_buttonConstruct.addEventListener(starling.events.Event.TRIGGERED, handler_constructClick);
			addChild(_buttonConstruct);

			_buttonSpeedUp = new PriceButtonDecorator(new MediumGreenButton(''), 'Speed up %s', 'Speed up');
			_buttonSpeedUp.button.addEventListener(starling.events.Event.TRIGGERED, handler_speedUpClick);
			addChild(_buttonSpeedUp.button);

			_resContainer = new GridLayoutContainer(2, Layout.craft.priceIconSize, Layout.craft.priceIconSize, Layout.craft.priceIconGaps.x, Layout.craft.priceIconGaps.y);
			_resContainer.x = 980;
			_resContainer.y = 127;
			addChild(_resContainer);

			_level = new BaseTextField(AssetList.font_small_white_orangestroke);
			_level.x = 702;
			_level.y = 413;
			addChild(_level);

			GameData.player.resources.addEventListener(flash.events.Event.CHANGE, handler_resourceChange);
			GameData.player.constructions.addEventListener(ConstructionData.EVENT_BUILDING_START, handler_constructionStart);
			GameData.player.constructions.addEventListener(ConstructionData.EVENT_BUILDING_COMPLETE, handler_constructionComplete);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				updateByData();
			}
		}

		protected override function feathersControl_removedFromStageHandler(event:starling.events.Event):void {
			super.feathersControl_removedFromStageHandler(event);

			EverySecond.removeCallback(updateTimeLeft);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateByData():void {
			_constructionData = _data as ConstructionData;
			if (_icon) removeChild(_icon);

			defaultSkin = Assets.getImage(AssetList.building_buildingBg);

			var rect:Rectangle = new Rectangle(593, 141, 333, 329);

			if (!_icon) {
				_icon = new Image(ConstructionViewFactory.getIcon(_constructionData));
				addChild(_icon);
			} else {
				_icon.texture = ConstructionViewFactory.getIcon(_constructionData);
			}
			var iconBounds:Rectangle = _icon.getBounds(_icon);

			_icon.x = rect.x + rect.width / 2 - iconBounds.width / 2;
			_icon.y = rect.y + rect.height / 2 - iconBounds.height / 2;

			_title.text = _constructionData.name;
			_title.validate();
			_title.x = AppProperties.baseWidth / 2 - _title.width / 2;

			_description.text = _constructionData.description;
			_level.text = 'LVL ' + _constructionData.level;

			if (_constructionData.nextState) {
				_resContainer.clear();

				var price:ResourceSet = _constructionData.nextState.price;
				for each (var type:String in ResourceSet.TYPES) {
					if (!price.has(type)) continue;

					var item:ResourceCounter = new ResourceCounter(type, price, Layout.craft.priceIconSize);
					item.maxResources = GameData.player.resources;
					_resContainer.addChild(item);
				}

				_buttonConstruct.x = rect.x;
				_buttonConstruct.y = rect.y + rect.height + 10;
				_buttonConstruct.width = rect.width;
			} else {
				_resContainer.visible = false;
				_buttonConstruct.visible = false;
			}

			if (_constructionData.constructTimeLeft > 0) {
				this.updateTimeLeft();
				EverySecond.addCallBack(updateTimeLeft);
			} else {
				_buttonConstruct.label = L.get('screen.craft.makeButton');
				_buttonConstruct.visible = _constructionData.nextState;
				EverySecond.removeCallback(updateTimeLeft);
			}

			_buttonConstruct.isEnabled = !GameData.player.constructions.inConstruction;

			_buttonSpeedUp.button.x = rect.right + 50;
			_buttonSpeedUp.button.y = _buttonConstruct.y;
			_buttonSpeedUp.button.visible = _constructionData.hasSpeedUp();

			if (_constructionData.hasSpeedUp()) {
				_buttonSpeedUp.price = _constructionData.nextState.speedUpPrice.get(ResourceSet.MONEY);
			}
		}

		private function updateTimeLeft():void {
			if (!_constructionData || !_buttonConstruct) return;

			var tl:int = _constructionData.constructTimeLeft;
			_buttonConstruct.label = TimeUtil.stringify(_constructionData.constructTimeLeft);
			_buttonSpeedUp.price = PurchaseController.getSkipTimePrice(tl);
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
			dispatchEventWith(EVENT_BUILD_CLICK, true, _constructionData);
		}

		private function handler_speedUpClick(event:*):void {
			dispatchEventWith(EVENT_SPEEDUP_CLICK, true, _constructionData);
		}

		private function handler_buildingStart(event:*):void {
			super.invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_buildingComplete(event:*):void {
			super.invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_constructionComplete(event:*):void {
			_buttonConstruct.isEnabled = true;
			super.invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_constructionStart(event:*):void {
			_buttonConstruct.isEnabled = false;
		}
	}
}
