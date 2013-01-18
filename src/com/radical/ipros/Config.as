package com.radical.ipros 
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.radical.ipros.ui.DNAData;
	import com.radical.ipros.ui.KPIData;
	import com.radical.ipros.ui.TargetKPIData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.xml.XMLNode;
	import com.radical.ipros.ui.WhiteBlock;
	import com.radical.ipros.utils.CustomEvents;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Config
	{
		
		public static var configXML:XML;
		public static var moduleList:Array;
		public static var logo:File;
		public static var clientName:String;
		public static var showPainPoints:Boolean = false;
		public static var showFramework:Boolean = false;
		public static var kpiList:Array;
		public static var targetList:Array;
		public static var KPIActive:Boolean = true;
		public static var TargetsActive:Boolean = true;
		
		
		private static var loopCounter:*;
		
		public function Config() 
		{
			
		}
		
		public static function init(_xml:XML) {
			configXML = _xml;
			// parse client XML
			clientName = configXML.client.@clientname;
			logo = File.documentsDirectory.resolvePath("Source2Sale/"+configXML.client.@clientlogo);
			CustomEvents.customEvent("LOGO_READY");
			
			// parse module XML
			moduleList = new Array();
			var moduleXML:XMLList = configXML.modules..mod;
			for (loopCounter in moduleXML) {
				var _dnaData:DNAData = new DNAData(moduleXML[loopCounter]);
				moduleList[loopCounter] = _dnaData;
			}
			
			configXML.kpis.@active == "true" ? KPIActive = true : KPIActive = false;
			kpiList = new Array();
			var kpiXML:XMLList = configXML.kpis..kpi;
			for (loopCounter in kpiXML) {
				var _kpiData:KPIData = new KPIData(kpiXML[loopCounter]);
				kpiList[loopCounter] = _kpiData;
			}
			
			CustomEvents.customEvent("MODULES_READY");
			
			configXML.targets.@active == "true" ? TargetsActive = true : TargetsActive = false;
			targetList = new Array();
			var targetXML:XMLList = configXML.targets..target;
			for (loopCounter in targetXML) {
				var _targetData:TargetKPIData = new TargetKPIData(targetXML[loopCounter]);
				targetList[loopCounter] = _targetData;
			}
			CustomEvents.customEvent("TARGETS_READY");
		}
		
	}

}