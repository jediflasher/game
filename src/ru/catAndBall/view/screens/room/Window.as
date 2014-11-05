package ru.catAndBall.view.screens.room {
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.11.14 17:46
	 */
	public class Window extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Window() {
			super();

			var img:Image = Assets.getImage(AssetList.Room_window);
			addChild(img);

			_enterButton = Assets.getButton(AssetList.Room_vhod_pole_okno);
			_enterButton.addEventListener(Event.TRIGGERED, handler_triggered);
			_enterButton.x = img.texture.width / 2 - _enterButton.upState.width / 2;
			_enterButton.y = img.texture.height / 2 - _enterButton.upState.height / 2;
			addChild(_enterButton);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _enterButton:Button;

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_triggered(event:Event):void {
			dispatchEventWith(event.type);
		}
	}
}
