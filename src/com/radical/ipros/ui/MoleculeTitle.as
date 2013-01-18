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
	public class MoleculeTitle extends MovieClip
	{

		private var originalX:Number = this.x;
		
		public function MoleculeTitle() 
		{
			this.alpha = 0;
			this.x = this.x - 100;
		}
		
		public function activate():String {
			Tweener.addTween(this, { x:originalX, alpha:1, time:0.5, transition:"easeOutQuad" } );
			return "go";
		}
		
		public function deactivate() {
			Tweener.addTween(this, { x:originalX - 100, alpha:0, time:0.5, transition:"easeOutQuad" } );
		}
	}

}