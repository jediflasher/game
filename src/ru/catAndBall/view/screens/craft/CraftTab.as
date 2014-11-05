package ru.catAndBall.view.screens.craft {
	import feathers.controls.Button;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.TextFieldTest;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                12.10.14 17:33
	 */
	public class CraftTab extends Button {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CraftTab(label:String = null) {
			super();

			defaultSkin = new Scale3Image(new Scale3Textures(Assets.getTexture(AssetList.Tools_name_tools_active), 40, 8));
			defaultSelectedSkin = new Scale3Image(new Scale3Textures(Assets.getTexture(AssetList.Tools_name_tools_passive), 40, 8));
			disabledSkin = new Scale3Image(new Scale3Textures(Assets.getTexture(AssetList.Tools_name_tools_unavailable), 40, 8));

			labelFactory = textFactory;
			this.label = label;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function textFactory():ITextRenderer {
			return new TextFieldTest();
		}
	}
}
