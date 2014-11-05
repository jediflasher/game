package ru.catAndBall.data.game {
	import ru.catAndBall.data.game.field.BombGridCellData;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridCellType;
	import ru.catAndBall.data.game.field.PestGridCellData;
	import ru.catAndBall.data.game.field.ResourceGridCellData;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                26.08.14 8:29
	 */
	public class GridCellDataFactory {

		public static function getCell(gridCellType:int, column:int, row:int, settings:GridFieldSettings):GridCellData {
			var result:GridCellData;

			switch (gridCellType) {
				case GridCellType.WOLF:
				case GridCellType.PARROT:
				case GridCellType.DOG:
					result = new PestGridCellData(gridCellType, column, row, settings);
					break;
				case GridCellType.GRANNY:
					result = new BombGridCellData(gridCellType, column, row, settings);
					break;
				default:
					result = new ResourceGridCellData(gridCellType, column, row, settings);
					break;
			}

			if (GridCellType.hasResourceType(gridCellType)) {
				result.resourceType = GridCellType.getResourceType(gridCellType);
			}

			return result;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function GridCellDataFactory() {

		}
	}
}
