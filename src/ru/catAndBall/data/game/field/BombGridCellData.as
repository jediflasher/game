package ru.catAndBall.data.game.field {
	
	import ru.catAndBall.data.game.settings.GridFieldSettings;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.08.14 8:56
	 */
	public class BombGridCellData extends GridCellData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BombGridCellData(gridCellType:String, column:int, row:int, settings:GridFieldSettings) {
			super(gridCellType, column, row, settings);
			family = GridCellFamily.BOMB;
		}

		public var readyToBlow:Boolean = false;

		public var bombResultCellType:int;


		public override function get collectable():Boolean {
			return false;
		}
	}
}
