package ru.catAndBall.view.core.ui {
	import feathers.controls.Button;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import ru.catAndBall.view.assets.AssetList;

	import ru.catAndBall.view.assets.Assets;

	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.layout.Layout;

	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 8:42
	 */
	public class SmallGreenButton extends Button {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function SmallGreenButton(label:String) {
			super();

			labelFactory = function():ITextRenderer {
				return new BaseTextField(AssetList.font_small_white_greenstroke_bold);
			};

			const left:Number =  Layout.smallButtonScaleGridSizes[0];
			const center:Number =  Layout.smallButtonScaleGridSizes[1];

			var texture:Texture = Assets.getTexture(AssetList.buttons_XS_greenbutton);
			upSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			hoverSkin = upSkin;

			texture = Assets.getTexture(AssetList.buttons_XS_greenbutton_on);
			downSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			texture = Assets.getTexture(AssetList.buttons_XS_greenbutton_off);
			disabledSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			paddingRight = paddingLeft = Layout.baseGap;

			super.label = label;
		}
	}
}
