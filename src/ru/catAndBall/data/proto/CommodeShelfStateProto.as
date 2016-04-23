package ru.catAndBall.data.proto {
	
	import ru.catAndBall.data.proto.tools.ToolProto;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.03.15 9:39
	 */
	public class CommodeShelfStateProto extends ConstructionStateProto {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeShelfStateProto() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const tools:Vector.<ToolProto> = new Vector.<ToolProto>();

		public override function deserialize(input:Object):void {
			super.deserialize(input);

			if ('tools' in input) {
				for each (var id:String in input.tools) {
					var tool:ToolProto = Prototypes.tools.getToolByResourceType(id);
					tools.push(tool);
				}
			}
		}
	}
}
