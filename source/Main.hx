package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var game:Array<Dynamic> = [
		1280, 720, //resolution
		PlayState, //state
		90, //framerate
		true, //skip splash
		#if mobile true #else false #end //fullscreen
	];

	public function new()
	{
		super();

		addChild(new FlxGame(game[0], game[1], Init, game[3], game[3], game[4], game[5]));
		//exactly 5 indexes lma
	}

	public static function switchState(nextState:FlxState) {
		//TODO: the transition
		FlxG.switchState(nextState);
	}
}
