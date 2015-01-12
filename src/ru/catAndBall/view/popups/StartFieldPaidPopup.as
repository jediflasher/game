package ru.catAndBall.view.popups {
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.core.game.PriceButtonDecorator;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.ui.SuperPopup;

	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                30.11.14 15:41
	 */
	public class StartFieldPaidPopup extends SuperPopup {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function StartFieldPaidPopup() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _buttonDecorator:PriceButtonDecorator;

		private const _helperResources:ResourceSet = new ResourceSet();

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			resourceCounterFactory = function (resourceType:String, resourceSet:ResourceSet = null, size:int = 0):ResourceCounter {
				var rc:ResourceCounter = new ResourceCounter(resourceType, resourceSet, size);
				rc.maxResources = GameData.player.resources;
				;
				return rc;
			};

			_buttonDecorator = new PriceButtonDecorator(new MediumGreenButton(""), 'screen.room.popupPaid.makeFor', 'screen.room.popupPaid.makeFree');
			_buttonDecorator.button.addEventListener(Event.TRIGGERED, handler_buttonClick);

			GameData.player.resources.addEventListener(Event.CHANGE, handler_resourcePlayerChange);

			super.initialize();
		}

		protected override function getContent():Vector.<DisplayObject> {
			var result:Vector.<DisplayObject> = super.getContent();
			result.push(_buttonDecorator.button);
			return result;
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				GameData.player.resources.getDeficit(resourceSet, _helperResources);
				_buttonDecorator.price = PurchaseController.getDeficitPrice(_helperResources);
			}

			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_buttonClick(event:*):void {
			dispatchEventWith(EVENT_BUTTON_CLICK);
		}

		private function handler_resourcePlayerChange(event:*):void {
			invalidate(INVALIDATION_FLAG_DATA);
			invalidate(INVALIDATION_FLAG_LAYOUT);
		}

	}
}
