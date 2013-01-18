package com.radical.ipros.ui
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.text.TextFieldAutoSize;
	import com.demonsters.debugger.MonsterDebugger;
	import caurina.transitions.properties.ColorShortcuts;
	import flash.filters.ColorMatrixFilter;
	import fl.motion.AdjustColor;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Molecule extends MovieClip
	{
		
		public var isPain:Boolean = false;
		public var labelLocation:String;
		public var label:String;
		private var originalHeight:Number = 0;
		private var activated:Boolean = false;
		private var theLabel:MovieClip = new MovieClip();
		private var state:String = "inactive";
		
		private var colorFilter:AdjustColor = new AdjustColor();
		private var mColorMatrix:ColorMatrixFilter;
		private var mMatrix:Array = [];
		
		public function Molecule()
		{
			ColorShortcuts.init();
			originalHeight = this.height;
			this.scaleY = 0.2;
			this.alpha = 0;
		}
		
		public function init(_data:Object)
		{

			if (_data.isVisible=="true")
			{
				if (_data.painpoint == "true") {
					isPain = true;
				}
				labelLocation = _data.labelLocation;
				label = _data.title;

				if (labelLocation == "top")
				{
					theLabel = new LabelBottom();
					theLabel.y = 0 - originalHeight / 2;
					//theLabel.LabelText.y = -50 - theLabel.LabelText.height;
				}
				else
				{
					theLabel = new LabelTop();
					theLabel.y = originalHeight / 2;
				}
				//theLabel.LabelText.autoSize = TextFieldAutoSize.CENTER;
				theLabel.LabelText.text = label;
				
				this.addChild(theLabel);
			}
		}
		
		public function activate():String
		{
			if (state!=="active") {
				Tweener.addTween(this, { scaleY: 1, alpha: 1, time: 0.3, transition: "EaseOutBack" } );
				state = "active";
				return "go";
			} else {
				Tweener.addTween(this, { scaleX:1.05, scaleY:1.05, time:0.5, transition:"EaseOutBack"} );
				Tweener.addTween(this.Mole, { _hue: -60, time:0.5, transition:"linear", overwrite: false } );
				Tweener.addTween(theLabel, { _color: 0xF58437, time:0.5, transition:"linear" } );
				state = "pain";
				return "hold";
			}
		}
		
		public function deactivate()
		{
			if (state=="active") {
				Tweener.addTween(this, { scaleY: 0.2, alpha: 0, time: 0.2, transition: "EaseInBack" } );
				state = "inactive";
			} else if (state=="pain") {
				Tweener.addTween(this.Mole, { _hue: 0, time:0.5, transition:"linear" } );
				Tweener.addTween(theLabel, { _color: 0x505E68, time:0.5, transition:"linear" } );
				Tweener.addTween(this, { scaleX:1, scaleY:1, time:0.5, transition:"EaseOutBack" } );
				state = "active";
			}
		}
		
	}

}