//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.field {

	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import ru.catAndBall.controller.IGridGenerator;
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.event.data.DataEvent;
	import ru.catAndBall.utils.str;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                23.06.14 23:15
	 */
	public class GridData extends EventDispatcher {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_UPDATE_FIELD:String = 'eventGridUpdate';

		public static const EVENT_TURN_UPDATE:String = 'eventTurnUpdate';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridData(settings:GridFieldSettings) {
			super();

			_maxTurns = settings.turnCount;
			this.settings = settings;

			columns = settings.fieldHeight;
			rows = settings.fieldWidth;

			_cellsMatrix = new Vector.<Vector.<GridCellData>>(columns, true);

			for (var i:int = 0; i < columns; i++) {
				_cellsMatrix[i] = new Vector.<GridCellData>(rows, true);
			}
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public var settings:GridFieldSettings;

		public var columns:int;

		public var rows:int;

		public const collectedResources:ResourceSet = new ResourceSet();

		public function getCollectCount(type:int):int {
			if (type in settings.connectCounts) return int(settings.connectCounts[type]);
			return settings.baseConnectCount;
		}

		private var _currentTurn:int = 0;

		public function get currentTurn():int {
			return _currentTurn;
		}

		public function set currentTurn(value:int):void {
			if (_currentTurn == value) return;

			_currentTurn = value;
			dispatchEvent(new DataEvent(EVENT_TURN_UPDATE));
		}

		private var _maxTurns:int;

		public function get maxTurns():int {
			return _maxTurns;
		}

		public function set maxTurns(value:int):void {
			if (_maxTurns == value) return;

			_maxTurns = value;
			dispatchEvent(new DataEvent(EVENT_TURN_UPDATE));
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _cellsMatrix:Vector.<Vector.<GridCellData>>;

		private var _typesHash:Object = {};

		private var _familyHash:Object = {};

		private var _collectedResources:Object = {}; // ResourceType -> count

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public function addCell(cell:GridCellData):void {
			var column:Vector.<GridCellData> = getColumn(cell.column);
			if (column[cell.row]) throw new IllegalOperationError(str('Cell already added at %s, %s', [cell.column, cell.row]));

			column[cell.row] = cell;

			_typesHash[cell.type] ||= new Vector.<GridCellData>();
			(_typesHash[cell.type] as Vector.<GridCellData>).push(cell);

			_familyHash[cell.family] ||= new Vector.<GridCellData>();
			(_familyHash[cell.family] as Vector.<GridCellData>).push(cell);
		}

		public function replaceCell(newCell:GridCellData):void {
			var oldCell:GridCellData = getCellAt(newCell.column, newCell.row);
			if (oldCell) removeCell(oldCell);

			addCell(newCell);
		}

		public function collectCells(cells:Vector.<GridCellData>, newCells:Vector.<GridCellData>):void {
			var columns:Object = {};

			for each(var cell:GridCellData in cells) {
				_collectedResources[cell.resourceType] ||= 0;
				_collectedResources[cell.resourceType]++;

				removeCell(cell);
				columns[cell.column] = true;
			}

			for (var column:String in columns) {
				updateColumn(int(column));
			}

			for each(cell in newCells) {
				addCell(cell);
			}

			if (hasEventListener(EVENT_UPDATE_FIELD)) dispatchEvent(new DataEvent(EVENT_UPDATE_FIELD));
		}

		public function getCollectedResource(resourceType:String):int {
			return _collectedResources[resourceType];
		}

		public function fullFill(generator:IGridGenerator):void {
			for (var i:int = 0; i < columns; i++) {
				for (var j:int = 0; j < rows; j++) {
					if (!_cellsMatrix[i][j]) {
						var cell:GridCellData = generator.getGridCell(i, j);
						addCell(cell);
					}
				}
			}
		}

		[Inline]
		public final function getCellsByType(cellType:int):Vector.<GridCellData> {
			return _typesHash[cellType] as Vector.<GridCellData>;
		}

		public final function getCellsByFamily(gridCellFamily:int):Vector.<GridCellData> {
			return _familyHash[gridCellFamily];
		}

		[Inline]
		public final function getColumn(index:int):Vector.<GridCellData> {
			if (index < 0) return null;
			if (index > columns - 1) return null;
			return _cellsMatrix[index] as Vector.<GridCellData>;
		}

		[Inline]
		public final function clear():void {
			for (var i:int = 0; i < columns; i++) {
				for (var j:int = 0; j < rows; j++) {
					_cellsMatrix[i][j] = null;
				}
			}

			_typesHash = {};
			_familyHash = {};
			_collectedResources = {};
			_currentTurn = 0;
			maxTurns = 0;
		}

		[Inline]
		public final function getCellAt(column:int, row:int):GridCellData {
			if (row < 0) return null;
			if (row > rows - 1) return null;

			var c:Vector.<GridCellData> = getColumn(column);
			return c ? c[row] : null;
		}

		[Inline]
		public final function getCellsAround(column:int, row:int, includeCorners:Boolean = false, result:Vector.<GridCellData> = null):Vector.<GridCellData> {
			result ||= new Vector.<GridCellData>();

			var sx:int = column - 1;
			var fx:int = column + 1;
			var sy:int = row - 1;
			var fy:int = row + 1;

			for (var c:int = sx; c <= fx; c++) {
				for (var r:int = sy; r <= fy; r++) {
					if (c == column && r == row) continue;

					if (!includeCorners) {
						if (c == sx && r == sy) continue;
						if (c == sx && r == fy) continue;
						if (c == fx && r == sy) continue;
						if (c == fx && r == fy) continue;
					}

					var cell:GridCellData = getCellAt(c, r);
					if (!cell) continue;

					result.push(cell);
				}
			}

			return result;
		}

		public function getBombs():Vector.<Vector.<GridCellData>> {
			var bombList:Vector.<GridCellData> = getCellsByFamily(GridCellFamily.BOMB);
			var hash:Dictionary = new Dictionary();
			var currentBombs:Vector.<Vector.<GridCellData>> = new Vector.<Vector.<GridCellData>>();

			for each (var bomb:BombGridCellData in bombList) {
				if (bomb in hash) continue;

				var line:Vector.<GridCellData> = new Vector.<GridCellData>();
				getLine(bomb, line, hash);

				if (line.length >= settings.bombBlowCount) {
					currentBombs.push(line);
				}
			}

			return currentBombs;
		}


		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		[Inline]
		private final function updateColumn(index:int):void {
			var column:Vector.<GridCellData> = getColumn(index);
			var dY:int = 0;
			for (var i:int = rows - 1; i >= 0; i--) {
				if (!column[i]) {
					dY++;
				} else if (dY > 0) {
					var cell:GridCellData = column[i] as GridCellData;
					moveCell(cell, cell.column, cell.row + dY);
				}
			}
		}

		[Inline]
		private final function removeCell(cell:GridCellData):void {
			_cellsMatrix[cell.column][cell.row] = null;

			var typesList:Vector.<GridCellData> = (_typesHash[cell.type] as Vector.<GridCellData>);
			if (typesList) {
				var index:int = typesList.indexOf(cell);
				if (index >= 0) typesList.splice(index, 1);
			}

			var familyList:Vector.<GridCellData> = (_familyHash[cell.family] as Vector.<GridCellData>);
			if (familyList) {
				index = familyList.indexOf(cell);
				if (index >= 0) familyList.splice(index, 1);
			}

			cell.destroyed = true;
			if (cell is BombGridCellData) (cell as BombGridCellData).readyToBlow = false;
		}

		[Inline]
		private final function moveCell(cell:GridCellData, column:int, row:int):void {
			if (_cellsMatrix[column][row]) throw new Error('Can\'t move cell: place is not free');

			_cellsMatrix[cell.column][cell.row] = null;
			cell.column = column;
			cell.row = row;
			_cellsMatrix[column][row] = cell;
		}

		private function getLine(startCell:GridCellData, result:Vector.<GridCellData>, excludes:Dictionary = null, includeCorners:Boolean = false):void {
			excludes ||= new Dictionary();

			if (!(startCell in excludes)) {
				excludes[startCell] = true;
				result.push(startCell);
			}

			var startCellType:int = startCell.type;
			var sx:int = startCell.column - 1;
			var fx:int = startCell.column + 1;
			var sy:int = startCell.row - 1;
			var fy:int = startCell.row + 1;

			for (var c:int = sx; c <= fx; c++) {
				if (c < 0 || c >= columns) continue;
				if (c > columns) continue;

				for (var r:int = sy; r <= fy; r++) {
					if (r < 0 || r >= rows) continue;

					if (!includeCorners) {
						if (c == sx && r == sy) continue;
						if (c == sx && r == fy) continue;
						if (c == fx && r == sy) continue;
						if (c == fx && r == fy) continue;
					}

					var cell:GridCellData = getCellAt(c, r);
					if (!cell) continue;
					if (cell in excludes) continue;
					if (cell.type != startCellType) continue;

					getLine(cell, result, excludes, includeCorners);
				}
			}
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
