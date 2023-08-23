package android;

import flixel.FlxG;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;
import flixel.ui.FlxButton;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.display.BitmapData;
import flixel.graphics.FlxGraphic;
import openfl.utils.ByteArray;

class SonicVPad extends FlxSpriteGroup
{
	//base pad
	var base:Array<Dynamic> = [
		{
			tag: "base",
			region: FlxPoint.get(0, 0),
			size: FlxPoint.get(35, 37)
		},
		{
			tag: "base-completlyPressed",
			region: FlxPoint.get(35, 0),
			size: FlxPoint.get(35, 37)
		},
	];

	//directional buttons
	var dpadS:Array<Dynamic> = [
		//left
		{
			tag: "leftNormal",
			region: FlxPoint.get(70, 12),
			size: FlxPoint.get(12, 5)
		},
		{
			tag: "leftCheck",
			region: FlxPoint.get(70, 0),
			size: FlxPoint.get(12, 5)
		},
		//right
		{
			tag: "rightNormal",
			region: FlxPoint.get(87, 12),
			size: FlxPoint.get(12, 5)
		},
		{
			tag: "rightCheck",
			region: FlxPoint.get(87, 0),
			size: FlxPoint.get(12, 5)
		},
		//down
		{
			tag: "downNormal",
			region: FlxPoint.get(82, 12),
			size: FlxPoint.get(5, 12)
		},
		{
			tag: "downCheck",
			region: FlxPoint.get(82, 0),
			size: FlxPoint.get(5, 12)
		},
		//up
		{
			tag: "upNormal",
			region: FlxPoint.get(99, 12),
			size: FlxPoint.get(5, 12)
		},
		{
			tag: "upCheck",
			region: FlxPoint.get(99, 0),
			size: FlxPoint.get(5, 12)
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

		dPad.add(add(buttonJump = createButton()));
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

	public function createButton(X:Float, Y:Float, Width:Int, Height:Int, Graphic:String, ?OnClick:Void->Void):FlxButton
	{
		var button = new FlxButton(X, Y);
		for (anim in buttons)
		{
			frames = FlxTileFrames.findFrame();
		}
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
		button.scrollFactor.set();

		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end

		if (OnClick != null)
			button.onDown.callback = OnClick;

		return button;
	}

	public static function getVirtualInputFrames():FlxAtlasFrames
	{
		#if !web
		var bitmapData = new GraphicVirtualInput(0, 0);
		#end
			
		#if !web
		var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmapData);
		return FlxAtlasFrames.fromSpriteSheetPacker(graphic, Std.string(new VirtualInputData()));
		#else
		var graphic:FlxGraphic = FlxGraphic.fromAssetKey(Paths.image('sonicVPAD'));
		return FlxAtlasFrames.fromSpriteSheetPacker(graphic, Std.string(new VirtualInputData()));
		#end
	}
}

@:keep @:bitmap("assets/android/sonicVPAD.png")
class GraphicVirtualInput extends BitmapData {}