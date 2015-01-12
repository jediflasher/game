package ru.catAndBall.data.game.player {
	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.dict.ConstructionDict;
	import ru.catAndBall.data.dict.Dictionaries;
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.data.game.buildings.ConstructionData;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:06
	 */
	public class ConstructionCollectionData extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionCollectionData() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private const _hash:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var catHouse:CatHouseData;

		public var commode1:ConstructionData;

		public var commode2:ConstructionData;

		public var commode3:ConstructionData;

		public const list:Vector.<ConstructionData> = new Vector.<ConstructionData>();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			for each(var obj:Object in value) {
				var id:String = obj.id;
				var construction:ConstructionData = getConstructionById(id);
				if (!construction) {
					construction = _hash[id] = createConstruction(id);
					list.push(construction)
				}

				construction.deserialize(obj);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			for each (var construction:ConstructionData in list) {
				result[construction.dict.id] = construction.serialize();
			}
			return result;
		}

		public function getConstructionById(id:String):ConstructionData {
			return _hash[id] as ConstructionData;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function createConstruction(id:String):ConstructionData {
			var dict:ConstructionDict = Dictionaries.constructions.getConstructionById(id);
			switch (id) {
				case ConstructionData.CAT_HOUSE:
					catHouse = new CatHouseData(dict);
					return catHouse;
				case ConstructionData.COMMODE_1:
					commode1 = new ConstructionData(dict);
					return commode1;
				case ConstructionData.COMMODE_2:
					commode2 = new ConstructionData(dict);
					return commode2;
				case ConstructionData.COMMODE_3:
					commode3 = new ConstructionData(dict);
					return commode3;
			}

			return null;
		}
	}
}
