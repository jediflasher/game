package ru.catAndBall.data.game.settings {

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                06.06.15 20:29
	 */
	public class ElementsSettingsCollection {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ElementsSettingsCollection() {
			super();
		}

		public var elements:Vector.<String>;

		public var chances:Vector.<Number>;

		public var hash:Object;

		public function parse(data:Object):void {
			elements = new Vector.<String>();
			chances = new Vector.<Number>();

			hash = data;

			var sum:Number = 0;
			for (var elementName:String in data) {
				var chance:Number = data[elementName];
				elements.push(elementName);
				chances.push(chance);
				sum += chance;
			}
		}

		public function getChance(elementName:String):Number {
			return hash[elementName];
		}
	}
}
