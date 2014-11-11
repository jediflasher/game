package ru.catAndBall.view.core.ui {
	import feathers.core.DefaultPopUpManager;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 13:13
	 */
	public class CatPopupManager extends DefaultPopUpManager {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CatPopupManager() {
			super();

			overlayFactory = function():DisplayObject {
				var quad:Quad = new Quad(100, 100, 0x000000);
				quad.alpha = 0.3;
				return quad;
			}
		}

		public override function addPopUp(popUp:DisplayObject, isModal:Boolean = true, isCentered:Boolean = true, customOverlayFactory:Function = null):DisplayObject {
			var result:DisplayObject = super.addPopUp(popUp, isModal, isCentered, customOverlayFactory);
			result.addEventListener(BasePopup.EVENT_CLOSE_CLICK, handler_closeClick);
			return result;
		}


		public override function removePopUp(popUp:DisplayObject, dispose:Boolean = false):DisplayObject {
			var result:DisplayObject = super.removePopUp(popUp, dispose);
			result.removeEventListener(BasePopup.EVENT_CLOSE_CLICK, handler_closeClick);
			return result;
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_closeClick(event:Event):void {
			removePopUp(event.target as DisplayObjectContainer);
		}
	}
}
