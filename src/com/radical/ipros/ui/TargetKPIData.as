package com.radical.ipros.ui 
{
	
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class TargetKPIData 
	{
		
		public var initialLabel:String;
		public var targetLabel:String;
		public var initialValue:Number;
		public var targetValue:Number;
		public var initialUnits:String;
		public var targetUnits:String;
		public var additional:String;
		
		public function TargetKPIData(_xml:XML) 
		{
			initialLabel = _xml.@initiallabel;
			targetLabel = _xml.@targetlabel;
			initialValue = _xml.@initialvalue;
			targetValue = _xml.@targetvalue;
			initialUnits = _xml.@initialunits;
			targetUnits = _xml.@targetunits;
			additional = _xml.@additional;
		}
	}

}