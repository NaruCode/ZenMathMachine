package modes;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Multiplication extends BaseMode {
	
	override function getOperator():String {
		return "*";
	}
	
	override private function getOperands():Array<Int> {
		answer = 1;
		
		var ret:Array<Int> = [];
		for (i in 0...getCount()) {
			var operand:Int = getOperand(i);
			ret.push(operand);
			answer *= operand;
		}
		return ret;
	}
	
	private function getCount():Int {
		if (Reg.difficulty == 0)
			return 2;
		else if (Reg.difficulty == 1)
			return 2;
		else if (Reg.difficulty == 2)
			return 2;
		else if (Reg.difficulty == 3)
			return 2;
		else
			return 2;
	}
	
	private function getOperand(Count:Int):Int {
		var weights:Array<Float> = [];
		if (Reg.difficulty == 0)
			weights = [100];
		else if (Reg.difficulty == 1)
			weights = [0, 100];
		else if (Reg.difficulty == 2)
			weights = [0, 100];
		else if (Reg.difficulty == 3)
			weights = [0, 0, 100];
		else
			weights = [10, 60, 15, 15];
		
		var digits:Float = FlxG.random.getObject(weights) + 1;
		if (Count > 0) {
			if (Reg.difficulty == 4)
				digits = 2;
			else
				digits = 1;
		}
		
		if (digits == 1)
			return FlxG.random.int(2, 9);
		else if (digits == 2)
			return FlxG.random.int(10, 99);
		else if (digits == 3)
			return FlxG.random.int(100, 999);
		else if (digits == 4)
			return FlxG.random.int(1000, 9999);
		else
			return FlxG.random.int(10000, 99999);
	}
}