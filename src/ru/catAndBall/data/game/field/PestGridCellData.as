package ru.catAndBall.data.game.field {
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.event.data.DataEvent;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.08.14 8:53
	 */
	public class PestGridCellData extends GridCellData {

		public static const EVENT_TURNS_CHANGE:String = 'turnsChange';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function PestGridCellData(gridCellType:String, column:int, row:int, settings:GridFieldSettings) {
			super(gridCellType, column, row, settings);
			family = GridCellFamily.PEST;
		}

		private var _turnsLeft:int;

		public function get turnsLeft():int {
			return _turnsLeft;
		}

		public var prevColumn:int = 0;

		public var prevRow:int = 0;

		public function set turnsLeft(value:int):void {
			if (_turnsLeft == value) return;

			_turnsLeft = value;

			dispatchEvent(new DataEvent(EVENT_TURNS_CHANGE));
		}
	}
}
