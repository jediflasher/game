package ru.catAndBall.data.proto {
	
	import ru.catAndBall.view.core.utils.L;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:06
	 */
	public class ConstructionProto {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionProto() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const states:Vector.<ConstructionStateProto> = new Vector.<ConstructionStateProto>();

		public var id:String;

		public var alwaysShow:Boolean;

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

			if ('alwaysShow' in input) {
				alwaysShow = input.alwaysShow;
			}

			var st:Array = input.states;
			if (st) {
				var len:int = st.length;
				for (var i:int = 0; i < len; i++) {
					var state:ConstructionStateProto = createState();
					state.index = i;
					state.deserialize(st[i]);
					states.push(state);
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		protected function createState():ConstructionStateProto {
			return new ConstructionStateProto();
		}
	}
}
