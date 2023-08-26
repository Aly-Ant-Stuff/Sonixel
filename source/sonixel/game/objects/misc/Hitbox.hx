package sonixel.game.objects.misc;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

enum HitboxType
{
	ATTACKABLE;
	HURT;
	HURT_AND_ATTACKABLE;
	REBOUND;
	VIEW_AREA;
	PLAYER;
	TERRAIN;
}

class Hitbox extends FlxSprite
{
	public function new (x:Float, y:Float, width:Int, height:Int, type:HitboxType){
		super(x, y);
		makeGraphic(width, height, FlxColor.WHITE); //white to be colorable

		switch (type){
			case ATTACKABLE | HURT | HURT_AND_ATTACKABLE:
				color = FlxColor.RED;
			case REBOUND:
				color = FlxColor.BLUE;
			case VIEW_AREA:
				color = FlxColor.YELLOW;
			case PLAYER:
				color = FlxColor.GREEN;
		}
		alpha = 0.4;
	}
}