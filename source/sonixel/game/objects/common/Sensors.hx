package sonixel.game.objects.common;

class Sensors extends FlxTypedSpriteGroup<FlxBasic>
{
	public var sensorA:FlxSprite;
	public var sensorB:FlxSprite;
	public var sensorC:FlxSprite;
	public var sensorD:FlxSprite;
	public var sensorE:FlxSprite;
	public var sensorF:FlxSprite;

	private var originSpr:FlxSprite;
	var vertices:FlxTypedSpriteGroup<FlxBasic> = new FlxTypedSpriteGroup<FlxBasic>();

	public function new(player:Player, x:Float, y:Float, initialHeightSize:Int = 16, initialWidthSize:Int = 8){
		
	}

	public function createSensor(x, y, size, color, mode:String):FlxSprite{
		var result:FlxSprite = new FlxSprite(x,y);

		var width:Int=(mode == 'width' || mode == null ? size : 1);
		var height:Int=(mode == 'height' ? size : 1);

		/*
			//HARDCODED PORQUE EU TENHO MUITAS CAPACIDADES MENTAIS MUITO LIMITADAS :sun_glasses:
			switch(mode){
				case 'horizontal':
					width = size;
				case 'vertical':
					height = size;
			}
		*/
		result.makeGraphic(width, height, color);
		if (mode == 'width' || mode ==null){
			add(new FlxSprite(result.x, result.y).makeGraphic(1,1,0xFFffffff));
			add(new FlxSprite(result.x+result.width, result.y).makeGraphic(1,1,0xFFffffff));
		}
		if (mode == 'height' || mode ==null){
			add(new FlxSprite(result.x, result.y).makeGraphic(1,1,0xFFffffff));
			add(new FlxSprite(result.x, result.y+result.height).makeGraphic(1,1,0xFFffffff));
		}
		return result;
	}
}