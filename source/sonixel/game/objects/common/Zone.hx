package sonixel.game.objects.common;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;

import sonixel.backend.Paths;
import sonixel.game.objects.common.tilesets.Block;
import sonixel.game.objects.common.Player;

import sys.FileSystem;
import sys.io.File;

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
typedef ZoneFile={
	var name:String;
	var act:Int;
	var blocks:Array<ZoneBlock>;
	var playerIntialPos:Array<Float>;
}

class Zone extends FlxTypedSpriteGroup<FlxBasic>
{
	public var name:String = 'Test';
	public var currentAct:Int = 0;
	public var playerInitialPosition:FlxPoint = FlxPoint.get(616, 0);
	public var currentJson:ZoneFile = null;

	public var clouds:FlxTypedSpriteGroup<FlxBasic>;
	public var background:FlxTypedSpriteGroup<FlxBasic>;

	public var terrains:FlxTypedSpriteGroup<Block>;
	public var foreground:FlxTypedSpriteGroup<FlxBasic>;


	// when saving the zone file
	public var terrainsArray:Array<ZoneBlock> = [];

	public function new(zone:String = '', offsetX:Float = 0, offsetY:Float = 0){
		super();

		background = new FlxTypedSpriteGroup<FlxBasic>();
		add(background);

		clouds = new FlxTypedSpriteGroup<FlxBasic>();
		add(clouds);

		generateZone();
	}

	public function generateZone(file:ZoneFile=null, player:Player=null, sidekick:Player=null){
		this.name = file.name;
		this.currentAct = file.act;

		this.playerInitialPosition.x = file.playerIntialPos[0];
		this.playerInitialPosition.y = file.playerIntialPos[1];
		if(player!=null){
			player.x = playerInitialPosition.x;
			player.y = playerInitialPosition.y;
		}

		for (data in file.blocks){
			addBlockToZone(data.type, data.positionX, data.positionX, data.groundSpeed, data.groundAngles)
		}
	}
	
	public function addBlockToZone(type:String, posX:Float, posY:Float, groundSpeed:Float, groundAngles:Array<GroundAngles>) {}

	public function saveZoneEntirely() {}
}