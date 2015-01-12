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

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function deserialize(value:Object):void {
			if ('dictionaries' in value) {
				dictionaries.deserialize(value.dictionaries);
			}

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
