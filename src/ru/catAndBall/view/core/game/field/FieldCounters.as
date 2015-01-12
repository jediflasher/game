package ru.catAndBall.view.core.game.field {
	import feathers.core.FeathersControl;

	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.field.GridCellType;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.field.ObjectsCounter;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.11.14 19:10
	 */
	public class FieldCounters extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function FieldCounters(data:GridData) {
			super();

			_data = data;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _hashTypeToCounter:Object = {}; // type (String) -> ObjectsCounter

		private var _bg:Image;

		private var _data:GridData;

		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_bg = Assets.getImage(AssetList.Panel_components_bg_for_components);
			addChild(_bg);

			var count:int = 0;

			for (var key:String in _data.settings.upgradeHash) {
				var resourceType:String = GridCellType.getResourceType(key);
				if (resourceType in _hashTypeToCounter) continue;
				var counter:ObjectsCounter = addCounter(resourceType);
				count++;
			}

			for each (var cellType:String in _data.settings.pestsResultHash) {
				resourceType = GridCellType.getResourceType(cellType);
				if (resourceType in _hashTypeToCounter) continue;
				counter = addCounter(resourceType);
				count++;
			}

			var step:Number = counter.width + Layout.field.counterRightPadding;
			var width:int = (count * step) - Layout.field.counterRightPadding;
			var startX:int = (AppProperties.appWidth - width) / 2;

			for each (counter in _hashTypeToCounter) {
				counter.x = startX;
				startX += step;
			}

			_data.addEventListener(GridData.EVENT_UPDATE_FIELD, updateCounters);
			_data.addEventListener(GridData.EVENT_FILL_FIELD, updateCounters);
			updateCounters();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function addCounter(resourceType:String):ObjectsCounter {
			var counter:ObjectsCounter = new ObjectsCounter(
					resourceType,
					_data.collectedResourceSet,
					_data.settings.baseStackSize
			);

			addChild(counter);
			counter.y = Layout.field.countersTopPadding;
			_hashTypeToCounter[resourceType] = counter;
			return counter;
		}

		private function updateCounters(event:* = null):void {
			for (var resourceType:String in _hashTypeToCounter) {
				var counter:ObjectsCounter = _hashTypeToCounter[resourceType] as ObjectsCounter;
				counter.stack = _data.getCollectedResource(resourceType);
			}
		}
	}
}
