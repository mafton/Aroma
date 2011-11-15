package org.bytearray.tools.events
{	
	import flash.events.Event;
	
	public class FlippedEvent extends Event
	{
		public static const FLIPPED:String = "flippedEvent";
		public var position:String;
		
		public function FlippedEvent( pType:String, pPosition:String )
		{
			super ( pType, false, false );
			
			position = pPosition;	
		}	
		
		public override function clone():Event
		{
			return new FlippedEvent ( type, position );	
		}
	}	
}