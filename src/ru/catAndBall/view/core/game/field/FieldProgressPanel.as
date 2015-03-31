//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {

	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;

	import feathers.core.FeathersControl;
	import feathers.display.TiledImage;

	import flash.display3D.textures.Texture;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.text.TextFieldBackground;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 17:22
	 */
	public class FieldProgressPanel extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function FieldProgressPanel() {
			super();

			touchable = false;
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
			if (_progress == value) return;

			_progress = value;
			this.invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
		}

		private var _stepsLeft:int;

		public function get stepsLeft():int {
			return _stepsLeft;
		}

		public function set stepsLeft(value:int):void {
			if (_stepsLeft == value) return;

			_stepsLeft = value;
			this.invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _bg:Image;

		private var _cat:Image;

		private var _ball:TextFieldBackground;

		private var _line:Image;

		private var _border:TiledImage;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_bg = Assets.getImage(AssetList.Strip_moves_stripMovesBalls);
			addChild(_bg);

			_cat = Assets.getImage(AssetList.Strip_moves_cat_animation_cat1);
			_cat.y = Layout.field.progressCatY;
			addChild(_cat);

			_line = Assets.getImage(AssetList.Strip_moves_line_for_strip);
			_line.y = Layout.field.progresslineY;
			addChild(_line);

			var ballBg:Image = Assets.getImage(AssetList.Strip_moves_ball_for_strip);
			_ball = new TextFieldBackground(AssetList.font_small_white, ballBg, true, true);
			_ball.y = Layout.field.progressBallY;
			addChild(_ball);

			_border = new TiledImage(Assets.getTexture(AssetList.fields_balls_ballsBgTop));
			_border.alignPivot(HAlign.LEFT, VAlign.CENTER);
			_border.width = AppProperties.baseWidth;
			addChild(_border);

		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_DATA)) {
				this.update();
			}
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function update():void {
			var start:Number = AppProperties.viewRect.x;
			var totalPath:Number = AppProperties.baseWidth - (start * 2 + _cat.texture.width);

			_ball.text = String(_stepsLeft);

			var catX:int = start + totalPath * _progress;
			var ballX:int = catX + _cat.texture.width + Layout.baseGap / 4;
			var lineX:int = ballX + Layout.baseGap / 2;

			if (_progress > 0) {
				TweenNano.to(_cat, 0.3, {x:catX, delay:0.2, ease:Linear.easeNone});
				TweenNano.to(_ball, 0.3, {x: ballX, ease:Linear.easeNone});
				TweenNano.to(_line, 0.3, {x: lineX, width: AppProperties.baseWidth - lineX, ease:Linear.easeNone});
			} else {
				_cat.x = catX;
				_ball.x = ballX;
				_line.x = lineX;
				_line.width = AppProperties.baseWidth - lineX;
			}

			_border.y = _bg.height;
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
