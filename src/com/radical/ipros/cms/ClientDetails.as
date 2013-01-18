package com.radical.ipros.cms 
{
	import flash.display.MovieClip;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class ClientDetails extends MovieClip
	{
		
		private var mFileReference:File;
		private var sourceFile:File;
		private var destinationFile:File;
		private var clientName:String;
		
		public function ClientDetails() 
		{
			Browse.addEventListener(MouseEvent.CLICK, onBrowseButtonClicked);
		}
		
		private function onBrowseButtonClicked(event:MouseEvent):void
		{
			mFileReference=new File();
			mFileReference.addEventListener(Event.SELECT, onFileSelected);
			var imageTypeFilter:FileFilter = new FileFilter("Image Files","*.png; *.jpg; *.gif");
			var allTypeFilter:FileFilter = new FileFilter("All Files (*.*)","*.*");
			mFileReference.browse([imageTypeFilter, allTypeFilter]);
		}
		
		private function onFileSelected(e:Event) {
			sourceFile = e.target as File;
			LogoName.text = sourceFile.name;
		}
		
		public function setState(_name:String,_file:File) {
			ClientName.text = _name;
			LogoName.text = _file.name;
		}
		
		public function getState():XML {
			var _retXML:XML = <client/>;
			_retXML.@clientlogo = LogoName.text;
			_retXML.@clientname = ClientName.text;
			return _retXML;
		}
		
		public function publish() {
			destinationFile = File.documentsDirectory.resolvePath("Source2Sale/" + LogoName.text);
			sourceFile = File.applicationDirectory.resolvePath(LogoName.text);
			try {
				sourceFile.copyTo(destinationFile, true);
			} catch (e:Error) {
				trace("No new image selected, not copying");
				return
			}
		}
		
	}

}