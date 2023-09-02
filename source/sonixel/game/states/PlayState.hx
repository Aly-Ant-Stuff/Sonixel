package sonixel.game.states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxCollision;

#if android
import sonixel.plataforms.android.SonicVPad;
#end
import sonixel.game.objects.common.Player;
import sonixel.util.CoolestUtils;

class PlayState extends FlxState
{
	public var player:Player;
	public var camGame:FlxCamera;
	public var camPos:FlxObject;
	public var map:Zone = null;
	#if android
	public var virtualPad:SonicVPad;
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

		map = new Zone();
		map.generateZone(null, player, null);
		add(map);

		player = new Player();
		FlxG.log.add('initial player x pos: ' +player.x);
		FlxG.log.add('initial player y pos: ' +player.y);
		add(player);

		add(map.foreground);

		#if android
		virtualPad = new SonicVPad();
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
			player.spr.animation.play("idle");
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

		for (block in map.terrains.members){
			if (player.isGrounded == CoolestUtils.collisionCheck(player.hitbox, block.topArea)){
				player.curGround = block;
				FlxG.log.add('agora voce ta no chao jogador!!!!!!')
			}
		}

		if (map!=null){
			//in x
			if(camPos.x<=map.x)
				camPos.x=map.x;
			else if(camPos.x>=map.x+map.width)
				camPos.x=map.x+map.width;
			//in y
			if(camPos.x<=map.y)
				camPos.x=map.y;
			else if(camPos.y>=map.y+map.height)
				camPos.y=map.y+map.height;
		}

		super.update(elapsed);
	}
}
