package sonixel.game.objects.common;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import sonixel.backend.Paths;

/**
 * WIPPPPP
 * -aly ant
 */

class Zone extends FlxTypedSpriteGroup<FlxBasic>
{
	public var clouds:FlxTypedSpriteGroup<FlxBasic>;
	public var background:FlxTypedSpriteGroup<FlxBasic>;
	public var foreground:FlxTypedSpriteGroup<FlxBasic>;

	public var cloudsScroll:Float = 0.5;
}