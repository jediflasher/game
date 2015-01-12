package ru.catAndBall.data.dict {
	import ru.catAndBall.data.dict.constructions.ConstructionCollectionDict;
	import ru.catAndBall.data.dict.tools.ToolsDict;
	import ru.catAndBall.data.game.GridFieldSettings;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:05
	 */
	public class Dictionaries {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Dictionaries() {
			super();
		}

		public static const tools:ToolsDict = new ToolsDict();

		public static const constructions:ConstructionCollectionDict = new ConstructionCollectionDict();

		public static const ballsFieldSettings:GridFieldSettings = new GridFieldSettings();

		public static const rugFieldSettings:GridFieldSettings = new GridFieldSettings();

		public static const windowFieldSettings:GridFieldSettings = new GridFieldSettings();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function deserialize(input:Object):void {
			if ('tools' in input) tools.deserialize(input.tools);
			if ('constructions' in input) constructions.deserialize(input.constructions);
			if ('fields' in input) {
				if ('balls' in input.fields) {
					ballsFieldSettings.deserialize(input.fields['balls']);
				}

				if ('rug' in input.fields) {
					rugFieldSettings.deserialize(input.fields['rug']);
				}

				if ('window' in input) {
					windowFieldSettings.deserialize(input.fields['window']);
				}
			}
		}
	}
}
