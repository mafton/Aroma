package com.averta.aroma.events {
	
	import flash.events.Event;
	
	public class EffectEvent extends Event {
		
		public static const START:String = 'start';
		public static const COMPLETE:String = 'complete';
		public static const INIT:String = 'init';
		
		public function EffectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
	}
}