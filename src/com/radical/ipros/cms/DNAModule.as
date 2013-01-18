package com.radical.ipros.cms 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.radical.ipros.ui.DNAData;
	
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class DNAModule extends MovieClip
	{
		
		private var title:String = "DUMMY TITLE";
		private var labelStart:String = "bottom";
		
		public function DNAModule() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		private function init(e:Event) {
			
		}
		
		public function getState():XML {
			var _retXML:XML = <mod/>;
			_retXML.@title = title;
			_retXML.@labelstart = labelStart;
			for (var xx = 1; xx < 8; xx++) {
				var _dataXML:XML = <dna/>
				var _checkbox1 = this.getChildByName("Active" + xx);
				_dataXML.@visible = _checkbox1.selected;
				var _field = this.getChildByName("Field" + xx);
				_dataXML.@title = _field.text;
				var _checkbox2 = this.getChildByName("Pain" + xx);
				_dataXML.@painpoint = _checkbox2.selected;
				_retXML.appendChild(_dataXML);
			}
			return _retXML;
		}
		
		public function setState(_dnaData:DNAData) {
			title = _dnaData.title;
			labelStart = _dnaData.labelLocation;
			for (var yy = 1; yy < 8; yy++) {
				var _checkbox1 = this.getChildByName("Active" + yy);
				_dnaData.dnaList[yy-1].isVisible =="true" ? _checkbox1.selected = true : _checkbox1.selected = false;
				var _field = this.getChildByName("Field" + yy);
				_field.text = _dnaData.dnaList[yy-1].title;
				var _checkbox2 = this.getChildByName("Pain" + yy);
				_dnaData.dnaList[yy-1].painpoint =="true" ? _checkbox2.selected = true : _checkbox2.selected = false;
			}
		}
		
	}

}