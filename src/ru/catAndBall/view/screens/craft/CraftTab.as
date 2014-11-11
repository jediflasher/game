package ru.catAndBall.view.screens.craft {
	import feathers.controls.Button;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	import feathers.text.BitmapFontTextFormat;
	import feathers.textures.Scale3Textures;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.text.TextFieldTest;
	import ru.catAndBall.view.layout.Layout;

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

			defaultSkin = new Scale3Image(new Scale3Textures(Assets.getTexture(AssetList.Tools_name_tools_passive), 40, 8));
			defaultSelectedSkin = new Scale3Image(new Scale3Textures(Assets.getTexture(AssetList.Tools_name_tools_active), 40, 8));
			disabledSkin = new Scale3Image(new Scale3Textures(Assets.getTexture(AssetList.Tools_name_tools_unavailable), 40, 8));

			defaultLabelProperties.wordWrap = true;
			defaultLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_xsmall_lightbrown_bold);
			disabledLabelProperties.wordWrap = true;
			disabledLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_xsmall_grey_bold);
			selectedUpLabelProperties.wordWrap = true;
			selectedUpLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_xsmall_milk_bold);
			selectedDownLabelProperties.wordWrap = true;
			selectedDownLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_xsmall_milk_bold);
			selectedHoverLabelProperties.wordWrap = true;
			selectedHoverLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_xsmall_milk_bold);

			paddingRight = Layout.baseGap;
			paddingLeft = Layout.baseGap;

			this.label = label;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
}
