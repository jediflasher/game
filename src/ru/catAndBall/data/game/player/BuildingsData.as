package ru.catAndBall.data.game.player {
	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.data.game.buildings.CommodeData;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:06
	 */
	public class BuildingsData extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BuildingsData() {
			super();
		}

		public const catHouse:CatHouseData = new CatHouseData();

		public const commode:CommodeData = new CommodeData();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			if ('cat_house' in value) {
				catHouse.deserialize(value.cat_house);
			}

			if ('commode' in value) {
				commode.deserialize(value.commode);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			result['cat_house'] = catHouse.serialize();
			result['commode'] = commode.serialize();
			return result;
		}
	}
}
