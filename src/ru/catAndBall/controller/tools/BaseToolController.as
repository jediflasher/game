//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.tools {

	import flash.errors.IllegalOperationError;

	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.tools.BaseToolData;
	import ru.catAndBall.view.core.game.GridController;

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

		public function apply(fieldData:GridData, fieldView:GridController, settings:GridFieldSettings):void {
			if (_data.availableCount <= 0) throw new IllegalOperationError('no turns');

			_data.resourceSet.substractType(_data.resourceType, 1);
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
