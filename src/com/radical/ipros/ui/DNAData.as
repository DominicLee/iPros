package com.radical.ipros.ui 
{
	
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class DNAData 
	{
		
		public var title:String;
		public var dnaList:Array = new Array();
		public var labelLocation:String;
		
		public function DNAData(_xml:XML) 
		{
			title = _xml.@title;
			labelLocation = _xml.@labelstart;
			
			var labelToggle:String = labelLocation;
			for (var xx in _xml.dna) {
				
				var _dna:Object = new Object();
				_dna.isVisible = _xml.dna[xx].@visible.toString();
				_dna.title = _xml.dna[xx].@title.toString()
				_dna.painpoint = _xml.dna[xx].@painpoint.toString();
				_dna.labelLocation = labelToggle;
				dnaList[xx] = _dna;
				labelToggle == "top"?labelToggle = "bottom":labelToggle = "top";
			}
		}
		
	}

}