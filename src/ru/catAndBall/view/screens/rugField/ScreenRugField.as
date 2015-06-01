//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.rugField {

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.data.game.screens.BaseScreenFieldData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	import ru.catAndBall.view.core.game.field.GridBackground;
	import ru.catAndBall.view.core.game.field.ObjectsCounter;
	import ru.catAndBall.view.screens.ScreenType;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                07.06.14 19:20
	 */
	public class ScreenRugField extends BaseScreenField {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenRugField() {
			super(new BaseScreenFieldData(ScreenType.RUG_FIELD, GameData.player.rugField));
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected override function getBackground():GridBackground {
			return new GridBackground(
					AssetList.fields_carpet_carpetBg1,
					AssetList.fields_carpet_carpetBg2,
					AssetList.fields_carpet_carpetBg3,
					screenData.gridData.columns,
					screenData.gridData.rows
			);
		}

		protected override function getBorder():String {
			return AssetList.fields_carpet_carpetBgDown;
		}
	}
}
