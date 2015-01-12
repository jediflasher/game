package ru.catAndBall.view.popups {
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import ru.catAndBall.controller.PurchaseController;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.PriceButtonDecorator;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.game.ResourceImage;
	import ru.catAndBall.view.core.text.TextFieldBackground;
	import ru.catAndBall.view.core.ui.BasePopup;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.ui.YellowButton;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 10:35
	 */
	public class CraftToolPopUp extends BasePopup {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_CREATE_CLICK:String = 'createClick';

		private static const INVALIDATION_FLAG_COUNT:String = 'count';

		private static const HELPER_RESOURCE_SET:ResourceSet = new ResourceSet();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CraftToolPopUp() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _counterTf:TextFieldBackground;

		private var _plusButton:YellowButton;

		private var _minusButton:YellowButton;

		private var _resContainer:GridLayoutContainer;

		private var _makeButton:PriceButtonDecorator;

		private const _totalPrice:ResourceSet = new ResourceSet();

		private const _shownResult:ResourceSet = new ResourceSet();

		private const _counterContainer:Sprite = new Sprite();

		private const _content:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _data:ToolDict;

		public function get data():ToolDict {
			return _data;
		}

		public function set data(value:ToolDict):void {
			if (_data === value) return;

			_data = value;

			invalidate(INVALIDATION_FLAG_LAYOUT);
			invalidate(INVALIDATION_FLAG_DATA);
			invalidate(INVALIDATION_FLAG_COUNT);
		}

		private var _count:int = 0;

		public function get count():int {
			return _count;
		}

		public function set count(value:int):void {
			if (_count == value) return;

			_count = value;
			invalidate(INVALIDATION_FLAG_COUNT);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			const txt:Texture = Assets.getTexture(AssetList.ToolsOption_counter_bg);
			const bg:Scale3Image = new Scale3Image(new Scale3Textures(txt, Layout.craft.popupCounterBgScaleGridSizes[0], Layout.craft.popupCounterBgScaleGridSizes[1]));
			bg.width = Layout.craft.popupCounterBgSize;
			_counterTf = new TextFieldBackground(AssetList.font_xlarge_milk_bold, bg, true, true);
			_counterContainer.addChild(_counterTf);

			_minusButton = new YellowButton(AssetList.ToolsOption_minus, Layout.craft.popupPlusMinusButtonSize, Layout.craft.popupPlusMinusButtonSize);
			_minusButton.addEventListener(Event.TRIGGERED, handler_minusClick);
			_counterContainer.addChild(_minusButton);

			_plusButton = new YellowButton(AssetList.ToolsOption_plus, Layout.craft.popupPlusMinusButtonSize, Layout.craft.popupPlusMinusButtonSize);
			_plusButton.addEventListener(Event.TRIGGERED, handler_plusClick);
			_plusButton.x = Layout.craft.popupCounterBgSize - Layout.craft.popupPlusMinusButtonSize;
			_counterContainer.addChild(_plusButton);

			_resContainer = new GridLayoutContainer(4, Layout.baseResourceIconSize, Layout.baseResourceIconSize, Layout.craft.priceIconGaps.x);

			_makeButton = new PriceButtonDecorator(new MediumGreenButton(""), 'screen.craft.popup.makeFor', 'screen.craft.popup.makeFree');
			_makeButton.button.addEventListener(Event.TRIGGERED, handler_createClick);

			_content.push(_counterContainer);
			_content.push(_resContainer);
			_content.push(_makeButton.button);

			var playerRes:ResourceSet = GameData.player.resources;
			playerRes.addEventListener(Event.CHANGE, handler_playerResourcesChange);

			super.initialize();
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_resContainer.clear();

				if (_data) {
					icon = new ResourceImage(_data.resourceType, Layout.craft.iconSize);

					for each (var resourceType:String in ResourceSet.TYPES) {
						if (!_data.price.has(resourceType)) continue;

						var counter:ResourceCounter = new ResourceCounter(resourceType, _shownResult);
						counter.disableOnZero = false;
						counter.minResources = new ResourceSet();
						_resContainer.addChild(counter);
					}
				}
			}

			if (isInvalid(INVALIDATION_FLAG_COUNT)) {
				_totalPrice.clear();
				_shownResult.clear();

				_counterTf.text = String(_count);
				_counterTf.validate();

				this._minusButton.isEnabled = this._count > 0;
				this._makeButton.button.isEnabled = this._count > 0;

				_totalPrice.add(_data.price, _count);

				_shownResult.add(GameData.player.resources);
				_shownResult.substract(_totalPrice);

				HELPER_RESOURCE_SET.clear();
				GameData.player.resources.getDeficit(_totalPrice, HELPER_RESOURCE_SET);

				_makeButton.price = PurchaseController.getDeficitPrice(HELPER_RESOURCE_SET);
				invalidate(INVALIDATION_FLAG_LAYOUT);
			}

			super.draw();
		}

		protected override function getContent():Vector.<DisplayObject> {
			return _content;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_createClick(event:Event):void {
			dispatchEventWith(EVENT_CREATE_CLICK);
		}

		private function handler_plusClick(event:Event):void {
			_count++;
			_counterTf.text = String(_count);
			invalidate(INVALIDATION_FLAG_COUNT);
		}

		private function handler_minusClick(event:*):void {
			_count--;
			_counterTf.text = String(_count);
			invalidate(INVALIDATION_FLAG_COUNT);
		}

		private function handler_playerResourcesChange(event:*):void {
			invalidate(INVALIDATION_FLAG_COUNT);
		}
	}
}
