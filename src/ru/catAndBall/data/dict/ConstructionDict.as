package ru.catAndBall.data.dict {
	import ru.catAndBall.utils.s;
	import ru.catAndBall.utils.str;
	import ru.catAndBall.view.core.utils.L;

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

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const states:Vector.<ConstructionState> = new Vector.<ConstructionState>();

		public var id:String;

		public function get maxLevel():int {
			return states.length;
		}

		public function get name():String {
			return L.get('construction.' + id + '.name');
		}

		public function get description():String {
			return L.get('construction.' + id + '.desc');
		}

		public function deserialize(input:Object):void {
			if ('id' in input) {
				this.id = input.id;
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
