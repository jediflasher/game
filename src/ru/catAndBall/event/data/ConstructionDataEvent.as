package ru.catAndBall.event.data {

	import flash.events.Event;
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                06.04.2016 20:13
	 */
	public class ConstructionDataEvent extends DataEvent {
		
		
		public static const BUILDING_START:String = 'buildingStart';
		
		public static const BUILDING_COMPLETE:String = 'buildingComplete';
		
		public static const BONUS_READY:String = 'bonusTimeComplete';
		
		public static const BONUS_COLLECTED:String = 'bonusCollected';
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ConstructionDataEvent(type:String, data:Object = null) {
			super(type, data);
		}

		public override function clone():Event {
			return new ConstructionDataEvent(type, data);
		}
	}
}
