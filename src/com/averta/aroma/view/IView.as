package com.averta.aroma.view {
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.piece.BasicPiece;
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.piece.holder.PieceHolder;
	
	import flash.geom.Rectangle;

	public interface IView {
		
		function get count():uint
		
		function get row():uint;
		
		function get col():uint;
		
		function get zSorting():Boolean;
		
		function set zSorting(value:Boolean):void;
				
		function getPieceBounds(col:uint , row:uint):Rectangle;
		
		function sortParts():void
		
		function dispose():void; 
		
		function getPieceAt(col:uint , row:uint , effect:IEffect):IPieceHolder;
		
		function get regPoint():String;
		function set regPoint(value:String):void;
			
	}
}