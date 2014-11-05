//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {

	import com.greensock.TweenNano;

	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.game.ResourceImage;
	import ru.catAndBall.view.core.text.TextFieldTest;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                14.08.14 22:59
	 */
	public class ObjectsCounter extends Sprite {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ObjectsCounter(resourceSetType:String) {
			super();
			_resourseType = resourceSetType;
			touchable = false;
			init();
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _progress:Number = 0;

		public function get progress():Number {
			return _progress;
		}

		public function set progress(value:Number):void {
			if (value < 0) value = 0;
			if (value > 1) value = 1;
			if (_progress == value) return;

			_progress = value;
			updateProgress();
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _resourseType:String;

		private var _maxHeight:Number;

		private var _progressBar:Scale3Image;

		private var _icon:ResourceCounter;

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function init():void {
			var t:Texture = Assets.getTexture(AssetList.Panel_components_components_level_bg);
			var a:Array = Layout.fieldCounterBgScaleGridSizes;
			var bg:Scale3Image = new Scale3Image(new Scale3Textures(t, a[0], a[1], Scale3Textures.DIRECTION_VERTICAL));
			bg.x = 0;
			bg.y = 0;
			bg.height = Layout.fieldCounterBgHeight;
			addChild(bg);

			const bgWidth:Number = bg.textures.texture.width;
			const bgHeight:Number = bg.textures.texture.height;
			_maxHeight = bgHeight * 0.9;

			t = Assets.getTexture(AssetList.Panel_components_milk2);
			a = Layout.fieldCounterMilkScaleGridSizes;
			_progressBar = new Scale3Image(new Scale3Textures(t, a[0], a[1], Scale3Textures.DIRECTION_VERTICAL));
			_progressBar.pivotY = _progressBar.textures.texture.height;
			_progressBar.x = (bgWidth - _progressBar.textures.texture.width) / 2;
			_progressBar.y = _maxHeight;
			addChild(_progressBar);

			_icon = new ResourceCounter(_resourseType);
			addChild(_icon);

			updateProgress();
		}

		private function updateProgress():void {
			var middleHeight:Number = _maxHeight * _progress;

			TweenNano.to(_progressBar, 0.2, {height: middleHeight});
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
