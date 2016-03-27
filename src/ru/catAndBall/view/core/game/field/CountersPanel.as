package ru.catAndBall.view.core.game.field {
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	
	import ru.catAndBall.data.game.field.GridCellType;
	import ru.catAndBall.data.game.field.GridData;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                15.03.15 15:16
	 */
	public class CountersPanel extends LayoutGroup {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CountersPanel(data:GridData) {
			super();

			this._data = data;

			var l:HorizontalLayout = new HorizontalLayout();
			l.gap = 10;
			super.layout = l;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _hashTypeToCounter:Object = {}; // type (String) -> ObjectsCounter

		private var _data:GridData;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------


		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

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

			_data.addEventListener(GridData.EVENT_UPDATE_FIELD, updateCounters);
			_data.addEventListener(GridData.EVENT_FILL_FIELD, updateCounters);
			updateCounters();

		}

		protected override function draw():void {
			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

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
