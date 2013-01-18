package com.radical.ipros.cms 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.radical.ipros.ui.KPIData;
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class CMSKPI extends MovieClip
	{
		
		
		
		public function CMSKPI() 
		{
			
		}
		
		public function setState(_kpi:KPIData) {
			Label.text = _kpi.label;
			Value.text = _kpi.value;
			Units.text = _kpi.units;
			Additional.text = _kpi.additional;
		}
		
		public function getState():XML {
			var _retXML:XML = <kpi/>;
			_retXML.@label = Label.text;
			_retXML.@value = Value.text;
			_retXML.@units = Units.text;
			_retXML.@additional = Additional.text;
			return _retXML;
		}
		
	}

}