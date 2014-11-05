package ru.catAndBall.data.game.settings {
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridCellType;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                26.08.14 8:04
	 */
	public class RugFieldSettings extends GridFieldSettings {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function RugFieldSettings() {
			elements = new <int>[
				GridCellType.BALL,
				GridCellType.COOKIE,
				GridCellType.WRAPPER,
				GridCellType.THREAD
			];
			elementChances = new <Number>[0.46, 0.46, 0.04, 0.04];

			pests = new <int>[GridCellType.DOG, GridCellType.PARROT];
			pestsResultHash[GridCellType.DOG] = GridCellType.WRAPPER;
			pestsFoodHash[GridCellType.DOG] = new <int>[
				GridCellType.BALL,
				GridCellType.COOKIE,
				GridCellType.MOUSE,
				GridCellType.SAUSAGE,
				GridCellType.PIGEON,
				GridCellType.CONSERVE
			];

			pestsResultHash[GridCellType.PARROT] = GridCellType.THREAD;
			pestsFoodHash[GridCellType.PARROT] = new <int>[
				GridCellType.BALL,
				GridCellType.COOKIE,
				GridCellType.MOUSE,
				GridCellType.SAUSAGE,
				GridCellType.PIGEON,
				GridCellType.CONSERVE
			];

			pestChance = 0.01;

			fieldHeight = fieldWidth = 7;

			upgradeHash = {};
			upgradeHash[GridCellType.BALL] = GridCellType.MOUSE;
			upgradeHash[GridCellType.MOUSE] = GridCellType.PIGEON;
			upgradeHash[GridCellType.PIGEON] = GridCellType.GOLD_FISH;

			upgradeHash[GridCellType.COOKIE] = GridCellType.SAUSAGE;
			upgradeHash[GridCellType.SAUSAGE] = GridCellType.CONSERVE;
			upgradeHash[GridCellType.CONSERVE] = GridCellType.GOLD_FISH;

			connectCounts = {};
			connectCounts[GridCellType.GOLD_FISH] = 1;

			turnCount = 30;
		}
	}
}
