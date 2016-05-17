package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		
		Reg.light = new ents.ColorPalette(0xfffdf6e3, 0xffeee8d5, 0xff93a1a1, 0xffcb4b16, 0xffd33682, 0xff2aa198);
		Reg.dark = new ents.ColorPalette(0xff073642, 0xff002b36, 0xff93a1a1, 0xffb58900, 0xffdc322f, 0xff2aa198);
		
		addChild(new FlxGame(320, 480, MenuState, 1, 60, 60, true));
	}
}