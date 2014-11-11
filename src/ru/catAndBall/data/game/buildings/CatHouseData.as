package ru.catAndBall.data.game.buildings {
	import ru.catAndBall.data.dict.BuildingDict;
	import ru.catAndBall.data.dict.BuildingState;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.utils.TimeInterval;
	import ru.catAndBall.utils.TimeUtil;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:34
	 */
	public class CatHouseData extends BuildingData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CatHouseData() {
			var dict:BuildingDict = new BuildingDict();
			dict.catHouseLevel = 0;

			var st:BuildingState = new BuildingState();      // первый стейт
			st.index = 0;
			st.lockedToLevel = 0;                            // залочен на нулевой уровень
			st.buildTime = TimeInterval.MINUTE * 2;          // строится 2 минуты
			st.price.set(ResourceSet.BF_BALLS, 10);          // требует для постройки 10 клубков
			st.price.set(ResourceSet.BF_SOCKS, 3);           // и три носка
			st.speedUpPrice.set(ResourceSet.MONEY, 4);       // ускорить можно за 4 денег
			st.bonusPeriod = TimeInterval.SECOND * 10;       // дает бонус раз в N
			st.bonus.set(ResourceSet.TOOL_SPOKES, 3); // дает 3 собиратора носков
			st.bonus.set(ResourceSet.EXPERIENCE, 10);        // и 10 опыта

			dict.states.push(st);

			st = new BuildingState();
			st.index = 1;
			st.buildTime = TimeInterval.MINUTE * 6;
			st.lockedToLevel = 0;
			st.price.set(ResourceSet.BF_BALLS, 20);
			st.price.set(ResourceSet.BF_SOCKS, 6);

			dict.states.push(st);
			super(dict);
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			return result;
		}
	}
}
