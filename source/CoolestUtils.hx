package;

class CoolestUtils {
	public static function gravityCheck(p:Player, block:Block):Bool{ //for blocks
		if (p != null && block != null){
			if (!p.debugMode){
				if (p.hitbox.y >= (block.hitbox.y - p.hitbox.height) && (p.hitbox.x >=block.hitbox.x && p.hitbox.x >=block.hitbox.x + block.hitbox.width)){
					return true;
				}else{
					return false;
				}
			}
		}
	}
}