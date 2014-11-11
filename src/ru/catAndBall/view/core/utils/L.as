package ru.catAndBall.view.core.utils {
	import ru.catAndBall.utils.str;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.09.14 21:55
	 */
	public class L {

		public static function get(text:String, args:Array = null):String {
			text = str(text, args);
			return dict[text] || text;
		}

		private static const dict:Object = {
			'start_field_popup.balls.title': 'Rolls',
			'start_field_popup.balls.desc': 'There is super beautiful field you can get in there and fuck off',
			'start_field_popup.balls.start': 'Start',
			'finish_field_popup.balls.title': 'It was very useful day! Hooray!',
			'finish_field_popup.balls.desc': '+%s experience',
			'finish_field_popup.balls.take': 'Take',
			'inventory.tab0': 'Tools',
			'inventory.tab1': 'Resources',
			'tool.toolSpool.name': 'Spool',
			'tool.toolSpool.desc': 'Spool very interesting description about some shit',
			'tool.toolBroom.name':'Broom',
			'tool.toolBroom.desc':'Broom very interesting description about some shit',
			'tool.toolToyBox.name': 'Toy box',
			'tool.toolToyBox.desc': 'Toy box very interesting description about some shit',
			'tool.toolBowl.name': 'Bowl',
			'tool.toolBowl.desc': 'Bowl very interesting description about some shit',
			'tool.toolSpokes.name': 'Spokes',
			'tool.toolSpokes.desc': 'Spokes very interesting description about some shit',
			'tool.toolTea.name': 'Cup of coffee',
			'tool.toolTea.desc': 'Cup of coffee very interesting description about some shit',
			'screen.craft.tabRug.title': 'Tools for rug field',
			'screen.craft.tabRolls.title': 'Tools for roll field',
			'screen.craft.tabWindow.title': 'Tools for window field',
			'screen.craft.makeButton': 'Create'
		};

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function L() {

		}
	}
}
