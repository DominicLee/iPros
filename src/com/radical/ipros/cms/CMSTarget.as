package com.radical.ipros.cms 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.radical.ipros.ui.TargetKPIData;
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class CMSTarget extends MovieClip
	{
		
		public function CMSTarget() 
		{
			
		}
		
		public function setState(_kpi:TargetKPIData) {
			InitialLabel.text = _kpi.initialLabel;
			InitialValue.text = _kpi.initialValue.toString();
			InitialUnits.text = _kpi.initialUnits;
			TargetLabel.text = _kpi.targetLabel;
			TargetValue.text = _kpi.targetValue.toString();
			TargetUnits.text = _kpi.targetUnits;			
			Additional.text = _kpi.additional;
		}
		
		public function getState():XML {
			var _retXML:XML = <target/>;
			_retXML.@initiallabel = InitialLabel.text;
			_retXML.@initialvalue = InitialValue.text;
			_retXML.@initialunits = InitialUnits.text;
			_retXML.@targetlabel = TargetLabel.text;
			_retXML.@targetvalue = TargetValue.text;
			_retXML.@targetunits = TargetUnits.text;
			_retXML.@additional = Additional.text;
			return _retXML;
		}
		
	}

}