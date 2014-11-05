//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.field {

	import flash.events.EventDispatcher;

	import ru.catAndBall.data.game.GridFieldSettings;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                23.06.14 23:09
	 */
	public class GridCellData extends EventDispatcher {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridCellData(gridCellType:int, column:int, row:int, settings:GridFieldSettings) {
			super();
			this.type = gridCellType;
			this.column = column;
			this.row = row;
			_settings = settings;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public var type:int;

		public var column:int;

		public var row:int;

		public var family:int;

		public var destroyed:Boolean;

		public function get nextLevelCount():int {
			if (type in _settings.customUpgradeLimits) return _settings.customUpgradeLimits[type];
			return _settings.baseUpgradeLimit;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _settings:GridFieldSettings;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function isNeighbor(cell:GridCellData):Boolean {
			var rowDelta:int = cell.row - row;
			var colDelta:int = cell.column - column;
			var rOk:Boolean = rowDelta < 2 && rowDelta > -2;
			var cOk:Boolean = colDelta < 2 && colDelta > -2;

			if (!rowDelta && !colDelta) return false;

			return rOk && cOk;
		}
	}
}
