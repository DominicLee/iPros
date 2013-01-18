package com.radical.ipros 
{

	import flash.events.Event;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import com.radical.ipros.Config;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.display.MovieClip;
	import com.radical.ipros.cms.Feedback;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class CommsEngine
	{
		protected static var xmlFile:File;
		protected static var xmlContents:XML;
		protected static var myStream:FileStream;
		protected static var _this:CommsEngine;
		protected static var mFileReference:File = new File();
		public static var rootClass:*;
		
		public function CommsEngine() 
		{
			_this = this;	
		}
		
		public static function init(_rootref:*) {
			rootClass = _rootref;
			myStream = new FileStream();
			myStream.addEventListener(Event.COMPLETE, handleLoad, false, 0, true);
			myStream.addEventListener(IOErrorEvent.IO_ERROR, handleError, false, 0, true);
			getConfig();
		}
		
		public static function getConfig() {
			xmlFile = File.documentsDirectory.resolvePath("Source2Sale/config.xml");
			if (xmlFile.exists) {
				myStream.openAsync(xmlFile, FileMode.READ);
				Feedback.showFeedback("Published config file loaded");
			} else {
				var targetParent:File = xmlFile.parent;
				targetParent.createDirectory();
				var originalFile:File = File.applicationDirectory.resolvePath("config.xml");
				originalFile.copyTo(xmlFile, true)
				
				originalFile = File.applicationDirectory.resolvePath("no_logo.png");
				var _targetFile = File.documentsDirectory.resolvePath("Source2Sale/no_logo.png");
				originalFile.copyTo(_targetFile, true)
				Feedback.showFeedback("No config file found - publishing defaults");
				getConfig();
			}
		}
		
		public static function getConfigFromFile() {
			mFileReference.addEventListener(Event.SELECT, loadConfig);
			var imageTypeFilter:FileFilter = new FileFilter("XML Files","*.xml");
			mFileReference.browse([imageTypeFilter]);
		}
		
		public static function loadConfig(e:Event) {
			mFileReference.removeEventListener(Event.SELECT, loadConfig);
			xmlFile = e.target as File;
			if (xmlFile.exists) {
				myStream.openAsync(xmlFile, FileMode.READ);
				Feedback.showFeedback("Config file "+e.target.name+" loaded");
			}
		}
		
		public static function saveConfigToFile() {
			mFileReference.addEventListener(Event.SELECT, saveFileSelected);
			mFileReference.browseForSave("Please select a destination to save to");
		}
		
		public static function saveFileSelected(e:Event) {
			mFileReference.removeEventListener(Event.SELECT, saveFileSelected);
			var file = e.target as File;
			if (file.nativePath.indexOf(".xml") == -1) {
				file.nativePath = file.nativePath + ".xml";
			}
			var fileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeMultiByte(rootClass.buildXML(), "iso-8859-1");
			Feedback.showFeedback("Saved File to "+e.target.name); 
		}
		
		public static function putConfig() {
			var file = File.documentsDirectory.resolvePath("Source2Sale/config.xml");
			var fileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeMultiByte(rootClass.buildXML(), "iso-8859-1");
			Feedback.showFeedback("File successfully published");
		}
		
		private static function handleLoad(e:Event) {
			xmlContents = new XML(myStream.readUTFBytes(myStream.bytesAvailable));
			myStream.close();
			MonsterDebugger.trace("Comms Success", xmlContents);
			Config.init(xmlContents);
		}
		
		private static function handleError(e:IOErrorEvent) {
			myStream.close();
			Feedback.showFeedback("Could not load config file");
		}
		
	}

}