package ru.catAndBall.view.core.ui {
	
	import feathers.controls.Button;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.layout.Layout;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                08.11.14 16:51
	 */
	public class SuperPopup extends BasePopup {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function SuperPopup() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _button:Button;

		private var _descTextField:TextFieldTextRenderer;

		private var _titleTextField:TextFieldTextRenderer;

		private var _resContainer:GridLayoutContainer;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _title:String;

		public function get title():String {
			return _title;
		}

		public function set title(value:String):void {
			if (_title == value) return;

			_title = value;
			invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		private var _desc:String;

		public function get desc():String {
			return _desc;
		}

		public function set desc(value:String):void {
			if (_desc == value) return;

			_desc = value;
			invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		private var _resourceSet:ResourceSet;

		public function get resourceSet():ResourceSet {
			return _resourceSet;
		}

		public function set resourceSet(value:ResourceSet):void {
			if (_resourceSet == value) return;

			if (_resourceSet) _resourceSet.removeEventListener(Event.CHANGE, this.handler_resourceChange);
			_resourceSet = value;
			if (_resourceSet) _resourceSet.addEventListener(Event.CHANGE, this.handler_resourceChange);
			invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		private var _buttonLabel:String;

		public function get buttonLabel():String {
			return _buttonLabel;
		}

		public function set buttonLabel(value:String):void {
			if (_buttonLabel == value) return;

			_buttonLabel = value;
			invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		public var resourceCounterFactory:Function = function (resourceType:String, resourceSet:ResourceSet = null, size:int = 0):ResourceCounter {
			return new ResourceCounter(resourceType, resourceSet, size);
		};

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			if (_resContainer) _resContainer.flatten();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		protected override function getContent():Vector.<DisplayObject> {
			var content:Vector.<DisplayObject> = new Vector.<DisplayObject>();

			if (_title) {
				if (!_titleTextField) {
					_titleTextField = new BaseTextField(0, 30);
					_titleTextField.wordWrap = true;
				}

				_titleTextField.text = _title;
				content.push(_titleTextField);
			} else {
				if (_titleTextField && _titleTextField.parent) {
					_titleTextField.parent.removeChild(_titleTextField);
				}
			}

			if (_desc) {
				if (!_descTextField) {
					_descTextField = new BaseTextField(0, 30);
					_descTextField.wordWrap = true;
				}

				_descTextField.text = _desc;
				content.push(_descTextField);
			} else {
				if (_descTextField && _descTextField.parent) {
					_descTextField.parent.removeChild(_descTextField);
				}
			}

			if (_resourceSet) {
				if (!_resContainer) {
					_resContainer = new GridLayoutContainer(4, Layout.baseResourceIconSize, Layout.baseResourceIconSize, 15);
				}
				_resContainer.unflatten();
				_resContainer.clear();

				for each(var type:String in ResourceSet.TYPES) {
					var count:int = _resourceSet.get(type);
					if (count == 0) continue;

					var counter:ResourceCounter = resourceCounterFactory.apply(this, [type, _resourceSet]);
					_resContainer.addChild(counter);
				}

				content.push(_resContainer);
			}

			if (_buttonLabel) {
				if (!_button) _button = new MediumGreenButton(_buttonLabel);
				_button.addEventListener(Event.TRIGGERED, handler_buttonClick);
				content.push(_button);
			} else {
				if (_button) {
					if (_button.parent) _button.parent.removeChild(_button);
					_button.removeEventListener(Event.TRIGGERED, handler_buttonClick);
				}
			}

			return content;
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_buttonClick(event:*):void {
			dispatchEventWith(EVENT_BUTTON_CLICK);
		}

		private function handler_resourceChange(event:*):void {
			invalidate(INVALIDATION_FLAG_LAYOUT);
		}
	}
}
