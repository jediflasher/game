//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.tools {

	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.tools.BaseToolData;
	import ru.catAndBall.data.game.tools.ToolCollectCellsData;
	import ru.catAndBall.view.core.game.GridController;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                12.08.14 18:42
	 */
	public class ToolCollectCells extends BaseToolController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ToolCollectCells(data:BaseToolData) {
			super(data);
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public override function apply(fieldData:GridData, fieldView:GridController, settings:GridFieldSettings):void {
			super.apply(fieldData, fieldView, settings);

			var types:Vector.<int> = (data as ToolCollectCellsData).types;
			var cells:Vector.<GridCellData> = new Vector.<GridCellData>();

			for each (var type:String in types) {
				var c:Vector.<GridCellData> = fieldData.getCellsByType(int(type));
				if (c) cells = cells.concat(c);
			}

			var newCells:Vector.<GridCellData> = settings.generator.getGridCells(cells);

			fieldView.removeCells(cells);
			fieldData.collectCells(cells, newCells);
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
