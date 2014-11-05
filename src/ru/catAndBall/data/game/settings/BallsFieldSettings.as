package ru.catAndBall.data.game.settings {
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.GridCellType;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                26.08.14 8:04
	 */
	public class BallsFieldSettings extends GridFieldSettings {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BallsFieldSettings() {
			elements = new <int>[
				GridCellType.BALL_BLUE,
				GridCellType.BALL_RED,
				GridCellType.BALL_GREEN,
				GridCellType.GRANNY
			];
			elementChances = new <Number>[0.32, 0.34, 0.31, 0.03];

			pests = new <int>[GridCellType.WOLF];
			pestsResultHash[GridCellType.WOLF] = GridCellType.SOCKS;
			pestsFoodHash[GridCellType.WOLF] = new <int>[
				GridCellType.SWEATER_BLUE,
				GridCellType.SWEATER_RED,
				GridCellType.SWEATER_PURPLE,
				GridCellType.SWEATER_GREEN,
				GridCellType.TOY_BLUE,
				GridCellType.TOY_RED,
				GridCellType.TOY_PURPLE,
				GridCellType.TOY_GREEN
			];

			pestChance = 0.03;

			fieldHeight = fieldWidth = 7;

			upgradeHash = {};
			upgradeHash[GridCellType.BALL_BLUE] = GridCellType.TOY_BLUE;
			upgradeHash[GridCellType.TOY_BLUE] = GridCellType.SWEATER_BLUE;
			upgradeHash[GridCellType.SWEATER_BLUE] = GridCellType.BALL_GOLD;

			upgradeHash[GridCellType.BALL_GREEN] = GridCellType.TOY_GREEN;
			upgradeHash[GridCellType.TOY_GREEN] = GridCellType.SWEATER_GREEN;
			upgradeHash[GridCellType.SWEATER_GREEN] = GridCellType.BALL_GOLD;

			upgradeHash[GridCellType.BALL_PURPLE] = GridCellType.TOY_PURPLE;
			upgradeHash[GridCellType.TOY_PURPLE] = GridCellType.SWEATER_PURPLE;
			upgradeHash[GridCellType.SWEATER_PURPLE] = GridCellType.BALL_GOLD;

			upgradeHash[GridCellType.BALL_RED] = GridCellType.TOY_RED;
			upgradeHash[GridCellType.TOY_RED] = GridCellType.SWEATER_RED;
			upgradeHash[GridCellType.SWEATER_RED] = GridCellType.BALL_GOLD;

			bombsResultHash[GridCellType.GRANNY] = GridCellType.SOCKS;

			baseUpgradeLimit = 7;
			baseStackSize = 7;
			baseConnectCount = 3;

			connectCounts = {};
			connectCounts[GridCellType.BALL_GOLD] = 1;

			turnCount = 30;
		}
	}
}
