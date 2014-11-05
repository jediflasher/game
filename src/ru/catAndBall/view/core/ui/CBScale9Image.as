package ru.catAndBall.view.core.ui {

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class CBScale9Image extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CBScale9Image(texture:Texture, centerRect:Rectangle) {
			_tW = texture.width;
			_tH = texture.height;
			_grid = centerRect;

			_width = _tW;
			_height = _tH;

			_tl = new Image(Texture.fromTexture(texture, new Rectangle(0, 0, _grid.x, _grid.y)));
			_tc = new Image(Texture.fromTexture(texture, new Rectangle(_grid.x, 0, _grid.width, _grid.y)));
			_tr = new Image(Texture.fromTexture(texture, new Rectangle(_grid.x + _grid.width, 0, texture.width - (_grid.x + _grid.width), _grid.y)));
			_cl = new Image(Texture.fromTexture(texture, new Rectangle(0, _grid.y, _grid.x, _grid.height)));
			_cc = new Image(Texture.fromTexture(texture, new Rectangle(_grid.x, _grid.y, _grid.width, _grid.height)));
			_cr = new Image(Texture.fromTexture(texture, new Rectangle(_grid.x + _grid.width, _grid.y, texture.width - (_grid.x + _grid.width), _grid.height)));
			_bl = new Image(Texture.fromTexture(texture, new Rectangle(0, _grid.y + _grid.height, _grid.x, texture.height - (_grid.y + _grid.height))));
			_bc = new Image(Texture.fromTexture(texture, new Rectangle(_grid.x, _grid.y + _grid.height, _grid.width, texture.height - (_grid.y + _grid.height))));
			_br = new Image(Texture.fromTexture(texture, new Rectangle(_grid.x + _grid.width, _grid.y + _grid.height, texture.width - (_grid.x + _grid.width), texture.height - (_grid.y + _grid.height))));

			_tc.x = _cc.x = _bc.x = _grid.x;
			_cl.y = _cc.y = _cr.y = _grid.y;

			addChild(_tl);
			addChild(_tc);
			addChild(_tr);

			addChild(_cl);
			addChild(_cc);
			addChild(_cr);

			addChild(_bl);
			addChild(_bc);
			addChild(_br);

			apply9Scale(_tW, _tH);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _scaleIfSmaller:Boolean = false;

		public function get scaleIfSmaller():Boolean {
			return _scaleIfSmaller;
		}

		public function set scaleIfSmaller(value:Boolean):void {
			if (_scaleIfSmaller == value) return;

			_scaleIfSmaller = value;
		}

		private var _height:Number;

		public override function get height():Number {
			return _height;
		}

		public override function set height(value:Number):void {
			if (_height == value) return;

			_height = value;
			apply9Scale(_width, _height);
		}

		private var _width:Number;

		public override function get width():Number {
			return _width;
		}

		public override function set width(value:Number):void {
			if (_width == value) return;

			_width = value;
			apply9Scale(_width, _height);
		}


		public function setSize(width:Number, height:Number):void {
			if (_width == width && _height == height) return;

			_width = width;
			_height = height;
			apply9Scale(_width, _height);
		}
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _tl:Image;

		private var _tc:Image;

		private var _tr:Image;

		private var _cl:Image;

		private var _cc:Image;

		private var _cr:Image;

		private var _bl:Image;

		private var _bc:Image;

		private var _br:Image;

		private var _grid:Rectangle;

		private var _tW:Number;

		private var _tH:Number;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function apply9Scale(x:Number, y:Number):void {
			var width:Number = x / scaleX;
			var height:Number = y / scaleY;

			if (width < _tW - _grid.width) {
				_tc.visible = false;
				_bc.visible = false;

				if (!_scaleIfSmaller) {
					var lw:Number = _grid.x;

					_tl.width = _cl.width = _bl.width = lw;
					_tr.x = _cr.x = _br.x = lw;

					var rw:Number = (_tW - _grid.x - _grid.width);
					_tr.width = _cr.width = _br.width = rw;
				}
				else {
					var pct:Number = width / (_tW - _grid.width);
					lw = _grid.x * pct;
					_tl.width = _cl.width = _bl.width = lw;

					rw = (_tW - _grid.x - _grid.width) * pct;
					_tr.width = _cr.width = _br.width = rw;

					var rx:Number = width - rw;
					_tr.x = _cr.x = _br.x = rx;
				}
			}
			else {
				_tc.visible = true;
				_bc.visible = true;

				lw = _grid.x;
				_tl.width = _cl.width = _bl.width = lw;

				rw = (_tW - _grid.x - _grid.width);
				_tr.width = _cr.width = _br.width = rw;

				rx = width - rw;
				_tr.x = _cr.x = _br.x = rx;

				var cw:Number = rx - _grid.x;
				_tc.width = _cc.width = _bc.width = cw;
			}

			if (height < _tH - _grid.height) {
				_cl.visible = false;
				_cr.visible = false;

				if (!_scaleIfSmaller) {
					var tw:Number = _grid.y;

					_tl.height = _tc.height = _tr.height = tw;

					_br.y = _bc.y = _bl.y = tw;

					var bh:Number = (_tH - _grid.y - _grid.height);
					_br.height = _bc.height = _bl.height = bh;
				}
				else {
					pct = height / (_tH - _grid.height);

					tw = _grid.y * pct;
					_tl.height = _tc.height = _tr.height = tw;

					bh = (_tH - _grid.y - _grid.height) * pct;
					_br.height = _bc.height = _bl.height = bh;

					var bx:Number = height - bh;
					_br.y = _bc.y = _bl.y = bx;

				}
			}
			else {
				_cl.visible = true;
				_cr.visible = true;

				_tl.height = _tc.height = _tr.height = _grid.y;

				bh = (_tH - _grid.y - _grid.height);
				_bl.height = _bc.height = _br.height = bh;

				var by:Number = height - bh;
				_bl.y = _bc.y = _br.y = by;

				var ch:Number = by - _grid.y;
				_cl.height = _cc.height = _cr.height = ch;
			}

			_cc.visible = _cl.visible && _tc.visible;
		}
	}
}
