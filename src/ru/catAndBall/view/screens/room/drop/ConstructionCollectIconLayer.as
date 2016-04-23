package ru.catAndBall.view.screens.room.drop {
	
	import airlib.util.log.error;
	
	import feathers.core.FeathersControl;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import ru.catAndBall.data.GameData;

	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.game.player.ConstructionCollectionData;
	import ru.catAndBall.event.data.ConstructionDataEvent;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.screens.room.ScreenRoom;

	import starling.events.TouchEvent;
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                10.04.2016 14:21
	 */
	public class ConstructionCollectIconLayer extends FeathersControl {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ConstructionCollectIconLayer(room:ScreenRoom) {
			super();
			_room = room;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _room:ScreenRoom;

		private var _dataToIcon:Dictionary = new Dictionary();

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			var collection:ConstructionCollectionData = GameData.player.constructions;
			var list:Vector.<ConstructionData> = collection.list;
			for each (var c:ConstructionData in list) {
				c.addEventListener(ConstructionDataEvent.BONUS_READY, handler_bonusReady);
				c.addEventListener(ConstructionDataEvent.BONUS_COLLECTED, handler_bonusCollected);
				if (c.canCollectBonus) show(c);
			}

			addEventListener(TouchEvent.TOUCH, handler_iconTouch);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function show(data:ConstructionData):void {
			var view:Construction = _room.getConstruction(data.id);
			if (!view) {
				error(this, 'Construction view for {0} not found', [data.id]);
				return;
			}
			
			var frameBounds:Rectangle = view.getFrameBounds();
			var icon:ConstructionCollectIcon = new ConstructionCollectIcon();
			icon.x = view.x + frameBounds.width / 2;
			icon.y = view.y + frameBounds.height / 2;
			addChild(icon);

			_dataToIcon[data] = icon;

			touchable = true;
		}

		private function hide(data:ConstructionData):void {
			var icon:ConstructionCollectIcon = _dataToIcon[data];
			removeChild(icon);

			delete _dataToIcon[data];

			if (!numChildren) touchable = false;
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_bonusReady(event:ConstructionDataEvent):void {
			show(event.target as ConstructionData);
		}

		private function handler_bonusCollected(event:ConstructionDataEvent):void {
			hide(event.target as ConstructionData);
		}

		private function handler_iconTouch(event:TouchEvent):void {
			
		}
	}
}
