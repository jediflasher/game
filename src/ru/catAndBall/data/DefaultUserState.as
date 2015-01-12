package ru.catAndBall.data {
	import ru.catAndBall.utils.TimeUtil;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.10.14 15:56
	 */
	public dynamic class DefaultUserState extends Object {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function DefaultUserState() {
			super();

			this["player"] = {
				constructions: [
					{
						id: "catHouse",
						level: 1,
						startBuildingTime: 0,
						lastBonusTime: TimeUtil.now
					}
				],
				resources: {
					experience: 10,
					money: 130,
					toolCollectSocks: 0,
					bfBalls: 10,
					bfSocks: 10,
					bfSweaters: 40,
					bgToys: 80,
					rfBall: 0,
					rfCookie: 20,
					rfMouse: 0,
					rfSausage: 0,
					rfPigeon: 30,
					rfConserve: 0,
					rfWrapper: 10,
					rfThread: 0
				}
			};
		}
	}
}


