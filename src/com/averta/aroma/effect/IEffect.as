package com.averta.aroma.effect {
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.aroma.selector.ISelector;
	import com.averta.aroma.view.IView;
	
	
	public interface IEffect {
		
		function getFromData():Object;
		
		function getToData():Array;
		
		function get view():IView;
		function set view(value:IView):void;
		
		function get pieceHolder():PieceHolder;
		function set pieceHolder(value:PieceHolder):void;
		
		function get selector():ISelector;
		function set selector(value:ISelector):void;
		
		function get pieceClass():Class;
		function set pieceClass(value:Class):void;
		
		function get pieceOptions():Object;
		function set pieceOptions(value:Object):void;
	}
}