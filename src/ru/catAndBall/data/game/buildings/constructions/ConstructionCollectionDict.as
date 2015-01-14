package ru.catAndBall.data.game.buildings.constructions {
	import ru.catAndBall.data.dict.CommodeShelfDict;
	import ru.catAndBall.data.dict.ConstructionDict;
	import ru.catAndBall.data.game.buildings.ConstructionData;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.12.14 22:48
	 */
	public class ConstructionCollectionDict {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionCollectionDict() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _hash:Object = {}; // id -> ConstructionDict

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const list:Vector.<ConstructionDict> = new Vector.<ConstructionDict>();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function getConstructionById(id:String):ConstructionDict {
			return _hash[id];
		}

		public function deserialize(input:Object):void {
			for each(var obj:Object in input) {
				var dict:ConstructionDict = getConstructionDict(obj);
				_hash[dict.id] = dict;
				list.push(dict);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function getConstructionDict(obj:Object):ConstructionDict {
			var id:String = obj.id;
			var result:ConstructionDict;

			switch (id) {
				case ConstructionData.COMMODE_1:
				case ConstructionData.COMMODE_2:
				case ConstructionData.COMMODE_3:
					result = new CommodeShelfDict();
					break;
				default:
					result = new ConstructionDict();
			}

			result.deserialize(obj);
			return result;
		}
	}
}
