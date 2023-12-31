package sonixel.util;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import sonixel.game.objects.misc.Hitbox;

class CoolestUtils {
	public static function collisionCheck(hitbox1:FlxSprite, hitbox2:FlxSprite, ?onCollision:Void->Void):Bool{
		var isColliding:Bool = false;
		var lastColor = hitbox1.color;
		FlxG.collide(hitbox1, hitbox2, function(){
			isColliding = true;
			onCollision(); //ai acontece o resto
		});
		if ((hitbox1 is Hitbox)){
			if(isColliding)
					hitbox1.color = FlxColor.fromRGB(255, 0, 255);
			else
					hitbox1.color = lastColor;
		}

		return isColliding;
	}

	public static function indicesIterator(start:Int, end:Int):Array<Int> {
		var array:Array<Int> = [];
		for (i in start...end)
			array.push(i);
		return array;
	}

	// matemática foda
	public static function radToDeg(rad:Float):Float {
		return rad * 180 / Math.PI;
 	}
}