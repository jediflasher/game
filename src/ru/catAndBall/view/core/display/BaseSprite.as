package ru.catAndBall.view.core.display {
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.10.14 17:03
	 */
	public class BaseSprite extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseSprite() {
			super();
			super.addEventListener(Event.ADDED_TO_STAGE, this.added);
			super.addEventListener(Event.REMOVED_FROM_STAGE, this.removed);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function added(event:* = null):void {

		}

		protected function removed(event:* = null):void {

		}
	}
}
