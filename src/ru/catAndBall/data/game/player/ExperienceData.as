package ru.catAndBall.data.game.player {
	import flash.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:08
	 */
	public class ExperienceData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ExperienceData() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _value:int;

		public function get value():int {
			return _value;
		}

		public function set value(value:int):void {
			if (_value == value) return;

			_value = value;
			super.dispatchEvent(Event.CHANGE);
		}

		public function get level():int {
			return int(_value / 100);
		}
	}
}
