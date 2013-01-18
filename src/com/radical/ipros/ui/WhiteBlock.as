package com.radical.ipros.ui 
{
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import com.radical.ipros.AnimEngine;
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class WhiteBlock extends MovieClip
	{

		
		public function WhiteBlock() 
		{
			
		}
		
		public function init() {
			AnimEngine.addAnimToQueue(this);
			
		}
		
		public function activate() {
			Tweener.addTween(this, { y:125, time:1, transition:"easeOutQuad" } );
		}
		
		public function deactivate() {
			Tweener.addTween(this, { y:727, time:1, transition:"easeOutQuad" } );
		}
	}

}