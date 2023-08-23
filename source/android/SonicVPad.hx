package android;

import flixel.FlxG;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxDestroyUtil;
import flixel.ui.FlxButton;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.display.BitmapData;
import flixel.graphics.FlxGraphic;
import openfl.utils.ByteArray;
import openfl.geom.Rectangle;

typedef SpriteSheetStruct = {
	var name:String;
	var x:Float;
	var y:Float;
	var w:Float,
	var h:Float,
}
class SonicVPad extends FlxSpriteGroup
{
	//base pad - 3.94
	//directional buttons
	var spriteSheet:Array<SpriteSheetStruct> = [
		///////////////////
		{
			name: "base",
			x: 0,
			y: 0,
			w: 35, 
			h: 37
		},
		{
			name: "baseCheck",
			x: 35,
			y: 0,
			w: 35,
			h: 37
		},
		///////////////
		{
			name: "leftNormal",
			x: 70,
			y: 12,
			w: 12,
			h: 5
		},
		{
			name: "leftCheck",
			x: 70, y: 0,
			w: 12, h: 5
		},
		/////////////
		{
			name: "rightNormal",
			x: 87, y: 12,
			w: 12, h: 5
		},
		{
			name: "rightCheck",
			x: 87, y: 0,
			w: 12, h: 5
		},
		//////////
		{
			name: "downNormal",
			x: 82, y: 12,
			w: 5, h: 12
		},
		{
			name: "downCheck",
			x: 82, y: 0,
			w: 5, h: 12
		},
		/////////////
		{
			name: "upNormal",
			x: 99, y: 12,
			w: 5, h: 12
		},
		{
			name: "upCheck",
			x: 99, y: 0,
			w: 5, h: 12
		},
		//////////
		{
			name: "jumpNormal",
			x: 106, y: 0,
			w: 23, h: 23
		},
		{
			name: "jumpCheck",
			x: 106, y: 24,
			w: 23, h: 23
		},
		/////////////////
		{
			name: "pauseNormal",
			x: 129, y: 0,
			w: 9, h: 8
		},
		{
			name: "pauseCheck",
			x: 129, y: 0,
			w: 9, h: 8
		}
	];
	//actions
	public var actions:FlxSpriteGroup;
	public var buttonJump:FlxButton;
	public var buttonPause:FlxButton;

	//directionals
	public var dPad:FlxSpriteGroup;
	public var buttonLeft:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonDown:FlxButton;

	public function new()
	{
		super();
		scrollFactor.set();

		dPad = new FlxSpriteGroup();
		dPad.scrollFactor.set();

		actions = new FlxSpriteGroup();
		actions.scrollFactor.set();

		dPad.add(add(buttonLeft = createButton(89, FlxG.height - 536, 'left')));
		dPad.add(add(buttonRight = createButton(89, FlxG.height - 536, 'right')));

		dPad.scale.set(3.84, 3.84);
		actions.scale.set(3.84, 3.84);
	}

	override public function destroy():Void
	{
		super.destroy();

		dPad = FlxDestroyUtil.destroy(dPad);
		actions = FlxDestroyUtil.destroy(actions);

		dPad = null;
		actions = null;
		buttonJump = null;
		buttonPause = null;
		buttonLeft = null;
		buttonUp = null;
		buttonDown = null;
		buttonRight = null;
	}

	public function createButton(X:Float, Y:Float, Graphic:String, clickable:Bool = true, ?OnClick:Void->Void):FlxButton
	{
		var button = new FlxButton(X, Y);
		var framesTile:FlxAtlasFrames = FlxAtlasFrames.findFrame(FlxGraphic.fromBitmapData(new GraphicVirtualInput(0, 0)));
		framesTile = new FlxAtlasFrames(FlxGraphic.fromBitmapData(new GraphicVirtualInput(0, 0)));
		for (sprite in spriteSheet)
		{
			var rect:FlxRect = FlxRect.get(sprite.x, sprite.y, sprite.w, sprite.h);
			var sourceSize:FlxPoint = FlxPoint.get(sprite.w, sprite.h); 
			framesTile.addAtlasFrame(rect, sourceSize, FlxPoint.get(0, 0), sprite.name);
		}
		button.frames = framesTile;
		button.animation.play(Graphic + 'Normal');
		button.resetSizeFromFrame();
		button.antialiasing = false;
		button.solid = false;
		button.immovable = true;
		button.scrollFactor.set();

		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end

		button.onDown.callback = OnClick;
		if (onClick == null) {
			if (clickable)
				onClick = function()
				{
					button.animation.play(graphic + 'Check');
				};
		}

		return button;
	}
}

@:keep @:bitmap("assets/android/sonicVPAD.png")
class GraphicVirtualInput extends BitmapData {}