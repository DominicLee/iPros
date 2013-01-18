package com.radical.ipros.ui
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import com.radical.ipros.AnimEngine;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	import com.radical.ipros.utils.CustomEvents;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class GreenBlock extends MovieClip
	{
		
		public function GreenBlock()
		{
			Block.scaleY = 0.2;
			Block.alpha = 0;
			TargetValue.alpha = 0;
			Additional.alpha = 0;
			Additional.y = Additional.y +50;
		}
		
		public function setText(_target:String, _additional:String) {
			TargetValue.text = _target;
			Additional.text = _additional;
		}
		
		public function activate()
		{
			Tweener.addTween(Block, { scaleY:1, alpha: 1, time: 0.3, transition: "EaseOutBack" } );
			Tweener.addTween(TargetValue, { alpha:1, time:0.5, transition:"linear" } );
			Tweener.addTween(Additional, { alpha:1, y:Additional.y - 50, time:0.5, transition:"EaseOutBack" } );
			this.dispatchEvent(new Event("SHOWING_TARGET"));
		}
		
		public function deactivate()
		{
			Tweener.addTween(Block, { scaleY: 0.2, alpha: 0, time: 0.2, transition: "EaseInBack" } );
			Tweener.addTween(TargetValue, { alpha:0, time:0.5, transition:"linear" } );
			Tweener.addTween(Additional, { alpha:0, y:Additional.y + 50, time:0.5, transition:"EaseInBack" } );
			this.dispatchEvent(new Event("SHOWING_CURRENT"));
		}
	
	}

}