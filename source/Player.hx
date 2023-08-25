package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import lime.math.Vector2;
#if android
import android.SonicVPad;
#end

//i get the physical stuff for the movement of sonic from Sonic Physics Guide from Sonic Retro and i recreated it in haxeflixel
//yeah im really dumb in math but i love math...

class Player extends FlxTypedSpriteGroup<FlxSprite>
{
	public var spr:FlxSprite;
	public var hitbox:FlxSprite;

	public var spinDashT:FlxSprite;

	public var pCam:FlxCamera;
	public var curGround:FlxSprite;
	public var camPos:FlxObject;
	#if android
	public var virtualPad:SonicVPad;
	#end
	public var animationStuff:Array<Dynamic> = [
		["idle", [0], 12],
		["lookUp", [1,2], 12],
		["goDown", [3, 4], 12]
	];

	//all the movement stuff
	public var horiSPEED:Float = 0;
	public var vertSPEED:Float = 0;
	public var currentGRDSpeed:Float = 30;
	public var currentGRDAngle:Float = 0;

	public var accelerationSpeed:Float = 0.046875;
	public var decelerationSpeed:Float = 0.5;
	public var frictionSpeed:Float = 0.046875;
	public var topSpeed:Float = 6;
	public var gravityForce:Float = 0.21875;
	public var direction:Int = 0;

	//actions
	public var hasLookedUp:Bool = false;
	public var defaultCamPos:FlxPoint = FlxPoint.get(0, 0);
	public var isGrounded:Bool = true;
	public var isWalking:Bool = false;
	public var isColliding:Bool = false;

	//vectorz

	public function new(x:Float, y:Float, ?char:String)
	{
		super(x, y);

		spr = new FlxSprite().loadGraphic("assets/images/Sonic.png", true, 46, 52);
		for (i in 0...animationStuff.length)
			spr.animation.add(animationStuff[i][0], animationStuff[i][1], animationStuff[i][2]);
		spr.animation.play("idle");
		spr.antialiasing = false;
		spr.scale.set(4, 4);
		spr.updateHitbox();
		add(spr);

		hitbox = new FlxSprite(15, 8).makeGraphic(17 * 4, 40 * 4, FlxColor.fromRGB(255, 0, 255));
		hitbox.alpha = 0.4;
		add(hitbox);

		if (pCam != null && camPos != null)
		{
			pCam.follow(camPos, LOCKON, 1);
		}
	}

	public function playerUpdate(elapsed:Float)
	{
		//player general part
		defaultCamPos.set(spr.x + (spr.width / 2), spr.y + (spr.height / 2));
		camPos.setPosition(defaultCamPos.x, defaultCamPos.y);
		x += horiSPEED;
		y += vertSPEED;

		if (FlxG.keys.pressed.LEFT #if android || virtualPad.buttonLeft.pressed #end) {
			spr.scale.x = -1;
			if (horiSPEED > 0) {
				horiSPEED -= decelerationSpeed;
				if (horiSPEED <= 0)
					horiSPEED = -0.5;
				direction = 1;
			} else if (horiSPEED < -topSpeed) {
				horiSPEED -= accelerationSpeed;
				if (horiSPEED <= -topSpeed)
					horiSPEED = -topSpeed;
			}
			isWalking = true;
		}
		else if (FlxG.keys.pressed.RIGHT #if android || virtualPad.buttonRight.pressed #end) {
			spr.scale.x = 1;
			if (horiSPEED < 0) {
				horiSPEED += decelerationSpeed;
				if (horiSPEED >= 0)
					horiSPEED = 0.5;
				direction = 1;
			} else if (horiSPEED < topSpeed) {
				horiSPEED += accelerationSpeed;
				if (horiSPEED >= topSpeed)
					horiSPEED = topSpeed;
			}
		} else {
			horiSPEED -= Math.min(Math.abs(horiSPEED), frictionSpeed) * FlxMath.signOf(horiSPEED);
		}

		if (FlxG.keys.pressed.UP #if android || virtualPad.buttonUp.pressed #end)
		{
			spr.animation.play("lookUp");
			new FlxTimer().start(2, function(t:FlxTimer) {
				var targetY:Float = camPos.y - 400;
				camPos.y -= 0.5;
				hasLookedUp = true;
				if (camPos.y <= targetY)
				{
					camPos.y = targetY;
				}
			});
		} else {
			if (hasLookedUp) {
				var targetY = defaultCamPos.y;
				camPos.y += 0.5;
				if (camPos.y >= targetY)
				{
					camPos.y = targetY;
				}
			}
		}

		FlxG.watch.addQuick("char speed in x", horiSPEED);
		FlxG.watch.addQuick("char speed in y", vertSPEED);
	}

	function indicesIterator(start:Int, end:Int):Array<Int> {
		var array:Array<Int> = [];
		for (i in start...end)
			array.push(i);
		return array;
	}

	// matemática foda
	function radToDeg(rad:Float):Float {
		return rad * 180 / Math.PI;
 	}
}