package sonixel.util;

import sonixel.game.objects.misc.Hitbox;

class CoolestUtils {
	public static function collisionHitboxCheck(hitbox1:Hitbox, hitbox2:Hitbox):Bool{ //for blocks
		if (hitbox1.y >= (hitbox2.hitbox.y - hitbox1.height) && (hitbox1.x >=hitbox1.x && hitbox1.x < hitbox1.x + hitbox1.width)){
					return true;
		}else{
					return false;
		}
	}
}