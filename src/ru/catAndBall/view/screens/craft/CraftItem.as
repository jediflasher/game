package ru.catAndBall.view.screens.craft {
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.core.FeathersControl;

	import ru.catAndBall.data.game.tools.BaseToolData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                12.10.14 19:05
	 */
	public class CraftItem extends DefaultListItemRenderer {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CraftItem() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _icon:ResourceCounter;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function draw():void {
			if (isInvalid(FeathersControl.INVALIDATION_FLAG_DATA)) {
				defaultSkin = Assets.getImage(index % 2 ? AssetList.Tools_tool_background_1 : AssetList.Tools_tool_background_1);

				var d:BaseToolData = super.data as BaseToolData;
				if (d) {
					if (!_icon) {
						_icon = new ResourceCounter(d.resourceType, d.resourceSet);
						addChild(_icon);
					}
				}

				flatten();
			}

			super.draw();
		}
	}
}
