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

class SonicVPad extends FlxSpriteGroup
{
	//base pad
	var base:Array<Dynamic> = [
		{
			tag: "base",
			region: FlxRect.get(0, 0),
			size: FlxPoint.get(35, 37)
		},
		{
			tag: "base-completlyPressed",
			region: FlxRect.get(35, 0),
			size: FlxPoint.get(35, 37)
		},
	];

	//directional buttons
	var dpadS:Array<Dynamic> = [
		//left
		{
			tag: "leftNormal",
			region: FlxRect.get(70, 12),
			size: FlxPoint.get(12, 5)
		},
		{
			tag: "leftCheck",
			region: FlxRect.get(70, 0),
			size: FlxPoint.get(12, 5)
		},
		//right
		{
			tag: "rightNormal",
			region: FlxRect.get(87, 12),
			size: FlxPoint.get(12, 5)
		},
		{
			tag: "rightCheck",
			region: FlxRect.get(87, 0),
			size: FlxPoint.get(12, 5)
		},
		//down
		{
			tag: "downNormal",
			region: FlxRect.get(82, 12),
			size: FlxPoint.get(5, 12)
		},
		{
			tag: "downCheck",
			region: FlxRect.get(82, 0),
			size: FlxPoint.get(5, 12)
		},
		//up
		{
			tag: "upNormal",
			region: FlxRect.get(99, 12),
			size: FlxPoint.get(5, 12)
		},
		{
			tag: "upCheck",
			region: FlxRect.get(99, 0),
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
			var bitmapData = new GraphicVirtualInput(0, 0);
			button.frames = FlxTileFrames.fromGraphic(FlxGraphic.fromBitmapData(bitmapData), anim.size, anim.region);
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
}

@:keep @:bitmap("assets/android/sonicVPAD.png")
class GraphicVirtualInput extends BitmapData {}