package com.radical.ipros.ui
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.text.TextFieldAutoSize;
	import com.radical.ipros.AnimEngine;
	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class OrangeBlock extends MovieClip
	{
		
		private var endHeight:Number;
		
		public function OrangeBlock()
		{
			Block.scaleY = 0.2;
			Block.alpha = 0;
			InitialValue.alpha = 0;
		}
		
		public function setHeight(_height:Number)
		{
			endHeight = _height;
		}
		
		public function setText(_label:String) {
			InitialValue.text = _label;
			InitialValue.y = 0 - (endHeight -10);
		}
		
		public function activate()
		{
			Tweener.addTween(Block, { height: endHeight, alpha: 1, time: 0.3, transition: "EaseOutBack" } );
			Tweener.addTween(InitialValue, { alpha:1, time:0.5, transition:"linear" } );
			this.dispatchEvent(new Event("SHOW_LABEL"));
		}
		
		public function deactivate()
		{
			Tweener.addTween(Block, { height: 1, alpha: 0, time: 0.2, transition: "EaseInBack" } );
			Tweener.addTween(InitialValue, { alpha:0, time:0.5, transition:"linear" } );
			this.dispatchEvent(new Event("HIDE_LABEL"));
		}
	
	}

}