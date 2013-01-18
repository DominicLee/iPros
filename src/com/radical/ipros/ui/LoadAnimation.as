package com.radical.ipros.ui 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.filesystem.File;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.events.IOErrorEvent;
	import caurina.transitions.Tweener;
	import com.radical.ipros.AnimEngine;
	import com.radical.ipros.utils.CustomEvents;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class LoadAnimation extends MovieClip
	{
		
		private var animLoader:Loader;
		
		public function LoadAnimation() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event) {
			animLoader = new Loader();
			animLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadPicture);
			animLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			animLoader.load(new URLRequest("intro.swf"));
			AnimEngine.addAnimToQueue(this);
		}
		
		private function loadPicture(event:Event):void {
			animLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadPicture);
			this.addChild(animLoader);
			CustomEvents.customEvent("ANIM_LOADED");
		}
		
		private function handleError(e:IOErrorEvent) {
			trace("Error loading Intro Animation");
		}
		
		public function activate():String {
			Tweener.addTween(this, { alpha:0, time:0.2, transition:"linear" } );
			CustomEvents.customEvent("ANIM_OUT");
			return "pause";
		}
		
	}

}