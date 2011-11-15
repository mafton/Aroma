package com.averta.loader.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Morteza F.Shojaie
	 */
	
	public class LoaderEvent extends Event {
		
		public static const LOAD_PROGRESS:String = 'onProgress';
		public static const LOAD_COMPLETE:String = 'onComplete';
		public static const LOAD_UPDATE:String = 'onUpdate';
		
		public function LoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new LoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("LoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}