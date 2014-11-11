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
	 * @date                08.11.14 16:10
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
				return new BaseTextField(AssetList.font_small_white_greenstroke_bold);
			};

			const left:Number =  Layout.mediumButtonScaleGridSizes[0];
			const center:Number =  Layout.mediumButtonScaleGridSizes[1];

			var texture:Texture = Assets.getTexture(AssetList.buttons_S_greenbutton);
			upSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			texture = Assets.getTexture(AssetList.buttons_S_greenbutton_on);
			hoverSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			downSkin = hoverSkin;

			texture = Assets.getTexture(AssetList.buttons_S_greenbutton_off);
			disabledSkin = new Scale3Image(new Scale3Textures(texture, left, center));

			paddingRight = paddingLeft = Layout.baseGap;

			super.label = label;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _h:Number;

		public override function get height():Number {
			return _h;
		}
	}
}
