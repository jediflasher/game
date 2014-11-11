package ru.catAndBall.data.dict.tools {
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.core.utils.L;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 22:12
	 */
	public class ToolDict {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ToolDict(resourceType:String) {
			super();
			this.resourceType = resourceType;
		}

		public var resourceType:String;

		private var _name:String;

		public function get name():String {
			if (!_name) _name = L.get('tool.%s.name', [resourceType]);
			return _name;
		}

		private var _description:String;

		public function get description():String {
			if (!_description) _description = L.get('tool.%s.desc', [resourceType]);
			return _description;
		}

		public const price:ResourceSet = new ResourceSet();
	}
}
