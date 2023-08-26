package sonixel;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxSave;

class Init extends FlxState
{
	override function create() {
		FlxG.save.bind("SonicFlixel");
		#if (flixel >= "5.0.0")
		FlxSprite.defaultAntialiasing = false;
		#end

		FlxG.switchState(Type.createInstance(Main.game[2], [])); //porque nao tem instancia ainda
	}
}