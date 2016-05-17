package;

import ents.MenuKeyPad;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import modes.Addition;
import modes.Division;
import modes.Multiplication;
import modes.Substraction;

class MenuState extends FlxState {
	
	private var skipintro:Bool;
	private var keypad:MenuKeyPad;
	
	public function new(SkipIntro:Bool = false):Void {
		skipintro = SkipIntro;
		super();
	}
	override public function create():Void {
		super.create();
		Reg.loadPalette(); // Loads palette from Reg.
		Reg.loadDifficulty(); // Loads difficulty from Reg.
		#if debug
		Reg.initDebug(); // Sets up earased command if in debug mode.
		#end //ChallengeCounter.init();
		
		FlxG.camera.bgColor = Reg.color.bg; // Set background color from Reg.
		FlxG.scaleMode = new PixelPerfectScaleMode(); // Set scale mode to pixel perfect.
		FlxG.mouse.load("assets/images/cursor.png", 1); // Load mouse cursor graphic.
		
		keypad = new MenuKeyPad(0, 0);
		add(keypad);
		keypad.onKey = onKey;
		
		if (skipintro) keypad.y = 40;
		else {
			keypad.y = FlxG.height;
			FlxTween.tween(keypad, {"y": 40}, 0.7, {ease: FlxEase.elasticOut});
		}
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		keypad.setDifficulty(Reg.difficulty);
	}
	
	private function onKey(Char:String):Void {
		if (Char == "+") {
			Reg.mode = Addition;
			openChallenge();
		} else if (Char == "-") {
			Reg.mode = Substraction;
			openChallenge();
		} else if (Char == "*") {
			Reg.mode = Multiplication;
			openChallenge();
		} else if (Char == "/") {
			Reg.mode = Division;
			openChallenge();
		} else if (Char == "%") {
			Reg.isDark = !Reg.isDark;
			Reg.savePalette();
			FlxG.switchState(new MenuState(true));
		} else if (Char == "[" || Char == "]" || Char == "{" || Char == "}" || Char == "(") 
			Reg.addDifficulty();
		else if (Char == "@") FlxG.openURL("https://twitter.com/4_AM_Games");
	}
	
	private function openChallenge():Void {
		for (m in members) {
			untyped FlxTween.tween(m, { y: m.y - 440 }, 0.3, { type: FlxTween.PINGPONG, ease: FlxEase.backIn, onComplete: 
				function(T:FlxTween) {
					FlxTween.manager.clear();
					FlxG.switchState(new PlayState());
				}
			});
		}
	}
}
