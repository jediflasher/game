//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package airlib.util {

	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.utils.Timer;

	import ru.airlib.util.log.info;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                08.12.11 16:22
	 */
	public class LocalStorage {

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static var _instance:LocalStorage = new LocalStorage();

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function init():void {
			_instance.$init();
		}

		public static function destroy():void {
			_instance.destroy();
			_instance = new LocalStorage();
		}

		public static function get(key:String):Object {
			return _instance.$get(key);
		}

		public static function set(key:String, value:Object):void {
			_instance.$set(key, value);
		}

		public static function has(key:String):Boolean {
			return _instance.$has(key);
		}

		public static function addToArray(key:String, value:Object):void {
			_instance.$addToArray(key, value);
		}

		public static function removeFromArray(key:String, value:Object):void {
			_instance.$removeFromArray(key, value);
		}

		public static function remove(key:String):void {
			_instance.$remove(key);
		}

		public static function save():void {
			_instance.save();
		}

		public static function forceSave():void {
			_instance.forceSave();
		}

		public static function getComplex(key:String):Object {
			return _instance.$getComplex(key);
		}

		public static function setComplex(key:String, value:Object):void {
			_instance.$setComplex(key, value);
		}

		public static function clear():void {
			_instance.$clear();
		}

		/**
		 * Возвращает копию хэша всех клиентских значений
		 * @return
		 */
		public static function getAll():Object {
			var data:Object = _instance._storage.data;
			var result:Object = new Object();
			for (var key:String in data) {
				result[key] = data[key];
			}
			return result;
		}

		public function LocalStorage() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _sharedObject:SharedObject;

		/**
		 * @private
		 */
		private var _storage:Object;

		/**
		 * Сохраняем результаты только по таймеру, не чаще раза в 2 сек.
		 */
		private var _saveTimer:Timer = new Timer(2000, 1);

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function $init():void {
			try {
				_sharedObject = SharedObject.getLocal('knights_and_roses');
				_storage = _sharedObject.data;
				if (!_storage.data) {
					_storage.data = _sharedObject.data.data = {};
				}

				info(this, 'LocalStorage initialized:\n{0}', [traceObject(_storage.data, false)]);

			} catch (error:Error) {
				_storage = {data: {}};
				info(this, 'Cant initialize local storage');
			}
		}

		private function destroy():void {
			if (_saveTimer) {
				_saveTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, saveTimerComplete);
				_saveTimer.stop();
				_saveTimer.reset();
				_saveTimer = null;
			}
		}

		private function $get(key:String):Object {
			return _storage.data[key];
		}

		private function $set(key:String, value:Object):void {
			var data:Object = _storage.data;
			if (data[key] === value) return;
			data[key] = value;

			save();
		}

		private function $getComplex(key:String):Object {
			var keys:Array = key.split('.');
			var subKey:String;
			var result:Object = _storage.data;
			var len:int = keys.length;
			for (var i:int = 0; i < len; i++) {
				subKey = keys[i];
				if (subKey in result) result = result[subKey] else return null;
				if (!result) break;
			}

			return result;
		}

		private function $setComplex(key:String, value:Object):void {
			var keys:Array = key.split('.');
			var len:int = keys.length;
			if (len == 1) {
				$set(key, value);
				return;
			}

			var subKey:String;
			var targetObject:Object;
			for (var i:int = 0; i < len; i++) {
				subKey = keys[i];
				var last:Boolean = i >= len - 1;

				if (!targetObject) {
					if (!$has(subKey)) $set(subKey, {});
					targetObject = $get(subKey);
				} else if (!last) {
					targetObject[subKey] ||= {};
					targetObject = targetObject[subKey];
				}
			}

			targetObject[subKey] = value;

			this.save();
		}

		/**
		 * @private
		 */
		private function $has(key:String):Boolean {
			return key in _storage.data;
		}

		/**
		 * @private
		 */
		private function $remove(key:String):void {
			if (!this.$has(key)) return;

			delete _storage.data[key];
			this.save();
		}

		/**
		 * @private
		 */
		private function $addToArray(key:String, value:Object):void {
			var array:Array = this.$get(key) as Array;
			if (!array) {
				array = [];
				this.$set(key, array);
			}

			array.push(value);
			this.save();
		}

		/**
		 * @private
		 */
		private function $removeFromArray(key:String, value:Object):void {
			var array:Array = this.$get(key) as Array;
			if (array) {
				var index:int = array.indexOf(value);
				if (index > -1) {
					array.splice(index, 1);
					this.save();
				}
			}
		}


		/**
		 * @private
		 */
		private function $clear():void {
			_storage.data = {};
			this.save();
		}

		/**
		 * @private
		 */
		private function save():void {
			// если таймер не запущен, сохраняем значения, и запускаем таймер, чтобы ранее чем таймер отработает, данные больше никто не сохранял
			if (!_saveTimer.running) {
				_saveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, saveTimerComplete);
				_saveTimer.reset();
				_saveTimer.start();
			}
		}

		private function forceSave():void {
			this.saveTimerComplete(null);
		}

		/**
		 * @private
		 */
		private function saveTimerComplete(event:TimerEvent = null):void {
			_saveTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, saveTimerComplete);
			_saveTimer.stop();
			_saveTimer.reset();
			if (_sharedObject) _sharedObject.flush();
			info(this, 'Local storage saved');
		}
	}
}
