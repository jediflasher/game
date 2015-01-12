package ru.catAndBall.data.game {
	import ru.catAndBall.controller.IGridGenerator;
	import ru.catAndBall.view.core.utils.ArrayUtils;

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
		public var turnCount:Number = 15;

		public var price:ResourceSet;

		// шанс выпадения вместо сгенерированного элемента вредителя
		public var pestChance:Number = 0.01;

		public var pestTurnCount:int = 3;

		// минимальное количество соедененных айтемов для выпадения айтема следующего уровня
		public var baseUpgradeLimit:int = 7;

		// минимальное количество айтемов для сбора 1 соответствущего ресурса
		public var baseStackSize:int = 8;

		// минимальное количество айтемов для соединения
		public var baseConnectCount:int = 3;

		// количество бомб, находящихся вместе, требуемое для взрыва
		public var bombBlowCount:int = 3;

		// список типов, которые выпадают на поле
		public var elements:Vector.<String> = new Vector.<String>();

		// список шансов выпадения, порядок соответствует списку типов
		public var elementChances:Vector.<Number> = new Vector.<Number>();

		// вредители,которые будут генерироваться на этом поле
		public var pests:Vector.<String> = new Vector.<String>();

		// хэш айтемы, которые монстр ест
		public var pestsFoodHash:Object = {}; // string pestType -> Vector.<String> foodTypes

		public var pestsResultHash:Object = {}; // string pestType -> string cellType

		// хэш соответствий собираемого элемента и выпадаемого элемента следующего уровня
		public var upgradeHash:Object = {};

		// хэш минимальное количество соедененных айтемов для выпадения айтема следующего уровня
		public var customUpgradeLimits:Object = {};

		// хэш минимальное количество айтемов для соединения
		public var connectCounts:Object = {};

		public var bombsResultHash:Object = {};

		public function deserialize(input:Object):void {
			if ('price' in input) {
				price = new ResourceSet();
				price.deserialize(input.price);
			}

			if ('turnsCount' in input) turnCount = input.turnsCount;
			if ('pestChance' in input) pestChance = input.pestChance;
			if ('pestTurnCount' in input) pestTurnCount = input.pestTurnCount;
			if ('upgradeLimit' in input) baseUpgradeLimit = input.upgradeLimit;
			if ('stackSize' in input) baseStackSize = input.stackSize;
			if ('connectCount' in input) baseConnectCount = input.connectCount;
			if ('blowBombCount' in input) bombBlowCount = input.blowBombCount;
			if ('elements' in input) {
				ArrayUtils.toVector(input.elements, elements);
			}
			if ('elementChances' in input) {
				ArrayUtils.toVector(input.elementChances, elementChances);
			}
			if ('pests' in input) {
				ArrayUtils.toVector(input.pests, pests);
			}
			if ('pestsFood' in input) {
				for (var pest:String in input.pestsFood) {
					var food:Array = input.pestsFood[pest];
					pestsFoodHash[pest] = ArrayUtils.toVector(food, new Vector.<String>);
				}
			}
			if ('pestsResult' in input) pestsResultHash = input.pestsResult;
			if ('upgrades' in input) upgradeHash = input.upgrades;
			if ('customUpgradesLimit' in input) customUpgradeLimits = input.customUpgradeLimits;
			if ('customConnectCounts' in input) connectCounts = input.customConnectCounts;
			if ('bombsResultHash' in input) bombsResultHash = input.bombsResultHash;
		}
	}
}
