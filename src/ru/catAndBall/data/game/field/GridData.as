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

		public static const EVENT_FILL_FIELD:String = 'eventFillField';

		public static const EVENT_UPDATE_FIELD:String = 'eventGridUpdate';

		public static const EVENT_TURN_UPDATE:String = 'eventTurnUpdate';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridData(settings:GridFieldSettings) {
			super();

			this.settings = settings;

			columns = settings.fieldHeight;
			rows = settings.fieldWidth;

			cellsMatrix = new Vector.<Vector.<GridCellData>>(columns, true);

			for (var i:int = 0; i < columns; i++) {
				cellsMatrix[i] = new Vector.<GridCellData>(rows, true);
			}

			trace(1);
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public var settings:GridFieldSettings;

		public var columns:int;

		public var rows:int;

		public const collectedResourceSet:ResourceSet = new ResourceSet();

		public function getCollectCount(type:String):int {
			if (type in settings.customConnectCounts) return int(settings.customConnectCounts[type]);
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

		public function get maxTurns():int {
			return settings.turnCount;
		}

		public function set maxTurns(value:int):void {
			if (settings.turnCount == value) return;

			settings.turnCount = value;
			dispatchEvent(new DataEvent(EVENT_TURN_UPDATE));
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		public var cellsMatrix:Vector.<Vector.<GridCellData>>;

		private var _typesHash:Object = {};

		private var _familyHash:Object = {};

		private var _collectedResourceElements:Object = {}; // ResourceType -> count

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

			var stackSize:int = settings.baseStackSize;

			for each(var cell:GridCellData in cells) {
				if (cell is ResourceGridCellData) {
					var resourceType:String = (cell as ResourceGridCellData).resourceType;
					var newCount:int = (_collectedResourceElements[resourceType] || 0);
					_collectedResourceElements[resourceType] = ++ newCount;

					var oldValue:int = collectedResourceSet.get(resourceType);
					var newValue:int = int(newCount / stackSize);
					if (newValue > oldValue) collectedResourceSet.addType(resourceType, newValue - oldValue);
				}

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
			return _collectedResourceElements[resourceType];
		}

		public function fullFill(generator:IGridGenerator):void {
			collectedResourceSet.clear();

			for (var i:int = 0; i < columns; i++) {
				for (var j:int = 0; j < rows; j++) {
					if (!cellsMatrix[i][j]) {
						var cell:GridCellData = generator.getStartGridCell(i, j);
						addCell(cell);
					}
				}
			}

			if (hasEventListener(EVENT_FILL_FIELD)) dispatchEvent(new DataEvent(EVENT_FILL_FIELD));
		}

		[Inline]
		public final function getCellsByType(cellType:String):Vector.<GridCellData> {
			return _typesHash[cellType] as Vector.<GridCellData>;
		}

		public final function getCellsByFamily(gridCellFamily:int):Vector.<GridCellData> {
			return _familyHash[gridCellFamily];
		}

		[Inline]
		public final function getColumn(index:int):Vector.<GridCellData> {
			if (index < 0) return null;
			if (index > columns - 1) return null;
			return cellsMatrix[index] as Vector.<GridCellData>;
		}

		[Inline]
		public final function clear():void {
			for (var i:int = 0; i < columns; i++) {
				for (var j:int = 0; j < rows; j++) {
					cellsMatrix[i][j] = null;
				}
			}

			_typesHash = {};
			_familyHash = {};
			_collectedResourceElements = {};
			currentTurn = 0;
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
			cellsMatrix[cell.column][cell.row] = null;

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
			if (cellsMatrix[column][row]) throw new Error('Can\'t move cell: place is not free');

			cellsMatrix[cell.column][cell.row] = null;
			cell.column = column;
			cell.row = row;
			cellsMatrix[column][row] = cell;
		}

		private function getLine(startCell:GridCellData, result:Vector.<GridCellData>, excludes:Dictionary = null, includeCorners:Boolean = false):void {
			excludes ||= new Dictionary();

			if (!(startCell in excludes)) {
				excludes[startCell] = true;
				result.push(startCell);
			}

			var startCellType:String = startCell.type;
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
