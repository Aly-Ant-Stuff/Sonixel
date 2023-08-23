package objects;

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
		["loopUp", [1,2], 12],
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

	//actions
	public var hasLookedUp:Bool = false;
	public var defaultCamPos:FlxPoint = FlxPoint.get(0, 0);
	public var isGrounded:Bool = true;
	public var isColliding:Bool = false;

	//vectorz

	public function new(x:Float, y:Float, ?char:String)
	{
		super(x, y);

		spr = new FlxSprite().loadGraphic("assets/images/sonic.png", true, 46, 52);
		for (i in 0...animationStuff.length)
			spr.animation.add(animationStuff[i][0], animationStuff[i][1], animationStuff[i][2]);
		spr.antialiasing = false;
		add(spr);

		hitbox = new FlxSprite(15, 8).makeGraphic(17, 40, FlxColor.fromRGB(255,0,255));
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
		x += horiSPEED * FlxMath.signOf(direction);
		y += vertSPEED * FlxMath.signOf(direction);

		if (FlxG.keys.pressed(LEFT) #if android || virtualPad.buttonLeft.pressed #end) {
			horiSPEED = (elapsed/1.9); //pra ser mais devagar
			if (horiSPEED >= 5) horiSPEED = 5;
			direction = -1;
		}

		if (FlxG.keys.pressed(RIGHT) #if android || virtualPad.buttonRight.pressed #end) {
			horiSPEED = (elapsed/1.9); //pra ser mais devagar
			if (horiSPEED >= 5) horiSPEED = 5;
			direction = 1;
		}

		if (FlxG.keys.pressed(UP))
		{
			spr.animation.play("lookUp");
			new FlxTimer().start(2, function(t:FlxTimer) {
				var tgrtY:Float = camPos.y - 400;
				camPos.y -= elapsed / 3.2;
				hasLookedUp = true;
				if (camPos.y <= tgrtY)
				{
					camPos.y = trgtY;
				}
			});
		} else {
			if (hasLookedUp) {
				var trgtY = defaultCamPos.y;
				camPos.y += elapsed / 3.2;
				if (camPos.y >= tgrtY)
				{
					camPos.y = trgtY;
				}
			}
		}

		FlxG.watch.addQuick("char speed in x", horiSPEED);
		FlxG.watch.addQuick("char speed in y", vertSPEED);

		super.update(elapsed);
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