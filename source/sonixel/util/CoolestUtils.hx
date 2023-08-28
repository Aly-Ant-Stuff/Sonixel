package sonixel.util;

import sonixel.game.objects.misc.Hitbox;
import flixel.FlxG;

class CoolestUtils {
	public static function collisionHitboxCheck(hitbox1:Hitbox, hitbox2:Hitbox):Bool{
		var isColliding:Bool = false;
		FlxG.collide(hitbox1, hitbox2, function(){
			isColliding = true;
		});
		if(isColliding)
				hitbox1.color = FlxColor.fromRGB(255, 0, 255);
		else
				hitbox1.color = hitbox1.originalColor;

		return isColliding;
	}
}