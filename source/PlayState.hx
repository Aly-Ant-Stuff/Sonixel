package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var player:Player;
	public var camGame:FlxCamera;
	public var camPos:FlxObject;
	#if android
	public var virtualPad:android.SonicVPad;
	#end

	override public function create()
	{
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.follow(camPos, LOCKON, 1);
		camGame.bgColor = FlxColor.GRAY;

		camPos = new FlxObject(0, 0, 1, 1);
		add(camPos);

		player = new Player(FlxG.width / 2, FlxG.height / 2);
		add(player);

		#if android
		virtualPad = new android.SonicVPad();
		virtualPad.alpha = 0.45;
		add(virtualPad);
		player.virtualPad = this.virtualPad;

		var camControl = new flixel.FlxCamera();
		FlxG.cameras.add(camControl);
		camControl.bgColor.alpha = 0;
		virtualPad.cameras = [camControl];
		#end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		player.playerUpdate(elapsed);

		camPos.x = player.x + (player.width / 2);

		super.update(elapsed);
	}
}
