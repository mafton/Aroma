package com.averta.aroma.piece.holder {
	
	import com.averta.tools.RegPoint;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * Each one of the Pieces have one PiceHolder thant is implement the value changes on piece. 
	 */
	public class PieceHolder extends Sprite implements IPieceHolder{
		
		protected var _piece:*;
		protected var _proxy:PropertyProxy;
		protected var _container:Sprite;
		protected var _content:Sprite;
		protected var _regPoint:String;
		protected var _row:uint;
		protected var _col:uint;
		protected var _pieceBounds:Rectangle;
		
		
		/**
		 * Creates a new PieceHolder instance
		 */	
		public function PieceHolder(row:uint , col:uint , piece:* = null) {
			super();

			_row = row;
			_col = col;
			
			_proxy = new PropertyProxy(this);
			_container = new Sprite();
			_content = new Sprite();
			_regPoint = RegPoint.TOP_LEFT;
			
			if(piece != null)
				this.piece = piece;
			
			_container.addChild(_content);	
			addChild(_container);			
		}
		
		protected function setPiecePosition():void{
			_piece.x = RegPoint.xPosition(_piece.width , _regPoint);
			_piece.y = RegPoint.yPosition(_piece.height , _regPoint);
			
			_content.x = -_piece.x;
			_content.y = -_piece.y;
		}
		
		/**
		 * prepare the piece for start effect
		 * @param values a object of properties for apply
		 */
		public function applyFromProperties(values:Object):void{
			for(var key:String in values)
				this.proxy[key] = values[key];
		}
		
		/** 
		 * remove objects and frees memory.
		 */
		public function dispose():void{
			_content.removeChild(piece);
			_piece.dispose()
			_piece = null;
			_container.removeChild(_content);
			_content = null;
			removeChild(_container);
			_container = null;
		}
		
		/**
		 * The BasicPiece object being referenced. 
		 */
		public function get piece():* { return _piece; }
		public function set piece(value:*):void{
			if (_piece == value)
				return;
			
			if(_piece != null){
				_content.removeChild(_piece);
				_piece = null;
			}
			
			_piece = value;
			_piece.holder = this;
			_content.addChild(_piece);
			setPiecePosition();
		}
		
		/**
		 * A value from the RegPoint class that specifies the alignment of the Piece in container.
		 * @see RegPoint
		 */
		public function get regPoint():String { return _regPoint; }
		public function set regPoint(value:String):void{
		
			if (_regPoint == value)
				return;
			
			_regPoint = value;
			setPiecePosition();
		}
		
		public function get pieceBounds():Rectangle{ return _pieceBounds; }
		public function set pieceBounds(value:Rectangle):void{
			if (_pieceBounds == value)
				return;
			_pieceBounds = value;
		}
		
		
		/**
		 * PieceHolder position in colume
		 */
		public function get col():uint{ return _col; }
		
		/**
		 * PieceHolder position in row
		 */
		public function get row():uint{ return _row; }

		/**
		 * The proxy object allows Tween engine to work with the properties of the target piece directly.
		 */
		public function get proxy():PropertyProxy{ return _proxy; }
		
		/**
		 * The Sprite to be used as a container for the piece.
		 */
		public function get container():Sprite { return _container; }
		
		public function get content():Sprite { return _content }
		
	}
}