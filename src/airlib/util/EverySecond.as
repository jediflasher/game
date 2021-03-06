package airlib.util {

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 14:13
	 */
	public class EverySecond {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function add(callback:Function):void {
			instance.add(callback);
		}

		public static function remove(callback:Function):void {
			instance.remove(callback);
		}

		private static const instance:EverySecond = new EverySecond();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function EverySecond() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _timer:Timer = new Timer(1000);

		private var _callBacks:Vector.<Function> = new Vector.<Function>();

		private var _hash:Dictionary = new Dictionary(true);

		private var _removeQueue:Vector.<Function> = new Vector.<Function>();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function add(callback:Function):void {
			if (callback in _hash) return;

			if (!_callBacks.length) {
				_timer.addEventListener(TimerEvent.TIMER, this.handler_timer);
				_timer.start();
			}

			_hash[callback] = true;
			_callBacks.push(callback);
		}

		public function remove(callback:Function):void {
			if (!(callback in _hash)) return;

			_removeQueue.push(callback);
			delete _hash[callback];
		}

		private function processRemoveQueue():void {
			var removed:Boolean = false;

			for each (var callback:Function in _removeQueue) {
				var index:int = _callBacks.indexOf(callback);
				if (index >= 0) _callBacks.splice(index, 1);

				if (!_callBacks.length) {
					_timer.removeEventListener(TimerEvent.TIMER, handler_timer);
					_timer.reset();
				}

				removed = true;
			}

			if (removed) _removeQueue = new Vector.<Function>();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_timer(event:Event):void {
			var len:int = _callBacks.length;
			for (var i:int = 0; i < len; i++) {
				var callback:Function = _callBacks[i];
				callback.apply();
			}

			processRemoveQueue();
		}
	}
}