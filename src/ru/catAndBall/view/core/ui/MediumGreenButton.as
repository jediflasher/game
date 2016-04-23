package ru.catAndBall.view.core.ui {
	
	import feathers.controls.Button;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import ru.catAndBall.utils.s;
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
	 * @date                03.11.14 16:16
	 */
	public class MediumGreenButton extends Button {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function MediumGreenButton(label:String) {
			super();

			labelFactory = function():ITextRenderer {
				return new BaseTextField(0, 30);
			};

			var left:Number =  s(Layout.mediumButtonScaleGridSizes[0]);
			var center:Number = s(Layout.mediumButtonScaleGridSizes[1]);

			var texture:Texture = Assets.getTexture(AssetList.buttons_S_buttonGreen);
			defaultSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			texture = Assets.getTexture(AssetList.buttons_S_buttonGreen_on);
			downSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			texture = Assets.getTexture(AssetList.buttons_S_buttonGreen_off);
			disabledSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			paddingRight = paddingLeft = s(Layout.baseGap);

			super.label = label;
		}
	}
}
