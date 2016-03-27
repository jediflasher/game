package ru.catAndBall.data.game.screens {
	
	import ru.catAndBall.data.game.field.GridData;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                05.11.14 9:25
	 */
	public class BaseScreenFieldData extends BaseScreenData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseScreenFieldData(screenType:String, fieldData:GridData) {
			super(screenType);
			this.gridData = fieldData;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var gridData:GridData;
	}
}
