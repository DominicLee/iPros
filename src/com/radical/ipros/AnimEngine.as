package com.radical.ipros 
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class AnimEngine 
	{
		
		private static var configXML:XML;
		private static var AnimQueue:Array;
		private static var animPosition:Number = -1; // Start at -1
		
		public function AnimEngine() 
		{
			
		}
		
		public static function init() {
			AnimQueue = new Array();
			MonsterDebugger.trace("Anim", "Initialising Animation");
		}
		
		public static function addAnimToQueue(_clip:MovieClip) {
			trace("Adding " + _clip.name + " to the queue");
			AnimQueue.push(_clip);
		}
		
		public static function stepForward() {
			if (animPosition < AnimQueue.length-1) {
				animPosition++;
				trace("Showing anim " + AnimQueue[animPosition]);
				var _return:String = AnimQueue[animPosition].activate();
				if (_return == "go") {
					Tweener.addTween(AnimEngine,{time:0.2, onComplete: stepForward});
				} else if (_return == "pause") {
					Tweener.addTween(AnimEngine,{time:1, onComplete: stepForward});
				}
			}
		}
		
		public static function stepBackward() {
			if (animPosition>-1) {
				AnimQueue[animPosition].deactivate();
				trace("Removing anim " + AnimQueue[animPosition]);
				animPosition--;
			}
			
		}
		
	}

}