package ru.catAndBall.view.screens.room.header {
	
	import feathers.core.FeathersControl;

	import flash.events.Event;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.flaswf.parsers.feathers.view.ParserFeathersMovieClip;
	import ru.flaswf.parsers.feathers.view.ParserFeathersProgressBar;
	import ru.flaswf.reader.descriptors.DisplayObjectDescriptor;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                09.04.2016 18:31
	 */
	public class RoomHeaderExpPanel extends ParserFeathersMovieClip {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function RoomHeaderExpPanel(source:DisplayObjectDescriptor) {
			super(source);
		}

		public var _bar:ParserFeathersProgressBar;

		protected override function initializeInternal():void {
			super.initializeInternal();
			autoAssign();

			_bar.format = '%v/%V';
			
			GameData.player.resources.addEventListener(Event.CHANGE, invalidateData);
		}

		protected override function draw():void {
			super.draw();
			
			if (isInvalid(FeathersControl.INVALIDATION_FLAG_DATA)) {
				_bar.value = GameData.player.resources.get(ResourceSet.EXPERIENCE);
			}
		}
	}
}
