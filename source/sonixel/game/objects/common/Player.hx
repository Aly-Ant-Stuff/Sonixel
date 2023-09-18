package sonixel.game.objects.common;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

#if android
import sonixel.plataforms.android.SonicVPad;
#end

import sonixel.backend.Paths;
import sonixel.game.objects.misc.Hitbox;

/**
  * i get the physical stuff for the movement of sonic from Sonic Physics Guide from Sonic Retro and i recreated it in haxeflixel
  * yeah im really dumb in math but i love math...
*/

class Player extends FlxTypedSpriteGroup<FlxSprite>
{
	public var spr:FlxSprite;
	public var hitbox:Hitbox;

	public var curGround:tilesets.Block = null;
	#if android
	public var virtualPad:SonicVPad;
	#end
	public var animationStuff:Array<Dynamic> = [ //name, frames, framerate, loop (true or false)
		["idle", [0], 12, true],
		["lookUp", [1,2], 12, false],
		["lookDown", [3, 4], 12, false],
		["lookOnYOUFirstF", [5, 6], 12, false],
		["lookOnYOU", [7,8,9], 9, true],
		["chillS", [14,10,11], 12, false],
		["chill", [12,13], 12, true],
		["walk", [15,16,17,18,19,20,21,22], 12, true],
		["run", [23,24,25,26], 12, false],
		["sonicBall", [27,28,29,30,31], 12, false]
	];

	//all the movement stuff
	public var currentGRDSpeed:Float = 0;
	public var currentGRDAngle:Float = 0;

	public var accelerationSpeed:Float = 0.046875;
	public var decelerationSpeed:Float = 0.5;
	public var frictionSpeed:Float = 0.046875;
	public var topSpeed:Float = 6;
	public var gravityForce:Float = 0.21875;
	public var airAccelerationSpeed:Float = 0.21875;
	public var jumpForce:Float = 6.5;
	public var controlLock:Int = 0;

	//actions
	public var hasLookedUp:Bool = false;
	public var isGrounded:Bool = false;
	public var isLookingUp:Bool = false;
	public var isWalking:Bool = false;
	public var isColliding:Bool = false;
	public var debugMode:Bool = false;

	//vectorz
	public var speed:FlxPoint = FlxPoint.get(0,0);

	public function new(x:Float = 0, y:Float = 0, ?char:String)
	{
		super(x, y);

		spr = new FlxSprite().loadGraphic(Paths.image('Sonic'), true, 48, 48);
		for (i in 0...animationStuff.length)
			spr.animation.add(animationStuff[i][0], animationStuff[i][1], animationStuff[i][2]);
		spr.animation.play("idle");
		spr.antialiasing = false;
		add(spr);
		origin.set(24, 30); //for the go to the center of the sprite

		hitbox = new Hitbox(15, 8, 17, 40, PLAYER);
		add(hitbox);
	}

	public function playerUpdate(elapsed:Float)
	{
		//player general part
		x += speed.x;
		y += speed.y;
		if(curGround.groundSpeed > 0){
			speed.x += curGround.groundSpeed;
			if(spr.animation.curAnim.name =='walk'){
				spr.animation.curAnim.frameRate = Math.floor(Math.max(0,4 - Math.abs(speed.x)));
			}
		}

		//if(sensors.sensor.sensorA.x > curGround.terrainHitbox.pixels.x && curGround.terrainHitbox.pixels != 0x00000000)

		if (FlxG.keys.pressed.LEFT #if android || virtualPad.buttonLeft.pressed #end) {
			spr.flipX = true;
			spr.animation.play('walk');
			if (speed.x > 0) {
				speed.x -= decelerationSpeed;
				if (speed.x <= 0)
					speed.x = -0.5;

			} else if (speed.x > -topSpeed) {
				speed.x -= accelerationSpeed;
				if (speed.x <= -topSpeed)
				{
					speed.x = -topSpeed;
					FlxG.log.add('sonic atinguiu a velocide maxima sem nada olha que fo');
				}
			}
		}
		else if (FlxG.keys.pressed.RIGHT #if android || virtualPad.buttonRight.pressed #end) {
			spr.flipX = false;
			spr.animation.play('walk');
			if (speed.x < 0) {
				speed.x += decelerationSpeed;
				if (speed.x >= 0)
					speed.x = 0.5;
			}else if (speed.x < topSpeed){
				speed.x += accelerationSpeed;
				if (speed.x >= topSpeed) {
					speed.x = topSpeed;
					FlxG.log.add('sonic atinguiu a velocide maxima sem nada olha que fo');
				}
			}
		} else {
			speed.x -= Math.min(Math.abs(speed.x), frictionSpeed) * FlxMath.signOf(speed.x);
		}

		//  ----- gravity ----- //
		if (!isGrounded){
			while (speed.y < 16) speed.y += gravityForce;
			//if (speed.y >= 16) speed.y = 16;
		}

		if (FlxG.keys.pressed.SPACE #if android || virtualPad.buttonJump.pressed #end){
			speed.y -= jumpForce * Math.sin(currentGRDAngle);
			speed.x -= jumpForce * Math.cos(currentGRDAngle);
		}

		FlxG.watch.addQuick("x do sonic", x);
		FlxG.watch.addQuick("y do sonic", y);
		FlxG.watch.addQuick("velocidade do sonic em x", speed.x);
		FlxG.watch.addQuick("velocidade do sonic em y", speed.y);
		FlxG.watch.addQuick("fps do sonic", spr.animation.curAnim.frameRate);
	}

	public function canMoveNext(player:Player):Bool{
		
	}
}