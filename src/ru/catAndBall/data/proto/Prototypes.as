package ru.catAndBall.data.proto {
	
	import ru.catAndBall.data.game.settings.PlayerSettings;
	import ru.catAndBall.data.proto.tools.ToolProtoCollection;
	import ru.catAndBall.data.game.buildings.constructions.ConstructionCollectionProto;
	import ru.catAndBall.data.game.settings.GridFieldSettings;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:05
	 */
	public class Prototypes {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Prototypes() {
			super();
		}

		public static const playerSettings:PlayerSettings = new PlayerSettings();

		public static const tools:ToolProtoCollection = new ToolProtoCollection();

		public static const constructions:ConstructionCollectionProto = new ConstructionCollectionProto();

		public static const ballsFieldSettings:GridFieldSettings = new GridFieldSettings();

		public static const rugFieldSettings:GridFieldSettings = new GridFieldSettings();

		public static const windowFieldSettings:GridFieldSettings = new GridFieldSettings();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function deserialize(input:Object):void {
			if ('player' in input) playerSettings.deserialize(input.player);
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
