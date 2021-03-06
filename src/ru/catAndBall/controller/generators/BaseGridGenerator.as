//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.generators {
	
	import ru.catAndBall.controller.IGridGenerator;
	import ru.catAndBall.data.game.GridCellDataFactory;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.settings.GridFieldSettings;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 18:34
	 */
	public class BaseGridGenerator implements IGridGenerator {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseGridGenerator(settings:GridFieldSettings) {
			super();
			_settings = settings;
			_settings.generator = this;
			parse(_settings.elements.elements, _settings.elements.chances);
			parse(_settings.startElements.elements, _settings.startElements.chances, true);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var pestToGenerate:String;

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private const _hash:Object = {}; // type -> Chance

		private const _list:Vector.<Chance> = new Vector.<Chance>();

		private const _limits:Vector.<Number> = new Vector.<Number>();

		private const _startHash:Object = {}; // type -> Chance

		private const _startList:Vector.<Chance> = new Vector.<Chance>();

		private const _startLimits:Vector.<Number> = new Vector.<Number>();

		private var _settings:GridFieldSettings;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function getGridCells(collectedCells:Vector.<GridCellData>):Vector.<GridCellData> {
			var result:Vector.<GridCellData> = new Vector.<GridCellData>();
			var columnsHash:Object = {};

			var len:int = collectedCells.length;
			for (var i:int = 1; i < len + 1; i++) {
				var collectedCell:GridCellData = collectedCells[i - 1];
				var column:int = collectedCell.column;
				columnsHash[column] ||= 0;
				var row:int = columnsHash[column]++;

				var resultCell:GridCellData;

				if (pestToGenerate) {
					resultCell = GridCellDataFactory.getCell(pestToGenerate, column, row, _settings);
				} else  {
					// каждая n-я – бонусная
					var nextLevelCellType:String = _settings.upgradeHash[collectedCell.type];
					if (!(i % collectedCell.nextLevelCount) && nextLevelCellType) {
						resultCell = GridCellDataFactory.getCell(nextLevelCellType, column, row, _settings);
					} else {
						resultCell = getGridCell(column, row);
					}
				}

				result.push(resultCell);
			}

			return result;
		}

		public function getGridCell(column:int, row:int):GridCellData {
			var rnd:Number = Math.random();
			var len:int = _limits.length;

			var chance:Chance;

			for (var i:int = 0; i < len; i++) {
				var limit:Number = _limits[i];
				if (rnd < limit) {
					chance = _list[i];
					break;
				}
			}

			return GridCellDataFactory.getCell(chance.gridCellType, column, row, _settings);
		}

		public function getStartGridCell(column:int, row:int):GridCellData {
			var rnd:Number = Math.random();
			var len:int = _startLimits.length;

			var chance:Chance;

			for (var i:int = 0; i < len; i++) {
				var limit:Number = _startLimits[i];
				if (rnd < limit) {
					chance = _startList[i];
					break;
				}
			}

			return GridCellDataFactory.getCell(chance.gridCellType, column, row, _settings);
		}

		public function getChance(type:int):Number {
			return _hash[type].chance;
		}

		public function getStartChance(type:int):Number {
			return _startHash[type].chance;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function parse(gridCellTypes:Vector.<String>, chances:Vector.<Number>, isStart:Boolean = false):void {
			var nextLimit:Number = 0;

			var len:int = gridCellTypes.length;
			for(var i:int = 0; i < len; i++) {
				var type:String = gridCellTypes[i];
				var chance:Number = chances[i];

				var ch:Chance = new Chance();
				ch.gridCellType = type;
				ch.chance = chance;

				(isStart ? _startHash : _hash)[type] = ch;

				nextLimit += chance;
				nextLimit = Math.round(nextLimit * 1000) / 1000;
				(isStart ? _startLimits : _limits).push(nextLimit);
				(isStart ? _startList : _list).push(ch);
			}

			if (nextLimit != 1) throw new Error('Summ of all limits should be = 1');

		}
	}
}

class Chance {
	public var gridCellType:String;
	public var chance:Number;
}
