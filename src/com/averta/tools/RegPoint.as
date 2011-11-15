package com.averta.tools {
	
	public class RegPoint {
		
		public static const TOP_LEFT:String = 'tl'; 
		public static const MIDDLE_LEFT:String = 'lm'; 
		public static const BOTTOM_LEFT:String = 'bl'; 
		public static const TOP_CENTER:String = 'tc'; 
		public static const MIDDLE_CENTER :String = 'mc'; 
		public static const BOTTOM_CENTER:String = 'bc'; 
		public static const TOP_RIGHT:String = 'tr'; 
		public static const MIDDLE_RIGHT:String = 'mr'; 
		public static const BOTTOM_RIGHT:String = 'br'; 
		
		public static function xPosition(item_width:Number , regPoint:String):Number {
			switch (regPoint.charAt(1)){
				case 'l':
					return 0;
				break;
				case 'c':
					return -item_width >> 1;
				break;
				case 'r':
					return -item_width;
				break;
			}
			return 0;
		}
		
		public static function yPosition(item_height:Number , regPoint:String):Number {
			switch (regPoint.charAt(0)) {
				case 't':
					return 0;
				break;
				case 'm':
					return -item_height >> 1;
				break;
				case 'b':
					return -item_height;
				break;
			}
			return 0
		}
	}
}