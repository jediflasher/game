package ru.catAndBall.view.core.ui {
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                03.11.14 18:15
	 */
	public class LoaderBar extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function LoaderBar(width:Number) {
			super();
			_width = width;
			update();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:Scale3Image;

		private var _bar:Scale3Image;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _width:Number = 100;

		public override function get width():Number {
			return _width;
		}

		public override function set width(value:Number):void {
			if (_width == value) return;

			_width = value;
			update();
		}

		private var _progress:Number = 0;

		public function get progress():Number {
			return _progress;
		}

		public function set progress(value:Number):void {
			if (_progress == value) return;

			_progress = value;
			update();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function update():void {
			/*
			if (!_bg) {
				var texture:Texture = Assets.getTexture(AssetList.Preloader_band_experience_stroke);
				_bg = new Scale3Image(new Scale3Textures(texture,
						Layout.preloaderLayout.progressBarRegions[0],
						Layout.preloaderLayout.progressBarRegions[1]));
				addChild(_bg);
				_bg.width = _width;
			}

			if (!_bar) {
				texture = Assets.getTexture(AssetList.Preloader_band_experience_green);
				_bar = new Scale3Image(new Scale3Textures(texture,
						Layout.preloaderLayout.progressBarRegions[0],
						Layout.preloaderLayout.progressBarRegions[1]));
				addChild(_bar);
			}

			_bar.width = _width * _progress;
			*/
		}
	}
}
