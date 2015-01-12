package ru.catAndBall.data.dict.constructions {
	import ru.catAndBall.data.dict.ConstructionDict;

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
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function getConstructionById(id:String):ConstructionDict {
			return _hash[id];
		}

		public function deserialize(input:Object):void {
			for each(var obj:Object in input) {
				var dict:ConstructionDict = new ConstructionDict();
				dict.deserialize(obj);
				_hash[dict.id] = dict;
			}
		}
	}
}
