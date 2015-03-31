package ru.catAndBall.view.screens.room {
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

	import feathers.controls.Button;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.11.14 19:56
	 */
	public class Tangles extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Tangles() {
			super();

			var img:Image = Assets.getImage(AssetList.Room_tangles1);
			addChild(img);

			_enterButton = Assets.getButton(AssetList.Room_entrTangles);
			_enterButton.addEventListener(Event.TRIGGERED, handler_triggered);
			_enterButton.x = img.texture.width / 2 - _enterButton.defaultSkin.width / 2;
			_enterButton.y = img.texture.height / 2 - _enterButton.defaultSkin.height / 2;
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
