//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {

	import com.greensock.TweenLite;

	import feathers.controls.ScreenNavigator;

	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.controller.IGridGenerator;
	import ru.catAndBall.data.game.GridCellDataFactory;
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.field.BombGridCellData;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.field.PestGridCellData;
	import ru.catAndBall.view.core.game.GridCell;
	import ru.catAndBall.view.core.game.GridField;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	import ru.catAndBall.view.core.utils.BooleanRandom;
	import ru.catAndBall.view.screens.ScreenType;

	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 18:26
	 */
	public class BaseScreenFieldController extends BaseScreenController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseScreenFieldController(navigator:ScreenNavigator, settings:GridFieldSettings, screen:BaseScreenField, generator:IGridGenerator) {
			super(navigator, screen);
			_settings = settings;
			_view = screen;
			_generator = generator;
			_petRandom = new BooleanRandom(_settings.pestChance);

			for (var pest:String in _settings.pestsFoodHash) {
				var foods:Vector.<int> = _settings.pestsFoodHash[pest];

				for each (var foodType:int in foods) {
					_foodToPestHash[foodType] ||= new Vector.<int>();
					_foodToPestHash[foodType].push(int(pest));
				}
			}
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		protected var _fieldData:GridData;

		protected var _view:BaseScreenField;

		protected var _generator:IGridGenerator;

		protected var _settings:GridFieldSettings;

		protected var _prevBombs:Vector.<Vector.<GridCellData>>;

		private var _foodToPestHash:Object = {}; // int cellType -> Vector.<int> pestTypes

		private var _pestGenerationEnabledHash:Object = {}; // int monster -> true

		private var _pests:Dictionary = new Dictionary(true);

		private var _petRandom:BooleanRandom;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected override function added():void {
			super.added();

			_fieldData = createGrid();
			_fieldData.fullFill(_generator);
			_view.fieldData = _fieldData;

			view.addEventListener(GridField.EVENT_COLLECT_CELLS, handler_collectCells);
		}

		protected override function removed():void {
			if (_fieldData) _fieldData.clear();
			_fieldData = null;
			_pestGenerationEnabledHash = {};
			_pests = new Dictionary(true);
			_petRandom.reset();
			_prevBombs = null;
			view.removeEventListener(GridField.EVENT_COLLECT_CELLS, handler_collectCells);

			super.removed();
		}

		protected function collectSells(cells:Vector.<GridCellData>):void {
			var newCells:Vector.<GridCellData> = _generator.getGridCells(cells);
			var newCellsLen:int = newCells.length;

			for (var i:int = 0; i < newCellsLen; i++) {
				var cell:GridCellData = newCells[i];
				var pests:Vector.<int> = _foodToPestHash[cell.type];
				if (pests) {
					for each (var pestType:int in pests) {
						_pestGenerationEnabledHash[pestType] = true;
					}
				}
			}

			// генерируем монстра каждого типа
			for (var pt:String in _pestGenerationEnabledHash) {
				pestType = int(pt);
				var generatePet:Boolean = _petRandom.rand();
				if (generatePet) {
					var index:int = Math.round(Math.random() * (newCellsLen - 1));
					var prevCell:GridCellData = newCells[index];
					var pest:PestGridCellData = GridCellDataFactory.getCell(pestType, prevCell.column, prevCell.row, _settings) as PestGridCellData;
					pest.turnsLeft = _settings.pestTurnCount + 1; // потому что один ход сразу вычтется
					newCells[index] = pest;
					_pests[pest] = true;
				}
			}

			_fieldData.collectCells(cells, newCells);
			_fieldData.currentTurn++;

			if (_fieldData.currentTurn == _fieldData.maxTurns) {
				fieldComplete();
			} else {
				TweenLite.delayedCall(0.3, jumpPests);
				TweenLite.delayedCall(1, checkBombs);
			}
		}

		protected function createGrid():GridData {
			return new GridData(_settings);
		}

		protected function fieldComplete():void {
			navigator.showScreen(ScreenType.ROOM);
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function jumpPests():void {
			for (var p:* in _pests) {
				var pest:PestGridCellData = p as PestGridCellData;
				if (pest.destroyed) delete _pests[pest];
				if (pest.turnsLeft > 0) {
					pest.turnsLeft--;
				}

				if (pest.turnsLeft > 0) continue;

				var foods:Vector.<int> = _settings.pestsFoodHash[pest.type];
				var foodList:Vector.<GridCellData> = new Vector.<GridCellData>();
				var len:int = foods.length;

				for (var i:int = 0; i < len; i++) {
					var foodType:int = foods[i];
					var foodTypeList:Vector.<GridCellData> = _fieldData.getCellsByType(foodType);
					if (foodTypeList) foodList = foodList.concat(foodTypeList);
				}

				if (foodList.length) {
					var rndElement:GridCellData = foodList[Math.round(Math.random() * (foodList.length - 1))];

					var resultType:int = _settings.pestsResultHash[pest.type];
					if (!resultType) continue;

					var pestResultCell:GridCellData = GridCellDataFactory.getCell(resultType, pest.column, pest.row, _settings);
					replaceCell(pestResultCell);

					var newPest:PestGridCellData = GridCellDataFactory.getCell(pest.type, rndElement.column, rndElement.row, _settings) as PestGridCellData;
					newPest.prevColumn = pest.column;
					newPest.prevRow = pest.row;
					newPest.turnsLeft = _settings.pestTurnCount;
					delete _pests[pest];
					_pests[newPest] = true;
					replaceCell(newPest);
				} else {
					pest.turnsLeft = _settings.pestTurnCount;
				}
			}
		}

		private function checkBombs():void {
			var t:Number = getTimer();

			var bombs:Vector.<Vector.<GridCellData>> = _fieldData.getBombs();

			// blow bombs if they're ready
			var len:int = bombs.length;

			if (!len) {
				_prevBombs = bombs;
				return;
			}

			for (var i:int = 0; i < len; i++) {
				var line:Vector.<GridCellData> = bombs[i];

				var len2:int = line.length;
				for (var j:int = 0; j < len2; j++) {
					var bomb:BombGridCellData = line[j] as BombGridCellData;
					if (bomb.destroyed) continue;

					if (bomb.readyToBlow) {
						blowBombs(line);
						break;
					}
				}
			}

			var bombView:GridCell;

			// set previous bombs to not ready to blow
			if (_prevBombs) {
				len = _prevBombs.length;
				for (i = 0; i < len; i++) {
					line = _prevBombs[i];
					len2 = line.length;
					for (j = 0; j < len2; j++) {
						if (bomb.destroyed) continue;

						bomb = line[j] as BombGridCellData;
						bomb.readyToBlow = false;
						bombView = _view.fieldView.getCellByData(bomb);
						if (bombView) bombView.updateExplode();
					}
				}
			}

			// set current bombs ready to blow
			len = bombs.length;
			for (i = 0; i < len; i++) {
				line = bombs[i];
				len2 = line.length;
				for (j = 0; j < len2; j++) {
					bomb = line[j] as BombGridCellData;
					if (bomb.destroyed) continue;

					bomb.readyToBlow = true;
					bombView = _view.fieldView.getCellByData(bomb);
					if (bombView) bombView.updateExplode();
				}
			}

			_prevBombs = bombs;
		}

		private function blowBombs(bombs:Vector.<GridCellData>):void {
			for each (var bomb:GridCellData in bombs) {
				blowCell(bomb, _settings.bombsResultHash[bomb.type]);
			}
		}

		private function blowCell(cell:GridCellData, resultType:int, hash:Dictionary = null):void {
			hash ||= new Dictionary();
			if (cell in hash) return;

			hash[cell] = true;

			var field:GridField = _view.fieldView;
			var cellView:GridCell = field.getCellByData(cell);

			if (cellView) {
				var newCellData:GridCellData = GridCellDataFactory.getCell(resultType, cell.column, cell.row, _settings);
				replaceCell(newCellData)
			}

			if (cell is BombGridCellData) {
				var cellsAround:Vector.<GridCellData> = _fieldData.getCellsAround(cell.column, cell.row, true);

				for each (var cellAround:GridCellData in cellsAround) {
					blowCell(cellAround, resultType, hash);
				}
			}
		}

		private function replaceCell(newCellData:GridCellData):void {
			var old:GridCellData = _fieldData.getCellAt(newCellData.column, newCellData.row);
			if (!old) throw new IllegalOperationError('old cell not found');

			_fieldData.replaceCell(newCellData);

			var cellView:GridCell = _view.fieldView.getCellByData(old);
			if (cellView) {
				_view.fieldView.setNewData(cellView, newCellData);
			}
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------

		private function handler_collectCells(event:Event):void {
			var cells:Vector.<GridCellData> = event.data as Vector.<GridCellData>;
			if (!cells) return;

			collectSells(cells);
		}
	}
}
