package com.radical.ipros.ui 
{
	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import com.radical.ipros.ui.DNAData;
	import flash.text.TextFieldAutoSize;
	import com.radical.ipros.AnimEngine;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class DNAModule extends MovieClip
	{
		private var moleculeList:Array;
		private var title:String;
		private var labelLocation:String;
		private var titleText:MovieClip;
		
		public function DNAModule() 
		{
			moleculeList = new Array();
			for (var moleculeCounter:Number = 0; moleculeCounter < this.numChildren; moleculeCounter++) {
				var _mole:MovieClip = this.getChildAt(moleculeCounter) as MovieClip;
				if (_mole is Molecule) {
					moleculeList.push(_mole);
				}
			}
			titleText = this.getChildByName("Title") as MovieClip;
			titleText.MoleculeLabel.autoSize = TextFieldAutoSize.LEFT;
			titleText.alpha = 0;
			
		}
		
		public function init(_dnadata:DNAData) {
			titleText.MoleculeLabel.text = _dnadata.title;
			titleText.x = 0 - (titleText.width / 2);
			AnimEngine.addAnimToQueue(titleText);
			
			for (var xx in _dnadata.dnaList) {
				moleculeList[xx].init(_dnadata.dnaList[xx]);
			}
			
			for (var yy = 0; yy < moleculeList.length; yy++) {
				//Register with the Animation engine
				AnimEngine.addAnimToQueue(moleculeList[yy]);
			}
			
		}
		
		public function registerPainPoints() {
			for (var zz = 0; zz < moleculeList.length; zz++) {
				if (moleculeList[zz].isPain) {
					AnimEngine.addAnimToQueue(moleculeList[zz]);
				}
			}
		}
		
	}

}