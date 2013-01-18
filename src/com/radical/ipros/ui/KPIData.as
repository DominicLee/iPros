package com.radical.ipros.ui 
{
	
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class KPIData 
	{
		
		public var label:String;
		public var value:String;
		public var units:String;
		public var additional:String;
		
		public function KPIData(_xml:XML) 
		{
			label = _xml.@label;
			value = _xml.@value;
			units = _xml.@units;
			additional = _xml.@additional;
		}
		
	}

}