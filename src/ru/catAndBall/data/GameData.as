//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data {
	import ru.catAndBall.data.dict.Dictionaries;
	import ru.catAndBall.data.game.player.Player;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                24.06.14 12:42
	 */
	public class GameData extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------

		public static const player:Player = new Player();

		public static const dictionaries:Dictionaries = new Dictionaries();

		public static const defaulState:Object = {
		"player": {
			"buildings": {
				"cat_house": {
					"level": 1,
					"startBuildingTime": 0,
					"lastBonusTime": 0
				},
				"commode": {
					"level": 0,
					"startBuildingTime": 0,
					"lastBonusTime": 0
				}
			},
			"resources": {
				'experience': 0,
				'money': 0,
				'toolCollectSocks': 0,
				'bfBalls': 0,
				'bfSocks': 0,
				'bfSweaters': 0,
				'bgToys': 0,
				'rfBall': 0,
				'rfCookie': 0,
				'rfMouse': 0,
				'rfSausage': 0,
				'rfPigeon': 0,
				'rfConserve': 0,
				'rfWrapper': 0,
				'rfThread': 0
			}
		}
	};

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function deserialize(value:Object):void {
			if ('player' in value) {
				player.deserialize(value.player);
			}
		}

		public static function serialize():Object {
			var result:Object = {};
			result['player'] = player.serialize();
			return result;
		}

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GameData() {
			super();
		}
	}
}
