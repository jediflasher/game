package ru.catAndBall.data.dict {
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:06
	 */
	public class ConstructionDict {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionDict() {
			super();
		}

		public const states:Vector.<ConstructionState> = new Vector.<ConstructionState>();

		public var catHouseLevel:int;

		public var id:String;

		public function get maxLevel():int {
			return states.length;
		}

		public function deserialize(input:Object):void {
			if ('id' in input) {
				this.id = input.id;
			}

			if ('catHouseLevel' in input) {
				this.catHouseLevel = input.catHouseLevel;
			}

			var st:Array = input.states;
			if (st) {
				var len:int = st.length;
				for (var i:int = 0; i < len; i++) {
					var state:ConstructionState = new ConstructionState();
					state.index = i;
					state.deserialize(st[i]);
					states.push(state);
				}
			}
		}
	}
}
