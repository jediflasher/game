//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.tools {

	import flash.errors.IllegalOperationError;

	import ru.catAndBall.controller.screen.BaseScreenFieldController;
	import ru.catAndBall.data.game.GridCellDataFactory;

	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.tools.BaseToolData;
	import ru.catAndBall.view.core.game.GridContainer;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                10.08.14 13:58
	 */
	public class BaseToolController {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const HELPER_VECTOR:Vector.<GridCellData> = new Vector.<GridCellData>();

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseToolController(toolData:BaseToolData) {
			super();
			this._data = toolData;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function apply(fieldData:GridData, fieldView:GridContainer, screenFieldController:BaseScreenFieldController):void {
			if (_data.availableCount <= 0) throw new IllegalOperationError('no turns');

			_data.resourceSet.substractType(_data.dict.resourceType, 1);

			var collect:Vector.<String> = data.dict.elementsToCollect;
			if (collect.length) {
				for each (var type:String in collect) {
					var c:Vector.<GridCellData> = fieldData.getCellsByType(type);
					for each (var cell:GridCellData in c) {
						HELPER_VECTOR.push(cell);
					}
				}

				var newCells:Vector.<GridCellData> = fieldData.settings.generator.getGridCells(HELPER_VECTOR);

				fieldView.removeCells(HELPER_VECTOR);
				fieldData.collectCells(HELPER_VECTOR, newCells);
			}

			HELPER_VECTOR.length = 0;

			var replace:Object = data.dict.elementsToReplace;
			for (var fromType:String in replace) {
				var toType:String = replace[fromType];
				c = fieldData.getCellsByType(fromType);

				for each (cell in c) {
					var newCell:GridCellData = GridCellDataFactory.getCell(toType, cell.column, cell.row, fieldData.settings);
					screenFieldController.replaceCell(newCell);
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _data:BaseToolData;

		public function get data():BaseToolData {
			return _data;
		}
	}
}
