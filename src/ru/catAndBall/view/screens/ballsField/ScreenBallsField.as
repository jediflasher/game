//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.ballsField {

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.screens.BaseScreenFieldData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	import ru.catAndBall.view.core.game.field.GridBackground;
	import ru.catAndBall.view.screens.ScreenType;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                14.08.14 22:05
	 */
	public class ScreenBallsField extends BaseScreenField {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenBallsField() {
			super(new BaseScreenFieldData(ScreenType.BALLS_FIELD, GameData.player.ballsField));
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------		}

		protected override function getBackground():GridBackground {
			return new GridBackground(
					AssetList.fields_balls_bg1,
					AssetList.fields_balls_bg2,
					AssetList.fields_balls_bg3,
					GameData.player.ballsField.columns,
					GameData.player.ballsField.rows
			);
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------
	}
}
