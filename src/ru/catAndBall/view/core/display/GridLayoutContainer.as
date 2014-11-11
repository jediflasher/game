package ru.catAndBall.view.core.display {
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;

	import ru.catAndBall.view.core.game.ResourceCounter;

	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;

	import starling.display.Sprite;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                08.11.14 17:56
	 */
	public class GridLayoutContainer extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static var HELPER_POINT:Point = new Point();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function GridLayoutContainer(wCount:int, elementWidth:Number, elementHeight:Number, gapW:int = 5, gapH:int = 5) {
			super();
			_maxWidthCount = wCount;
			_elementHeight = elementHeight;
			_elementWidth = elementWidth;
			_gapW = gapW;
			_gapH = gapH;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _maxWidthCount:int;

		private var _elementWidth:Number;

		private var _elementHeight:Number;

		private var _gapW:int;

		private var _gapH:int;

		private var _numChildren:int;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function addChild(child:DisplayObject):DisplayObject {
			const pos:Point = getPositionByIndex(_numChildren);
			child.x = pos.x;
			child.y = pos.y;
			super.addChild(child);
			_numChildren++;
			return child;
		}

		public override function removeChild(child:DisplayObject, dispose:Boolean = false):DisplayObject {
			throw new IllegalOperationError('Cant remove from GridLayout');
		}

		public override function removeChildren(beginIndex:int=0, endIndex:int=-1, dispose:Boolean=false):void {
			throw new IllegalOperationError('Use clear method');
		}

		public function clear():void {
			_numChildren = 0;
			super.removeChildren();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function getPositionByIndex(index:int):Point {
			var countX:int = (index - int(index / _maxWidthCount) * _maxWidthCount);
			var countY:int = int(index / _maxWidthCount);

			HELPER_POINT.x = countX * _elementWidth + countX * _gapW;
			HELPER_POINT.y = countY * _elementHeight + countY * _gapH;

			return HELPER_POINT;
		}
	}
}
