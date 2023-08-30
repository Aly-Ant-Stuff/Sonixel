package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxGame;
import openfl.display.Sprite;

typedef ZoneStruct ={
	var name:String;
	var acts:Array<Int>; //set do 3 automally
}

class Main extends Sprite
{
	public static var game:Array<Dynamic> = [
		1280, 720, //resolution
		sonixel.game.states.PlayState, //state
		90, //framerate
		true, //skip splash
		#if mobile true #else false #end //fullscreen
	];
	
	

	public function new()
	{
		super();

		addChild(new FlxGame(game[0], game[1], sonixel.Init, game[3], game[3], game[4], game[5]));
		//exactly 5 indexes lma
	}

	public static function switchState(nextState:FlxState) {
		//O QUE FAZER: a transiçao
		FlxG.switchState(nextState);
	}
}
