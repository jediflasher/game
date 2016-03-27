package ru.catAndBall.view.screens.room {
	
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;
	
	import starling.display.Image;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.10.14 14:32
	 */
	public class Granny extends BaseSprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Granny() {
			super();
			addChild(new Image(Assets.DUMMY_TEXTURE));
		}
	}
}
