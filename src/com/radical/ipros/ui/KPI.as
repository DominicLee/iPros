package com.radical.ipros.ui 
{
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import com.radical.ipros.ui.KPIData;
	import flash.text.TextFieldAutoSize;
	import com.radical.ipros.AnimEngine;
	
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class KPI extends MovieClip
	{

		
		public function KPI() 
		{
			this.alpha = 0;
			Field1.alpha = 0;
			Field2.alpha = 0;
			Field3.alpha = 0;
		}
		
		public function init(_kpiData:KPIData) {
			if (_kpiData.label) {
				this.Field1.text = _kpiData.label;
				this.Field2.text = _kpiData.value + " " + _kpiData.units;
				this.Field3.text = _kpiData.additional;
				
				AnimEngine.addAnimToQueue(this);
			}
		}
		
		public function activate() {
			Tweener.addTween(this, { alpha:1, time:1, transition:"linear" } );
			Tweener.addTween(Field1, { x:Field1.x + 100, alpha:1, time:0.3, transition: "easeOutBack" } );
			Tweener.addTween(Field2, { x:Field2.x + 100, alpha:1, time:0.3, delay: 0.3, transition: "easeOutBack" } );
			Tweener.addTween(Field3, { x:Field3.x + 100, alpha:1, time:0.3, delay: 0.6, transition: "easeOutBack" } );
			return "go";
		}
		
		public function deactivate() {
			Tweener.addTween(this, { alpha:0, time:1, transition:"linear" } );
			Tweener.addTween(Field1, { x:Field1.x - 100, alpha:0, time:0.3, transition: "easeOutBack" } );
			Tweener.addTween(Field2, { x:Field2.x - 100, alpha:0, time:0.3, delay: 0.3, transition: "easeOutBack" } );
			Tweener.addTween(Field3, { x:Field3.x - 100, alpha:0, time:0.3, delay: 0.6, transition: "easeOutBack" } );
		}
	}

}