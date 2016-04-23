package ru.catAndBall.view.screens.room {
	
	import ru.catAndBall.view.core.game.Construction;
	import ru.flaswf.reader.descriptors.DisplayObjectDescriptor;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 14:54
	 */
	public class CatHouse extends Construction {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CatHouse(source:DisplayObjectDescriptor) {
			super(source);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public override function get hintX():int {
			return 260;
		}

		public override function get hintY():int {
			return 30;
		}
	}
}
