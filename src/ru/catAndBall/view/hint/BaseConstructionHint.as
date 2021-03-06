package ru.catAndBall.view.hint {
	
	import airlib.util.EverySecond;
	
	import feathers.controls.Panel;
	import feathers.controls.Scroller;
	import feathers.layout.VerticalLayout;
	
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.utils.TimeUtil;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	import ru.catAndBall.view.core.utils.L;
	
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.09.14 21:09
	 */
	public class BaseConstructionHint extends Panel {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function BaseConstructionHint(data:ConstructionData) {
			super();
			horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.data = data;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			this.layout = layout;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		public var data:ConstructionData;
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		private var _nameTextField:BaseTextField;
		
		private var _descTextField:BaseTextField;
		
		private var _levelTextField:TextFieldIcon;
		
		private var _timeTextField:TextFieldIcon;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		protected override function feathersControl_addedToStageHandler(event:Event):void {
			super.feathersControl_addedToStageHandler(event);
			
			EverySecond.add(updateTimer);
			update();
		}
		
		protected override function feathersControl_removedFromStageHandler(event:Event):void {
			EverySecond.remove(updateTimer);
			
			super.feathersControl_removedFromStageHandler(event);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function update():void {
			if (!_nameTextField) {
				_nameTextField = new BaseTextField(0, 30);
				addChild(_nameTextField);
			}
			
			_nameTextField.text = data.proto.name;
			
			if (!_descTextField) {
				_descTextField = new BaseTextField(0, 30);
				_descTextField.wordWrap = true;
				addChild(_descTextField);
			}
			
			_descTextField.text = data.state ? data.proto.description : L.get('construction.hint.locked');
			
			if (data.state) {
				if (!_levelTextField) {
					_levelTextField = new TextFieldIcon(new BaseTextField(0, 30), Assets.getImage(AssetList.hint_hintLvlIcon));
					addChild(_levelTextField);
				}
				
				_levelTextField.text = L.get('level %s', [data.level]);
				
				if (!_timeTextField) {
					_timeTextField = new TextFieldIcon(new BaseTextField(0, 30), Assets.getImage(AssetList.hint_hintTimeIcon));
					addChild(_timeTextField);
				}
				
				updateTimer();
			} else {
				if (_levelTextField) _levelTextField.visible = false;
				if (_timeTextField) _timeTextField.visible = false;
			}
		}
		
		private function updateTimer():void {
			if (!_timeTextField) return;
			if (!data) return;
			
			var tl:Number = data.bonusTimeLeft;
			var t:String = tl > 0 ? TimeUtil.stringify(tl) : L.get('construction.hint.done');
			_timeTextField.text = t;
		}
	}
}
