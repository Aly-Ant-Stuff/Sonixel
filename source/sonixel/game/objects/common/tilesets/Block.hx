package sonixel.game.objects.common.tilesets;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

import sonixel.game.objects.misc.Hitbox;

class Block extends FlxSpriteGroup {
	public var tileSpr:FlxSprite;
	public var topArea:Hitbox;
	public var botArea:Hitbox;

	private var tiles:Array<Dynamic> = [ //same thing with the player class
		["rampa", [0], 1],
		["bloco", [1], 1]
	];

	public function new(x:Float, y:Float, width = 24, height = 24, spr:String){
		super(x,y);

		tileSpr = new FlxSprite().loadGraphic(Paths.image('tilesets'), 24, 24);
		for (anim in tiles)
			animation.add(anim[0], anim[1], anim[2]);
		animation.play('bloco');
		tileSpr.setGraphicSize(width, height);
		tileSpr.updateHitbox();
		add(tileSpr);

		topArea = new Hitbox(tileSpr.x, tileSpr.y + tileSpr.height / 2, hitbox.width, hitbox.height / 2);
		add(topArea);

		botArea = new Hitbox(tileSpr.x, tileSpr.y + (tileSpr.height - (tileSpr.height/2)), hitbox.width, hitbox.height/ 2);
		add(botArea);
	}
}