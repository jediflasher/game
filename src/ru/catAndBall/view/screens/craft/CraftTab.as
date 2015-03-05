package ru.catAndBall.view.screens.craft {
	import feathers.controls.Button;
	import feathers.controls.ToggleButton;
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
	public class CraftTab extends ToggleButton {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CraftTab(label:String = null) {
			super();

			defaultSkin = Assets.getImage(AssetList.Tools_shelfPassive);
			defaultSelectedSkin = Assets.getImage(AssetList.Tools_shelfActive);
			disabledSkin = Assets.getImage(AssetList.Tools_shelfDisabled);

			defaultLabelProperties.wordWrap = true;
			defaultLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_medium_darkmilk_shadow);
			disabledLabelProperties.wordWrap = true;
			disabledLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_medium_greymilk_shadow);
			selectedUpLabelProperties.wordWrap = true;
			selectedUpLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_medium_milk_shadow);
			selectedDownLabelProperties.wordWrap = true;
			selectedDownLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_medium_milk_shadow);
			selectedHoverLabelProperties.wordWrap = true;
			selectedHoverLabelProperties.textFormat = new BitmapFontTextFormat(AssetList.font_medium_milk_shadow);

			isToggle = false;
//			paddingRight = Layout.baseGap;
//			paddingLeft = Layout.baseGap;

			this.label = label;
		}


		public override function set isSelected(value:Boolean):void {
			super.isSelected = value;
			invalidate(INVALIDATION_FLAG_SIZE);
		}

//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
}
