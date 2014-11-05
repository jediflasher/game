package ru.catAndBall.data.game.field {
	import ru.catAndBall.data.game.GridFieldSettings;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.08.14 8:55
	 */
	public class ResourceGridCellData extends GridCellData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceGridCellData(gridCellType:int, column:int, row:int, settings:GridFieldSettings) {
			super(gridCellType, column, row, settings);
			family = GridCellFamily.RESOURCE;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get resourceType():String {
			return GridCellType.getResourceType(type);
		}
	}
}
