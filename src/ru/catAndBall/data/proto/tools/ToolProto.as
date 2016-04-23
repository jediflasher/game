package ru.catAndBall.data.proto.tools {
	
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.utils.str;
	import ru.catAndBall.view.core.utils.ArrayUtils;
	import ru.catAndBall.view.core.utils.L;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 22:12
	 */
	public class ToolProto {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ToolProto(resourceType:String) {
			super();
			this.resourceType = resourceType;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var resourceType:String;

		public var elementsToCollect:Vector.<String> = new Vector.<String>();

		public var elementsToReplace:Object = {}; // hash element -> element

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _name:String;

		public function get name():String {
			if (!_name) _name = L.get(str('tool.%s.name', [resourceType]));
			return _name;
		}

		private var _description:String;

		public function get description():String {
			if (!_description) _description = L.get(str('tool.%s.desc', [resourceType]));
			return _description;
		}

		public const price:ResourceSet = new ResourceSet();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function deserialize(input:Object):void {
			if ('price' in input) {
				price.deserialize(input.price);
			}

			if ('collect' in input) {
				ArrayUtils.toVector(input.collect, elementsToCollect);
			}

			if ('replace' in input) elementsToReplace = input.replace;
		}
	}
}
