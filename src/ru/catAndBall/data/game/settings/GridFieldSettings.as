package ru.catAndBall.data.game.settings {
	
	import ru.catAndBall.controller.IGridGenerator;
	import ru.catAndBall.data.game.*;
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
		public var elements:ElementsSettingsCollection = new ElementsSettingsCollection(); // element -> probability

		// список типов,и з которых генерируется стартовое поле
		public var startElements:ElementsSettingsCollection = new ElementsSettingsCollection(); // element -> probability

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
		public var customConnectCounts:Object = {};

		// элементы, на сбор которых не требуется траты ходов
		public var freeToCollect:Vector.<String>;

		public var bombsResultHash:Object = {}; // bomb name -> ElementSettingsCollection

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
			if ('elements' in input) elements.parse(input.elements);
			if ('startElements' in input) startElements.parse(input.startElements);
			if ('pests' in input) {
				for (var pestIdent:String in input.pests) {
					if (!input.pests.hasOwnProperty(pestIdent)) continue;

					pests.push(pestIdent);
					var p:Object = input.pests[pestIdent];
					pestsFoodHash[pestIdent] = ArrayUtils.toVector(p.food, new Vector.<String>)
					pestsResultHash[pestIdent] = p.result;
				}
			}

			if ('upgrades' in input) upgradeHash = input.upgrades;
			if ('customUpgradesLimit' in input) customUpgradeLimits = input.customUpgradeLimits;
			if ('customConnectCounts' in input) customConnectCounts = input.customConnectCounts;
			if ('bombsResultHash' in input) {
				for (var bombName:String in input.bombsResultHash) {
					var s:ElementsSettingsCollection = new ElementsSettingsCollection();
					s.parse(input.bombsResultHash[bombName]);
					bombsResultHash[bombName] = s;
				}
			}
		}
	}
}
