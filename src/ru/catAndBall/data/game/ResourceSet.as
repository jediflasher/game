package ru.catAndBall.data.game {
	
	import flash.events.Event;
	
	import ru.catAndBall.data.BaseData;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.09.14 8:19
	 */
	public class ResourceSet extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EXP:String = 'exp';

		public static const EXPERIENCE:String = 'experience';

		public static const MONEY:String = 'money';

		public static const MOUSE:String = 'mouse';

		public static const TOOL_SPOKES:String = 'tool_spokes';

		public static const TOOL_TOYBOX:String = 'tool_toybox';

		public static const TOOL_BASKET:String = 'tool_basket';

		public static const TOOL_KNITTEDGUN:String = 'tool_knittedgun';

		public static const TOOL_CUP_COFFEE:String = 'tool_cup_coffee';

		public static const TOOL_BARE_FEET:String = 'tool_bare_feet';

		public static const TOOL_CONTAINER:String = 'tool_container';

		public static const TOOL_COZY_HOLE:String = 'tool_cozy_hole';

		public static const TOOL_CONVENIENT_CELL:String = 'tool_convenient_cell';

		public static const TOOL_VACUUM_CLEANER:String = 'tool_vacuum_cleaner';

		public static const TOOL_SPONGE:String = 'tool_sponge';

		public static const TOOL_PACKET:String = 'tool_packet';

		public static const TOOL_SPARROWS:String = 'tool_sparrows';

		public static const TOOL_DOGCOUCHES:String = 'tool_dogcouches';

		public static const TOOL_EMPTY_REEL:String = 'tool_empty_reel';

		public static const TOOL_MIRROR:String = 'tool_mirror';

		public static const TOOL_RIBBON:String = 'tool_ribbon';

		public static const TOOL_POT:String = 'tool_pot';

		public static const TOOL_VASE:String = 'tool_vase';

		public static const TOOL_FODDER:String = 'tool_fodder';

		public static const TOOL_CARROT:String = 'tool_carrot';

		public static const TOOL_APPLE:String = 'tool_apple';

		public static const TOOL_LAWN_MOWER:String = 'tool_lawn_mower';

		public static const TOOL_NEEDLE:String = 'tool_needle';

		public static const TOOL_EMPTY_CANS:String = 'tool_empty_cans';

		public static const TOOL_COLLAR:String = 'tool_collar';

		public static const BF_BALLS:String = 'bfBalls';

		public static const BF_SOCKS:String = 'bfSocks';

		public static const BF_SWEATERS:String = 'bfSweaters';

		public static const BF_TOYS:String = 'bgToys';

		public static const RF_BALL:String = 'rfBall';

		public static const RF_COOKIE:String = 'rfCookie';

		public static const RF_MOUSE:String = 'rfMouse';

		public static const RF_MILK:String = 'rfMilk';

		public static const RF_PIGEON:String = 'rfPigeon';

		public static const RF_CONSERVE:String = 'rfConserve';

		public static const RF_GRAIN:String = 'rfGrain';

		public static const RF_THREAD:String = 'rfThread';

		public static const TYPES:Vector.<String> = new <String>[
			EXPERIENCE, MONEY, MOUSE,
			TOOL_APPLE, TOOL_BARE_FEET, TOOL_BASKET, TOOL_CARROT, TOOL_COLLAR, TOOL_CONTAINER, TOOL_CONVENIENT_CELL, TOOL_COZY_HOLE,
			TOOL_CUP_COFFEE, TOOL_DOGCOUCHES, TOOL_EMPTY_CANS, TOOL_EMPTY_REEL, TOOL_FODDER, TOOL_KNITTEDGUN, TOOL_LAWN_MOWER, TOOL_MIRROR,
			TOOL_NEEDLE, TOOL_PACKET, TOOL_POT, TOOL_RIBBON, TOOL_SPARROWS, TOOL_SPOKES, TOOL_SPONGE, TOOL_TOYBOX, TOOL_VACUUM_CLEANER, TOOL_VASE,
			BF_BALLS, BF_SOCKS, BF_SWEATERS, BF_TOYS, RF_BALL,
			RF_COOKIE, RF_MOUSE, RF_MILK, RF_PIGEON, RF_CONSERVE, RF_GRAIN, RF_THREAD
		];

		public static function isTool(resourceType:String):Boolean {
			if (!(resourceType in _hashIsTool)) {
				_hashIsTool[resourceType] = resourceType.indexOf('tool') == 0;
			}
			return _hashIsTool[resourceType];
		}

		public static function isComponent(resourceType:String):Boolean {
			if (!(resourceType in _hashIsComponent)) {
				_hashIsComponent[resourceType] = resourceType.indexOf('rf') == 0 || resourceType.indexOf('bf') == 0;
			}
			return _hashIsComponent[resourceType];
		}

		public static function isResource(resourceType:String):Boolean {
			if (!(resourceType in _hashIsResouce)) {
				_hashIsResouce[resourceType] = resourceType == EXPERIENCE || resourceType == MONEY;
			}
			return _hashIsResouce[resourceType];
		}

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static const _hashIsTool:Object = {};

		private static const _hashIsComponent:Object = {};

		private static const _hashIsResouce:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceSet() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _hash:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get isEmpty():Boolean {
			for (var key:String in _hash) return false;
			return true;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		[Inline]
		public final function get(resourceType:String):Number {
			return _hash[resourceType] || 0;
		}

		[Inline]
		public final function has(resourceType:String):Boolean {
			return get(resourceType) > 0;
		}

		[Inline]
		public final function set(resourceType:String, value:Number):void {
			_hash[resourceType] = value;
		}

		[Inline]
		public final function add(resourceSet:ResourceSet, multiplier:int = 1):void {
			if (resourceSet.isEmpty) return;

			for each(var type:String in TYPES) {
				var value:Number = resourceSet._hash[type] || 0;
				if (value) addTypeSilent(type, value * multiplier);
			}

			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		[Inline]
		public final function substract(resourceSet:ResourceSet):void {
			for each (var type:String in TYPES) {
				var value:Number = resourceSet._hash[type] || 0;
				if (value) {
					addTypeSilent(type, -value);
				}
			}

			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		[Inline]
		public final function substractType(type:String, count:int):void {
			addType(type, -count);
		}

		[Inline]
		public final function addType(type:String, count:int):void {
			addTypeSilent(type, count);
			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		public function hasEnough(resourceSet:ResourceSet):Boolean {
			for each (var type:String in TYPES) {
				var subValue:Number = resourceSet._hash[type] || 0;
				var oldValue:Number = _hash[type] || 0;
				if (subValue > oldValue) return false;
			}
			return true;
		}

		/**
		 * Возвращает ресурсы, которые необходимо докупить
		 * @param resourseSet
		 * @param result
		 * @return
		 */
		public function getDeficit(resourseSet:ResourceSet, result:ResourceSet):ResourceSet {
			for each (var type:String in TYPES) {
				var current:int = _hash[type];
				var def:int = resourseSet._hash[type];
				if (current < def) {
					result._hash[type] = def - current;
				}
			}

			return result;
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			for each (var key:String in TYPES) {
				if (key == EXP) key = EXPERIENCE;

				set(key, value[key] || 0);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();

			for each (var key:String in TYPES) {
				var value:Number = get(key);
				result[key] = value;
			}

			return result;
		}

		public function clear():void {
			for (var key:String in _hash) _hash[key] = 0;
			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		public final function addTypeSilent(type:String, count:int):void {
			_hash[type] ||= 0;
			_hash[type] += count;
		}
	}
}
