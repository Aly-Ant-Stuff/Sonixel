/**
	* WIP!!! FOR CREATING STAGES AND OTHER STUFF FOR DEBUGGINGGG
*/
class DebugMenu extends FlxTypedSpriteGroup<FlxBasic>{
	//BACKEND STUFF
	public static var currentSection:String = 'Gameplay';

	public static var currentSelection:Int = 0;
	public static var debuggingConfigs:Map<String, Array<String>> = [
		'Gameplay' => [
			'Show hitboxes',
		]
	];
	public static var availableOptions:Array<String> = [];

	//FRONTEND STUFF
	public static var textsGroup:FlxTypedSpriteGroup<FlxBasic>;

	public function new() {}
	public function updateSel(sel:Int = 0){
		currentSelection += sel;
		if (textsGroup!=null){
			for (text in textsGroup.members){
				if(text.ID==currentSelection)
					text.color = 0xFF70719d;
				else
					text.color = 0xFFFFFFFF;
			}
		}
	}
	public function updateSection(section:String = 'Gameplay') {
		currentSelection = section;
		availableOptions = debuggingConfigs.get(section);
	}
}