package com.averta.tools {
	
	public class CloneObject{
		
		public static function clone(obj:Object):Object{
			var n_obj:Object = {};
			for(var key:String in obj)
				n_obj[key] = obj[key];
			return n_obj;
		}
		
	}
}