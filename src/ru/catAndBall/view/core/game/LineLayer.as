//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {
	
	import ru.catAndBall.view.core.utils.Line;
	
	import starling.display.Sprite;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                25.06.14 14:39
	 */
	public class LineLayer extends Sprite {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function LineLayer() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function lineTo(fromX:int, fromY:int, toX:int, toY:int):void {
			var line:Line = new Line();
			addChild(line);
			line.draw(fromX, fromY, toX, toY);
		}

		public function removeLastLine():void {
			removeChildAt(numChildren - 1, true);
		}

		public function clear():void {
			this.removeChildren(0, -1, true);
		}
	}
}
