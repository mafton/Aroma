package com.averta.aroma.effect {
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.aroma.selector.ISelector;
	import com.averta.aroma.view.IView;
	
	public class Effect implements IEffect {
		
		protected var static:Boolean;
		protected var data:Array;
		protected var fromData:Object;
		protected var getTo:Function;
		protected var getFrom:Function;
		protected var _pieceClass:Class;
		protected var _pieceOptions:Object = {};
		protected var _view:IView;
		protected var _selector:ISelector;
		private var _pieceHolder:PieceHolder;

		public function Effect() {
		}
		
		public function addFrame(time:Number  , to:Object , options:Object = null , pluginData:Object = null):void{
			data.push({time:time , to:to , options:options , pluginData:pluginData});
		}
		
		public function getToData():Array{
			
			if(data != null && static)
				return data;
			
			data = new Array();
			getTo();
			return data;	
		}
				
		public function getFromData():Object {
			if(fromData != null && static)
				return fromData;
			else if(static){
				fromData = getFrom();
				return fromData;
			}else
				return getFrom();
		}
		
		
		public function get selector():ISelector { return _selector; }
		public function set selector(value:ISelector):void{
			if (_selector == value)
				return;
			_selector = value;
		}
		
		public function get view():IView { return _view; }
		public function set view(value:IView):void{
			if (_view == value)
				return;
			_view = value;
		}
		
		public function get pieceClass():Class { return _pieceClass; }
		public function set pieceClass(value:Class):void{
			if (_pieceClass == value)
				return;
			_pieceClass = value;
		}
		
		public function get pieceOptions():Object { return _pieceOptions; }
		public function set pieceOptions(value:Object):void {
			if (_pieceOptions == value)
				return;
			_pieceOptions = value;
		}
		
		public function get pieceHolder():PieceHolder { return _pieceHolder; }	
		public function set pieceHolder(value:PieceHolder):void
		{
			if (_pieceHolder == value)
				return;
			_pieceHolder = value;
		}
		
	}
}