package com.radical.ipros
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.radical.ipros.AnimEngine;
	import com.radical.ipros.CommsEngine;
	import com.radical.ipros.ui.LogoLoaderClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import com.radical.ipros.utils.CustomEvents;
	import com.radical.ipros.ui.LoadAnimation;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Main extends MovieClip 
	{
		
		private var clientLogo:MovieClip;
		private var whiteBlock:MovieClip;
		
		public function Main():void 
		{
			MonsterDebugger.initialize(this);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event) {
			AnimEngine.init();
			CustomEvents.addEventListener("ANIM_LOADED", go);
			CustomEvents.addEventListener("ANIM_OUT", endIntro);
		}
		
		private function go(e:Event) {
			clientLogo = getChildByName("ClientLogoClip") as MovieClip;
			CustomEvents.addEventListener("LOGO_READY", loadClientLogo);
			CustomEvents.addEventListener("MODULES_READY", applyModules);
			CustomEvents.addEventListener("TARGETS_READY", prepTarget);
			CommsEngine.init(this);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, readKeyboard);
		}
		
		private function endIntro(e:Event) {
			this.play();
		}
		
		private function loadClientLogo(e:Event) {
			CustomEvents.removeEventListener("LOGO_READY", loadClientLogo);
			clientLogo.loadLogo(Config.logo);
		}
		
		private function applyModules(e:Event) {
			CustomEvents.removeEventListener("MODULES_READY", applyModules);
			for (var xx = 1; xx < 4; xx++) {
				var _module = getChildByName("DNA"+xx) as MovieClip;
				_module.init(Config.moduleList[xx - 1]);
			}
			
			if (Config.KPIActive) {
				for (var yy = 1; yy < 4; yy++) {
					var _kpi = getChildByName("KPI"+yy) as MovieClip;
					_kpi.init(Config.kpiList[yy-1]);
				}
			}
			
			// Insert One Dummy Clip into Anim Queue
			AnimEngine.addAnimToQueue(Fake);
			
			for (var ww = 1; ww < 4; ww++) {
				var _module2 = getChildByName("DNA"+ww) as MovieClip;
				_module2.registerPainPoints();
			}
		}
		
		private function prepTarget(e:Event) {
			CustomEvents.removeEventListener("TARGETS_READY", prepTarget);
			if (Config.TargetsActive) {
				whiteBlock = getChildByName("WhiteBlock") as MovieClip;
				whiteBlock.init();
				applyTargets();
			}
		}
		
		private function applyTargets() {
			for (var zz = 1; zz < 4; zz++) {
				var _kpi = whiteBlock.getChildByName("Target"+zz) as MovieClip;
				_kpi.init(Config.targetList[zz-1]);
			}
		}
		
		private function readKeyboard(e:KeyboardEvent) {
			trace(e.keyCode);
			switch (e.keyCode) {
				case 34:
					stepForward();
					break
				case 33:
					stepBackward();
					break
				case 37:
					stepBackward();
					break
				case 39:
					stepForward();
					break
				case 70:
					toggleFullScreen();
					break
			}

		}
		
		private function toggleFullScreen():void {
            if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE;
			} else {
				stage.displayState=StageDisplayState.NORMAL;
			}
        }
		
		private function stepForward() {
			AnimEngine.stepForward();
		}
		
		private function stepBackward() {
			AnimEngine.stepBackward();
		}

	}
	
}