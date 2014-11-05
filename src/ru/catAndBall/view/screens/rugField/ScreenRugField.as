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
	import ru.catAndBall.view.core.game.field.BaseScreenFieldBackground;
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

		protected override function update(event:* = null):void {
			super.update();
		}

		protected override function getBackground():BaseScreenFieldBackground {
			return new BaseScreenFieldBackground(
					AssetList.Strip_moves_strip_moves,
					AssetList.fields_carpet_bg1,
					AssetList.fields_carpet_bg2,
					AssetList.fields_carpet_bg3,
					AssetList.fields_carpet_tangle_for_bg,
					AssetList.fields_carpet_tangle_for_bg_down,
					screenData.gridData.columns,
					screenData.gridData.rows
			);
		}
	}
}
