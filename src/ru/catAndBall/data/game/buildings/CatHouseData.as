package ru.catAndBall.data.game.buildings {
	import ru.catAndBall.data.dict.ConstructionDict;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:34
	 */
	public class CatHouseData extends ConstructionData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CatHouseData(dict:ConstructionDict) {
			super(dict);
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			return result;
		}
	}
}
