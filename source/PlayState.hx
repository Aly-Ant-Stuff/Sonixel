package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public var player:Player;
	public var camGame:FlxCamera;
	public var camPos:FlxObject;
	#if android
	public var virtualPad:android.SonicVPad;
	#end
	public var focusInPlayerX:Bool = true;
	public var focusInPlayerY:Bool = true;

	override public function create()
	{
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.bgColor = FlxColor.GRAY;
		camGame.zoom = 4;

		camPos = new FlxObject(0, 0, 1, 1);
		add(camPos);
		FlxG.camera.follow(camPos, LOCKON, 1);

		player = new Player();
		player.screenCenter(XY); //placeholder
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

		if(focusInPlayerX){
			camPos.x = player.x + (player.width / 2);
		}
		if(focusInPlayerY){
			camPos.y = player.y + (player.height / 2);
		}
		if (FlxG.keys.pressed.UP #if android || virtualPad.buttonUp.pressed #end && player.isGrounded){
			focusInPlayerY = false;
			focusInPlayerX = false;

			player.spr.animation.play("lookUp");
			player.isLookingUp = true;
			new FlxTimer().start(2, function(t:FlxTimer){
				var targetY:Float = camPos.y - 100;
				camPos.y -= 0.5;
				player.hasLookedUp = true;
				if (camPos.y <= targetY){
					camPos.y = targetY;
				}
			});
		}else{
			player.isLookingUp = false;
			if (player.hasLookedUp){
				focusInPlayerX = true;
				var targetY = player.y + (player.height / 2);
				camPos.y += 0.5;
				if (camPos.y >= targetY)
				{
					camPos.y = targetY;
					focusInPlayerY = true;
					player.hasLookedUp = false;
				}
			}
		}

		super.update(elapsed);
	}
}
