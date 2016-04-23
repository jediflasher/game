//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.room {
	
	import airlib.view.core.BaseParserScreen;
	
	import feathers.controls.text.TextFieldTextRenderer;
	
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.game.player.ConstructionCollectionData;
	import ru.catAndBall.data.proto.ConstructionId;
	import ru.catAndBall.data.proto.Prototypes;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.room.drop.ConstructionCollectIconLayer;
	import ru.catAndBall.view.screens.room.drop.DropLayer;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 14:27
	 */
	public class ScreenRoom extends BaseParserScreen {
		
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		
		
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
		
		public function ScreenRoom() {
			super(ScreenType.ROOM, Library.get('ScreenRoom'));
			for each (var id:String in ConstructionId.LIST) {
				addFactory(id, Construction);
			}
		}
		
		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------
		
		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _dataToView:Object = {};

		private var _constructionCollectionLayer:ConstructionCollectIconLayer;

		private var _dropLayer:DropLayer;
		
		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public function drop(resources:ResourceSet, fromX:int, fromY:int):void {
			_dropLayer.drop(resources, fromX, fromY);
		}

		public function getConstruction(id:String):Construction {
			return _dataToView[id];
		}
		
		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------
		
		protected override function initialize():void {
			super.initialize();
			autoAssign();

			var con:ConstructionCollectionData = GameData.player.constructions;
			for each (var constructionData:ConstructionData in con.list) {
				var id:String = constructionData.id;
				var view:Construction = getChildByName(constructionData.id) as Construction;
				if (!view) continue;

				view.data = constructionData;
				_dataToView[id] = view;
			}

			_constructionCollectionLayer = new ConstructionCollectIconLayer(this);
			addChild(_constructionCollectionLayer);

			_dropLayer = new DropLayer();
			addChild(_dropLayer);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}
