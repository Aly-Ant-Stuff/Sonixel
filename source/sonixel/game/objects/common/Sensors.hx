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
		originSpr = new FlxSprite(player.origin.x, player.origin.y).loadGraphic(Paths.image('originSpr'));
		add(originSpr);

		sensorA = createSensor();
		add(sensorA);
		sensorB = createSensor();
		add(sensorB);
		sensorC = createSensor();
		add(sensorC);
		sensorD = createSensor();
		add(sensorD);
		sensorE = createSensor();
		add(sensorE);
		sensorF = createSensor();
		add(sensorF);
	}

	public function createSensor(?x, ?y, ?size, ?color, mode:Null<String> = null):FlxSprite{
		var result:FlxSprite = new FlxSprite(x,y);
		var width:Int=(mode == 'width' || mode == null ? size : 1);
		var height:Int=(mode == 'height' ? size : 1);
		/*
			//HARDCODED PORQUE EU TENHO CAPACIDADES MENTAIS MUITO LIMITADAS :sun_glasses:
			switch(mode){
				case 'horizontal':
					width = size;
				case 'vertical':
					height = size;
			}
		*/
		result.makeGraphic(width, height, color);
		result.alpha = 0.3;
		result.scrollFactor.set();
		if (mode == 'width' || mode ==null){
			add(new FlxSprite(result.x-1, result.y).makeGraphic(1,1,0xFFffffff));
			add(new FlxSprite(result.x+(result.width+1), result.y).makeGraphic(1,1,0xFFffffff));
		}
		if (mode == 'height'){
			add(new FlxSprite(result.x, result.y-1).makeGraphic(1,1,0xFFffffff));
			add(new FlxSprite(result.x, result.y+result.height).makeGraphic(1,1,0xFFffffff));
		}
		return result;
	}
}