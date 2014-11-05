package ru.catAndBall.data.game {
	import ru.catAndBall.controller.IGridGenerator;

	public class GridFieldSettings {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function GridFieldSettings() {

		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var fieldWidth:Number = 7;

		public var fieldHeight:Number = 7;

		public var generator:IGridGenerator;

		// максимальное количество ходов на поле
		public var turnCount:Number = 30;

		// шанс выпадения вместо сгенерированного элемента вредителя
		public var pestChance:Number = 0.01;

		public var pestTurnCount:int = 3;

		// минимальное количество соедененных айтемов для выпадения айтема следующего уровня
		public var baseUpgradeLimit:int = 7;

		// минимальное количество айтемов для сбора 1 соответствущего ресурса
		public var baseStackSize:int = 7;

		// минимальное количество айтемов для соединения
		public var baseConnectCount:int = 3;

		// количество бомб, находящихся вместе, требуемое для взрыва
		public var bombBlowCount:int = 3;

		// список типов, которые выпадают на поле
		public var elements:Vector.<int> = new Vector.<int>();

		// список шансов выпадения, порядок соответствует списку типов
		public var elementChances:Vector.<Number> = new Vector.<Number>();

		// вредители,которые будут генерироваться на этом поле
		public var pests:Vector.<int> = new Vector.<int>();

		// хэш айтемы, которые монстр ест
		public var pestsFoodHash:Object = {}; // int pestType -> Vector.<int> foodTypes

		public var pestsResultHash:Object = {}; // int pestType -> int cellType

		// хэш соответствий собираемого элемента и выпадаемого элемента следующего уровня
		public var upgradeHash:Object = {};

		// хэш минимальное количество соедененных айтемов для выпадения айтема следующего уровня
		public var customUpgradeLimits:Object = {};

		// хэш минимальное количество айтемов для соединения
		public var connectCounts:Object = {};

		public var bombsResultHash:Object = {};
	}
}
