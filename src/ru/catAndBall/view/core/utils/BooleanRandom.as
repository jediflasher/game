package ru.catAndBall.view.core.utils {
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                03.09.14 8:33
	 */
	public class BooleanRandom {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BooleanRandom(chance:Number) {
			_baseChance = chance;
			_chance = _baseChance;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _baseChance:Number;

		private var _chance:Number;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function rand():Boolean {
			var result:Boolean = Math.random() <= _chance;
			/*if (!result) {
				_chance += _baseChance;
				if (_chance > 1) _chance = 1;
			} else {
				_chance = _baseChance;
			}*/
			return result;
		}

		public function reset():void {
			_chance = _baseChance;
		}
	}
}
