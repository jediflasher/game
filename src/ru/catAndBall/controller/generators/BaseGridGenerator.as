//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.generators {

	import flash.errors.IllegalOperationError;

	import ru.catAndBall.controller.IGridGenerator;
	import ru.catAndBall.data.game.GridCellDataFactory;
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridCellType;

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
			parse(_settings.elements, _settings.elementChances);
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

		public function getChance(type:int):Number {
			return _hash[type].chance;
		}

		public function updateChances(gridCellTypes:Vector.<String>, chances:Vector.<Number>):void {
			_limits.length = 0;
			_list.length = 0;
			for (var key:String in _hash) delete _hash[key];

			parse(gridCellTypes, chances);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function parse(gridCellTypes:Vector.<String>, chances:Vector.<Number>):void {
			var nextLimit:Number = 0;

			var len:int = gridCellTypes.length;
			for(var i:int = 0; i < len; i++) {
				var type:String = gridCellTypes[i];
				var chance:Number = chances[i];

				var ch:Chance = new Chance();
				ch.gridCellType = type;
				ch.chance = chance;

				_hash[type] = ch;

				nextLimit += chance;
				nextLimit = Math.round(nextLimit * 1000) / 1000;
				_limits.push(nextLimit);
				_list.push(ch);
			}

			if (nextLimit != 1) throw new Error('Summ of all limits should be = 1');

		}
	}
}

class Chance {
	public var gridCellType:String;
	public var chance:Number;
}
