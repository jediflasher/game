package ru.catAndBall.view.popups {
	
	import feathers.core.FeathersControl;
	
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.PriceButtonDecorator;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.game.factory.ConstructionViewFactory;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.ui.BasePopup;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.03.15 18:18
	 */
	public class ConstructionNoResourcesPopup extends BasePopup {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_CREATE_CLICK:String = 'createClick';

		public static const HELPER_RESOURCE:ResourceSet = new ResourceSet();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionNoResourcesPopup() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _resContainer:GridLayoutContainer;

		private var _makeButton:PriceButtonDecorator;

		private var _descriptionTf:BaseTextField;

		private const _shownResult:ResourceSet = new ResourceSet();

		private const _counterContainer:Sprite = new Sprite();

		private const _content:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _data:ConstructionData;

		public function get data():ConstructionData {
			return _data;
		}

		public function set data(value:ConstructionData):void {
			if (_data === value) return;

			_data = value;

			invalidate(INVALIDATION_FLAG_LAYOUT);
			invalidate(INVALIDATION_FLAG_DATA);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			_descriptionTf = new BaseTextField(AssetList.font_medium_brown);
			_descriptionTf.text = L.get('screen.construction.popup.desc');
			_descriptionTf.wordWrap = true;
			_descriptionTf.maxWidth = 750;

			_resContainer = new GridLayoutContainer(4, Layout.baseResourceIconSize, Layout.baseResourceIconSize, Layout.craft.priceIconGaps.x);

			_makeButton = new PriceButtonDecorator(new MediumGreenButton(""), 'screen.construction.popup.construct');
			_makeButton.button.addEventListener(Event.TRIGGERED, handler_createClick);

			_content.push(_descriptionTf);
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
					if (!icon) icon = new Image(ConstructionViewFactory.getIcon(_data));
					else icon.texture = ConstructionViewFactory.getIcon(_data);

					var price:ResourceSet = _data.nextState.price;

					HELPER_RESOURCE.clear();
					GameData.player.resources.getDeficit(price, HELPER_RESOURCE);

					for each (var resourceType:String in ResourceSet.TYPES) {
						if (!HELPER_RESOURCE.has(resourceType)) continue;

						var item:ResourceCounter = new ResourceCounter(resourceType, HELPER_RESOURCE, Layout.craft.priceIconSize);
						item.maxResources = new ResourceSet();
						item.disableOnZero = false;
						_resContainer.addChild(item);
					}

					_makeButton.price = PurchaseController.getResourceSetPrice(HELPER_RESOURCE);
				}
			}

			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				_descriptionTf.validate();
				_descriptionTf.x = super.width / 2 - _descriptionTf.width / 2;
			}
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

		private function handler_playerResourcesChange(event:*):void {
			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
