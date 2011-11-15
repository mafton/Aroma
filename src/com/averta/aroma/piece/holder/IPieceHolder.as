package com.averta.aroma.piece.holder {
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public interface IPieceHolder {
		
		function applyFromProperties(values:Object):void;
			
		function dispose():void;
		
		function get piece():*;
		function set piece(value:*):void;
		
		function get regPoint():String;
		function set regPoint(value:String):void;
		
		function get col():uint;
		function get row():uint;
		
		function get pieceBounds():Rectangle;
		function set pieceBounds(value:Rectangle):void;
		
		function get proxy():PropertyProxy;

	}
}