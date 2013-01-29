package com.radical.ipros
{
	import flash.desktop.InteractiveIcon;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.radical.ipros.CommsEngine;
	import com.radical.ipros.utils.CustomEvents;
	import com.radical.ipros.Config;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class CMSMain extends MovieClip
	{
		private var loopCounter:int = 0;
		
		public function CMSMain():void
		{
			MonsterDebugger.initialize(this);
			CustomEvents.addEventListener("MODULES_READY", applyModules);
			CustomEvents.addEventListener("LOGO_READY", loadClientLogo);
			CustomEvents.addEventListener("TARGETS_READY", applyTargets);
			LoadBtn.addEventListener(MouseEvent.CLICK, loadConfig);
			SaveBtn.addEventListener(MouseEvent.CLICK, saveConfig);
			PublishBtn.addEventListener(MouseEvent.CLICK, publish);
			KPIActive.addEventListener(Event.CHANGE, toggleKPIs);
			TargetsActive.addEventListener(Event.CHANGE, toggleKPIs);
			
			CommsEngine.init(this);
		}
		
		private function loadClientLogo(e:Event)
		{
			var _clientDetails:MovieClip = getChildByName("ClientDetailsClip") as MovieClip;
			_clientDetails.setState(Config.clientName, Config.logo);
		
		}
		
		private function applyModules(e:Event)
		{
			for (var xx = 1; xx < 4; xx++)
			{
				var _module = getChildByName("DNA" + xx) as MovieClip;
				_module.setState(Config.moduleList[xx - 1]);
			}
			
			for (var yy = 1; yy < 4; yy++)
			{
				var _kpi = getChildByName("KPI" + yy) as MovieClip;
				_kpi.setState(Config.kpiList[yy - 1]);
				if (!Config.KPIActive) {
					KPIActive.selected = false;
					_kpi.alpha = 0.3;
				} else {
					KPIActive.selected = true;
					_kpi.alpha = 1;
				}
			}
		}
		
		private function applyTargets(e:Event)
		{
			for (var zz = 1; zz < 4; zz++)
			{
				var _kpi = getChildByName("Target" + zz) as MovieClip;
				_kpi.setState(Config.targetList[zz - 1]);
				if (!Config.TargetsActive) {
					TargetsActive.selected = false;
					_kpi.alpha = 0.3;
				} else {
					TargetsActive.selected = true;
					_kpi.alpha = 1;
				}
			}
		}
		
		private function loadConfig(e:Event) {
			CommsEngine.getConfigFromFile();
		}
		
		private function saveConfig(e:Event) {
			CommsEngine.saveConfigToFile();
		}
		
		private function publish(e:MouseEvent)
		{
			CommsEngine.putConfig();
		}
		
		public function buildXML():XML {
			var _counter:Number = 0;
			var _target:MovieClip;
			var _retXML:XML =  <root/>
			ClientDetailsClip.publish();
			_retXML.appendChild(ClientDetailsClip.getState());
			_retXML.appendChild(<modules/>);
			for (_counter = 1; _counter < 4; _counter++)
			{
				_target = getChildByName("DNA" + _counter) as MovieClip;
				_retXML.modules.appendChild(_target.getState());
			}
			
			_retXML.appendChild(<kpis/>);
			KPIActive.selected ? _retXML.kpis.@active = "true" : _retXML.kpis.@active = "false";
			for (_counter = 1; _counter < 4; _counter++)
			{
				_target = getChildByName("KPI" + _counter) as MovieClip;
				_retXML.kpis.appendChild(_target.getState());
			}
			
			_retXML.appendChild(<targets/>);
			TargetsActive.selected ? _retXML.targets.@active = "true" : _retXML.targets.@active = "false";
			for (_counter = 1; _counter < 4; _counter++)
			{
				_target = getChildByName("Target" + _counter) as MovieClip;
				_retXML.targets.appendChild(_target.getState());
			}
			//trace(_retXML);
			return _retXML;
		}
		
		private function toggleKPIs(e:Event)
		{
			var _prefix:String = "";
			e.target.name == "KPIActive" ? _prefix = "KPI" : _prefix = "Target";
			var _targetAlpha:Number = 0;
			e.target.selected ? _targetAlpha = 1 : _targetAlpha = 0.3;
			for (loopCounter = 1; loopCounter < 4; loopCounter++)
			{
				var _target:MovieClip = this.getChildByName(_prefix + loopCounter) as MovieClip;
				Tweener.addTween(_target, {alpha: _targetAlpha, time: 0.5, transition: "linear"});
			}
		}
	}

}