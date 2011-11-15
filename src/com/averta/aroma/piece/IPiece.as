package com.averta.aroma.piece {
	import flash.display.BitmapData;
	
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.aroma.view.IView;
	
	public interface IPiece{
		
		function setup(new_bmd:BitmapData , old_bmd:BitmapData):void;
		function update(new_bmd:BitmapData , old_bmd:BitmapData):void;
		
		function dispose():void; 
		
		function get tweenProps():Array;
		function get tweenPropsTarget():Object;
		
		function get holder():IPieceHolder;
		function set holder(value:IPieceHolder):void;
		
		function set view(value:IView):void;
		function get view():IView;
		
		function get options():Object;
		function set options(value:Object):void;
	}
}