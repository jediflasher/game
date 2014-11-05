//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.ui {

	import ru.catAndBall.view.assets.Assets;

	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                08.06.14 14:55
	 */
	public class BaseButton extends Button {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseButton(upStateId:String, downStateId:String = null, tUpStateId:String = null, tDownStateId:String = null) {
			var upState:Texture = Assets.getTexture(upStateId);
			var downState:Texture = downStateId ? Assets.getTexture(downStateId) : null;

			super(upState, "", downState);

			if (tUpStateId) {
				var texture:Texture = Assets.getTexture(tUpStateId);
				_upText = new Image(texture);
				_upText.x = width / 2 - _upText.width / 2;
				_upText.y = height / 2 - _upText.height / 2;
				addChild(_upText);
			}

			if (tDownStateId) {
				texture = Assets.getTexture(tDownStateId);
				_downText = new Image(texture);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _upText:Image;

		private var _downText:Image;

	}
}
