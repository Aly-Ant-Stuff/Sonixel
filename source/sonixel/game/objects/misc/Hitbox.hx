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
	private var coloringaMap:Map<HitboxType, FlxColor> = [
		ATTACKABLE => FlxColor.RED,
		HURT => FlxColor.RED,
		HURT_AND_ATTACKABLE => FlxColor.RED,
		REBOUND => FlxColor.BLUE,
		VIEW_AREA => FlxColor.YELLOW,
		PLAYER => FlxColor.GREEN,
		TERRAIN => FlxColor.GREEN
	];
	public var type:HitboxType;
	public var isColliding:Bool;
	public var originalColor:FlxColor; //in sonixel.utils.CoolestUtils you will understand

	public function new (x:Float, y:Float, width:Int, height:Int, type:HitboxType){
		super(x, y);
		makeGraphic(width, height, FlxColor.WHITE); //white to be colorable

		color = coloringaMap[type];
		originalColor = coloringaMap[type];

		type = this.type;
		alpha = 0.4;
	}
}