package sonixel.game.objects.common;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import sonixel.backend.Paths;
import sonixel.game.objects.common.tilesets.Block;

/**
 * WIPPPPP
 * -aly ant
 */
typedef GroundAngles = { //in da hitbox image
	var posX:Float;
	var posY:Float;
	var angle:Float;
}
typedef ZoneBlock={
	var type:String;
	var positionX:Float;
	var positionY:Float;
	var groundSpeed:Float;
	var groundAngles:Array<GroundAngles>;
}

class Zone extends FlxTypedSpriteGroup<FlxBasic>
{
	public var clouds:FlxTypedSpriteGroup<FlxBasic>;
	public var background:FlxTypedSpriteGroup<FlxBasic>;
	public var foreground:FlxTypedSpriteGroup<FlxBasic>;

	public var terrains:FlxTypedSpriteGroup<Block>;

	public function new(zone:String = ''){
		
	}
}