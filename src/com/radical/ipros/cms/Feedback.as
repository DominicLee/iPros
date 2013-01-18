package com.radical.ipros.cms 
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Feedback extends MovieClip
	{
		
		public static var _this:MovieClip;
		
		public function Feedback() 
		{
			_this = this;
			_this.alpha = 0;
		}
		
		public static function showFeedback(_text:String) {
			_this["FeedbackText"].text = _text;
			_this.visible = true;
			Tweener.addTween(_this, { alpha:1, time:0.5, transition:"linear", onComplete: fadeout } );
		}
		
		public static function fadeout() {
			Tweener.addTween(_this, { alpha:0, time:0.5, delay: 2, transition:"linear", onComplete: function() {_this.visible = false} } );
		}
		
	}

}