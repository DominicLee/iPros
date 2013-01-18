package com.radical.ipros.ui 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.filesystem.File;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class LogoLoaderClip extends MovieClip
	{
		
		private var picLoader:Loader;
		
		public function LogoLoaderClip() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event) {
			picLoader = new Loader();
			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadPicture);
			picLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleError);
		}
		
		public function loadLogo(_file:File) {
			picLoader.load(new URLRequest(_file.url));
		}
		
		private function loadPicture(event:Event):void {
			picLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadPicture);
			var image:Bitmap = Bitmap(picLoader.content);
			image.smoothing = true;
			image.x = -50;
			
			var _orientation:String = "";
			image.width > image.height ? _orientation = "landscape" : _orientation = "portrait";
			if (_orientation == "landscape") {
				image.width = 100;
				image.scaleY = image.scaleX;
			} else {
				image.height = 100;
				image.scaleX = image.scaleY;
			}
			
			image.y = -1 * image.height/2;
			this.addChild(image);
		}
		
		private function handleError(e:IOErrorEvent) {
			trace("Error loading ");
		}
		
	}

}