package org.bytearray.tools{	import flash.display.DisplayObject;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.geom.Matrix3D;	import flash.geom.Orientation3D;	import flash.geom.Point;	import flash.geom.Vector3D;		import org.bytearray.tools.events.FlippedEvent;		public class SideDetector extends EventDispatcher	{			private var target:DisplayObject;		private var localPoint1:Point;		private var localPoint2:Point;		private var localPoint3:Point;
		private var globalPoint1:Point;
		private var globalPoint2:Point;
		private var globalPoint3:Point;		private var vector1:Vector3D;		private var vector2:Vector3D;		private var isFront:Boolean;		private var wasFront:Boolean;		private var normale:Vector3D;				public static const FACE:String = "face";		public static const BACKFACE:String = "backFace";				public function SideDetector( pDisplayObject:DisplayObject )		{				target = pDisplayObject;
			localPoint1 = new Point ( 0, 0 );
			localPoint2 = new Point ( 100, 0 );
			localPoint3 = new Point ( 0, 100 );			target.addEventListener ( Event.ENTER_FRAME, calculNormale );		}					private function calculNormale ( pEvt:Event ):void 		{			// Senocular trick ;)			// http://www.senocular.com/?id=2.57			globalPoint1 = target.localToGlobal (localPoint1);			globalPoint2 = target.localToGlobal (localPoint2);			globalPoint3 = target.localToGlobal (localPoint3);						vector1 = new Vector3D ( globalPoint2.x-globalPoint1.x, globalPoint2.y-globalPoint1.y );			vector2 = new Vector3D ( globalPoint3.x-globalPoint1.x, globalPoint3.y-globalPoint1.y );			normale = vector1.crossProduct ( vector2 );						isFront = normale.z > 0;						if ( isFront && !wasFront ) dispatchEvent ( new FlippedEvent ( FlippedEvent.FLIPPED, SideDetector.FACE ) );						else if ( wasFront && !isFront ) dispatchEvent ( new FlippedEvent ( FlippedEvent.FLIPPED, SideDetector.BACKFACE ) );						wasFront = isFront;		}				public function remove():void{			target.removeEventListener(Event.ENTER_FRAME , calculNormale);		}			}}