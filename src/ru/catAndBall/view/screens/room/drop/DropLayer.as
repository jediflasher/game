package ru.catAndBall.view.screens.room.drop {
	
	import airlib.util.t;

	import com.greensock.TweenNano;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;

	import feathers.core.FeathersControl;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.utils.str;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.text.TextFieldTest;
	import ru.catAndBall.view.core.utils.L;

	import starling.core.Starling;

	import starling.display.DisplayObject;

	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.10.14 16:41
	 */
	public class DropLayer extends FeathersControl {


		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function DropLayer() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function drop(resources:ResourceSet, fromX:int, fromY:int):void {
			if (resources.isEmpty) return;

			touchable = true;
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, handler_touch);

			for each (var resourceType:String in ResourceSet.TYPES) {
				var value:int = resources.get(resourceType);
				if (value <= 0) continue;

				var time:Number = 0;
				var iconsCount:int = Math.ceil(value / 3);
				for (var i:int = 0; i < iconsCount; i++) {
					var cnt:int = Math.ceil(value / iconsCount);
					value -= cnt;
					var icon:DropIcon = DropIcon.fromPool(resourceType, cnt);
					if (time > 0) {
						TweenNano.delayedCall(time, dropIcon, [icon, fromX, fromY]);
					} else {
						dropIcon(icon, fromX, fromY);
					}

					time += 0.1;
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function dropIcon(icon:DropIcon, fromX:int, fromY:int):void {
			icon.x = fromX;
			icon.y = fromY;
			icon.touchable = false;
			icon.scaleX = icon.scaleY = 0.6;
			addChild(icon);

			var step:Number = AppProperties.baseHeight / 10;

			var targetX:int = fromX + (Math.random() * step - step / 2);
			var targetY:int = fromY + (Math.random() * step / 2 + step / 4);

			TweenNano.to(icon, 0.3, {x: targetX, scaleX: 1, scaleY: 1, ease: Linear.easeNone});
			TweenNano.to(icon, 0.15, {
				y: fromY - step / 4,
				onComplete: dropIconStep2,
				onCompleteParams: [icon, targetX, targetY],
				overwrite: false,
				ease: Cubic.easeOut
			});
		}

		private function dropIconStep2(icon:DropIcon, targetX:int, targetY:int):void {
			TweenNano.to(icon, 0.15, {
				x: targetX,
				y: targetY,
				overwrite: false,
				ease: Bounce.easeOut,
				onComplete: dropAnimationComplete,
				onCompleteParams: [icon]
			});
		}

		private function collect(icon:DropIcon):void {
			icon.touchable = false;
			showFlyUpText(icon);
			TweenNano.to(icon, 0.3, {x: 0, y: 0, onComplete: flyOutComplete, onCompleteParams: [icon]});
		}

		private function dropAnimationComplete(icon:DropIcon):void {
			icon.touchable = true;
		}

		private function flyOutComplete(icon:DropIcon):void {
			DropIcon.toPool(icon);

			if (!numChildren) {
				touchable = false;
				Starling.current.stage.removeEventListener(TouchEvent.TOUCH, handler_touch);
			}
		}

		private function showFlyUpText(icon:DropIcon):void {
			var txt:BaseTextField = new BaseTextField(0xFFFFFF, t(60));
			txt.text = str('+%s %s', [icon.count, L.get(icon.resourceType)]);
			txt.x = icon.x;
			txt.y = icon.y;
			txt.touchable = false;
			txt.validate();
			txt.flatten();
			addChild(txt);
			var step:int = t(300);

			TweenNano.to(txt, 1.5, {
				alpha: 0,
				y: txt.y - step,
				ease: Linear.easeNone,
				onComplete: onFlyTextComplete,
				onCompleteParams: [txt]
			});
		}

		private function onFlyTextComplete(txt:BaseTextField):void {
			removeChild(txt);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_touch(event:TouchEvent):void {
			if (!this.touchable) return;

			var touch:Touch = event.getTouch(event.target as DisplayObject);
			if (!touch || touch.phase != TouchPhase.BEGAN && touch.phase != TouchPhase.MOVED) {
				return;
			}

			var numChildren:Number = super.numChildren;
			var posX:Number = touch.globalX;
			var posY:Number = touch.globalY;

			for (var i:int = 0; i < numChildren; i++) {
				var child:DropIcon = getChildAt(i) as DropIcon;
				if (!child || !child.touchable) continue;
				if (posX < child.x) continue;
				if (posY < child.y) continue;

				var w:Number = child.texture.width * child.scaleX;
				if (posX > child.x + w) continue;

				var h:Number = child.texture.height * child.scaleY;
				if (posY > child.y + h) continue;

				collect(child);
			}
		}
	}
}
