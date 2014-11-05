//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller {

	import ru.catAndBall.data.game.field.GridCellData;

	public interface IGridGenerator {

		function getGridCells(collectedCells:Vector.<GridCellData>):Vector.<GridCellData>;

		function getGridCell(coumn:int, row:int):GridCellData;

		//function addChance(type:int, chance:Number):void;

		function getChance(type:int):Number;
	}
}
