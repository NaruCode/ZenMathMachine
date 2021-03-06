package ents;
import ents.KeyPad.Key;
import ents.NumText.NumTextChar;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * @author Ohmnivore
 * Port by NaxeCode
 */
class KeyPad extends FlxTypedGroup<Key> {
	
	public var x:Float;
	public var y:Float;
	public var onKey:String->Void;
	
	private var drawHack:Bool = false;
	
	public function new(X:Float, Y:Float) {
		super();
		
		x = X;
		y = Y;
		addKeys();
	}
	
	private function addKeys():Void {
		add(new Key(this, 0, 0, "0"));
		add(new Key(this, 80, 0, "1"));
		add(new Key(this, 160, 0, "2"));
		add(new Key(this, 240, 0, "3"));
		add(new Key(this, 0, 80, "4"));
		add(new Key(this, 80, 80, "5"));
		add(new Key(this, 160, 80, "6"));
		add(new Key(this, 240, 80, "7"));
		add(new Key(this, 0, 160, "8"));
		add(new Key(this, 80, 160, "9"));
		add(new Key(this, 160, 160, "-"));
		add(new Key(this, 240, 160, "*"));
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		for (i in 0...members.length) {
			var key:Key = members[i];
			key.x = x + key.offsetx;
			key.y = y + key.offsety;
		}
	}
	
	override public function draw():Void {
		if (!drawHack) {
			drawHack = true;
			return;
		}
		super.draw();
	}
}

class Key extends FlxTypedGroup<FlxSprite> {
	
	public var x:Float;
	public var y:Float;
	public var offsetx:Float;
	public var offsety:Float;
	
	public var bg:FlxSprite;
	public var char:NumTextChar;
	public var pad:KeyPad;
	
	private var bgTween:FlxTween;
	private var charTween:FlxTween;
	private var tweenPressedDone:Bool = false;
	
	public function new(Pad:KeyPad, OffsetX:Float, OffsetY:Float, Char:String) {
		super();
		
		pad = Pad;
		x = 0;
		y = 0;
		offsetx = OffsetX;
		offsety = OffsetY;
		
		bg = new FlxSprite();
		bg.makeGraphic(80 - Reg.margin * 2, 80 - Reg.margin * 2, 0xffffffff);
		add(bg);
		
		char = new NumTextChar(Char);
		add(char);
		
		bg.color = Reg.color.bg2;
		char.color = Reg.color.num;
	}
	
	private function onTweenPressed(T:FlxTween):Void {
		tweenPressedDone = true;
	}
	private function onTweenReleased(T:FlxTween):Void {
		tweenPressedDone = false;
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		bg.x = x + Reg.margin;
		bg.y = y + Reg.margin;
		
		char.x = bg.x + (bg.width - Reg.fSize) / 2;
		char.y = bg.y + (bg.height - Reg.fSize) / 2;
		
		if (FlxG.mouse.pressed && bg.overlapsPoint(FlxG.mouse.getWorldPosition())) {
			bg.color = Reg.color.bg;
			char.color = Reg.color.op;
			tweenPressedDone = true;
		}
		else if (FlxG.mouse.justReleased && pad.onKey != null && bg.overlapsPoint(FlxG.mouse.getWorldPosition())) {
			pad.onKey(char.char);
		}
		else {
			if (tweenPressedDone && (bgTween == null || bgTween.finished))
				bgTween = FlxTween.color(bg, 0.33, bg.color, Reg.color.bg2,
					{ type: FlxTween.PINGPONG, ease: FlxEase.cubeOut, onComplete: onTweenReleased});
			if (tweenPressedDone && (charTween == null || charTween.finished))
				charTween = FlxTween.color(char, 0.33, char.color, Reg.color.num,
					{ type: FlxTween.PINGPONG, ease: FlxEase.cubeOut, onComplete: onTweenReleased});
		}
	}
}