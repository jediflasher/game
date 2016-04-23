package ru.catAndBall.view.screens.room.drop {

	import ru.flaswf.parsers.feathers.ObjectBuilder;

	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                10.04.2016 14:20
	 */
	public class ConstructionCollectIcon extends Image {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ConstructionCollectIcon() {
			var t:Texture = ObjectBuilder.getTexture('CollectExpIcon');
			super(t);

			touchable = false;
			pivotX = t.width / 2;
			pivotY = t.height / 2;
		}
	}
}
