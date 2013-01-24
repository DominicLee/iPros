package com.radical.ipros.ui
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import com.demonsters.debugger.MonsterDebugger;
	import com.radical.ipros.ui.TargetKPIData;
	import com.radical.ipros.AnimEngine;
	import com.radical.ipros.utils.CustomEvents;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class TargetBar extends MovieClip
	{
		
		private var initialValue:Number;
		private var targetValue:Number;
		private var initialText:String;
		private var targetText:String;
		
		public function TargetBar()
		{
			originalHeight = this.height;
			this.scaleY = 0.2;
			this.alpha = 0;
		}
		
		public function init(_kpi:TargetKPIData)
		{
			
			initialText = _kpi.initialLabel + "\n" + formatNumber(_kpi.initialValue) + " " + _kpi.initialUnits;
			targetText = _kpi.targetLabel + "\n" + formatNumber(_kpi.targetValue) + " " + _kpi.targetUnits;
			
			Label.text = initialText;
			Label.alpha = 0;
			
			var _percent:Number = (_kpi.initialValue / _kpi.targetValue) * 100;
			var initialHeight = _percent * 3.23;

			this.InitialValueBlock.setHeight(initialHeight);
			this.InitialValueBlock.setText(formatNumber(_kpi.initialValue) + " " + _kpi.initialUnits.toUpperCase());
			this.TargetValueBlock.setText(formatNumber(_kpi.targetValue) + " " + _kpi.targetUnits.toUpperCase(), _kpi.additional);

			AnimEngine.addAnimToQueue(this);
			AnimEngine.addAnimToQueue(this.InitialValueBlock);
			AnimEngine.addAnimToQueue(this.TargetValueBlock);
			
			TargetValueBlock.addEventListener("SHOWING_TARGET", changeText, false, 0, true);
			TargetValueBlock.addEventListener("SHOWING_CURRENT", changeTextBack, false, 0, true);
			
			InitialValueBlock.addEventListener("SHOW_LABEL", showLabel, false, 0, true);
			InitialValueBlock.addEventListener("HIDE_LABEL", hideLabel, false, 0, true);
		}
		
		private function changeText(e:Event) {
			Label.text = targetText;
		}
		
		private function changeTextBack(e:Event) {
			Label.text = initialText;
		}
		
		private function showLabel(e:Event) {
			Tweener.addTween(Label, { alpha:1, time:0.5, transition:"linear" } );
		}
		
		private function hideLabel(e:Event) {
			Tweener.addTween(Label, { alpha:0, time:0.5, transition:"linear" } );
		}
		
		private function formatNumber(number:Number):String
		{
			var numString:String = number.toString()
			
			if (number>1000) {

				var result:String = ''

				while (numString.length > 3)
				{
					var chunk:String = numString.substr(-3)
					numString = numString.substr(0, numString.length - 3)
					result = ',' + chunk + result
				}

				if (numString.length > 0)
				{
					result = numString + result
				}

				return result 
			
			} else {
				return numString
			}
		}
		
		public function activate()
		{
			Tweener.addTween(this, {scaleY: 1, alpha: 1, time: 0.3, transition: "EaseOutBack"});
		}
		
		public function deactivate()
		{
			Tweener.addTween(this, {scaleY: 0.2, alpha: 0, time: 0.3, transition: "EaseInBack"});
		}
	
	}

}