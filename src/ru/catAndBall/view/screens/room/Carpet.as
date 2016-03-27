package ru.catAndBall.view.screens.room {
	
	import feathers.controls.Button;
	
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.11.14 17:52
	 */
	public class Carpet extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Carpet() {
			super();

			var img:Image = Assets.getImage(AssetList.Room_carpet1);
			addChild(img);

			_enterButton = Assets.getButton(AssetList.Room_entrCarpet);
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
