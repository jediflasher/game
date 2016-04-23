package ru.catAndBall.view.screens.room.header {
	
	import airlib.util.TouchableDecorator;

	import com.greensock.TweenNano;

	import flash.events.Event;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.flaswf.parsers.feathers.view.ParserFeathersMovieClip;
	import ru.flaswf.parsers.feathers.view.ParserFeathersTextField;
	import ru.flaswf.reader.descriptors.DisplayObjectDescriptor;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                05.10.14 18:33
	 */
	public class RoomHeader extends ParserFeathersMovieClip {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static var EXPANDED_POSITION:Number = 0;

		private static var COLLAPSED_POSITION:Number = 0;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function RoomHeader(source:DisplayObjectDescriptor) {
			super(source);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		public var _nameTf:ParserFeathersTextField;

		public var _levelTf:ParserFeathersTextField;

		public var _mouseTf:ParserFeathersTextField;

		public var _moneyTf:ParserFeathersTextField;

		public var _expPanel:RoomHeaderExpPanel;

		private var _expanded:Boolean = false;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();
			autoAssign();

			_levelTf = getTextField('levelContainer.levelTf');
			_nameTf.text = GameData.player.name;

			EXPANDED_POSITION = _expPanel.y;
			COLLAPSED_POSITION = EXPANDED_POSITION - _expPanel.getFrameBounds().height;

			_expPanel.y = COLLAPSED_POSITION;

			var container:ParserFeathersMovieClip = getMovieClip('levelContainer');
			new TouchableDecorator(container).addEventListener(TouchableDecorator.EVENT_CLICK, toggle);
			
			GameData.player.resources.addEventListener(Event.CHANGE, invalidateData);
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_levelTf.text = String(GameData.player.level);
				_moneyTf.text = String(GameData.player.resources.get(ResourceSet.MONEY));
				_mouseTf.text = String(GameData.player.resources.get(ResourceSet.MOUSE));
			}

			super.draw();
		}

		private function expand(event:* = null):void {
			TweenNano.to(_expPanel, 0.3, {y:EXPANDED_POSITION});
			_expanded = true;
		}

		private function collapse(event:* = null):void {
			TweenNano.to(_expPanel, 0.3, {y:COLLAPSED_POSITION});
			_expanded = false;
		}

		private function toggle(event:* = null):void {
			_expanded ? collapse(event) : expand(event);
		}
	}
}
