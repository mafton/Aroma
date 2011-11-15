package com.averta.aroma.piece {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.aroma.view.IView;
	
	/**
	 * The BasicPiece class is the base class for all pieces that can serve as effect piece on the Banner rotator.
	 * BasicPiece is an abstract base class; therefore, It cannot be used directly.
	 */
	public class BasicPiece extends Sprite implements IPiece {
		
		protected var new_bm:Bitmap;
		protected var old_bm:Bitmap;
		
		protected var _options:Object;
		protected var _holder:PieceHolder;
		protected var _view:IView;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _tweenProps:Array = [];
		protected var _tweenPropsTarget:Object;
		
		/**
		 * Creates a new BasicPiece instance
		 */	
		public function BasicPiece(){
			super();
			
			
			_options = {};
			
			new_bm = new Bitmap(new BitmapData(1,1));
			old_bm = new Bitmap(new BitmapData(1,1));
						
			addChild(old_bm);
			addChild(new_bm);
			
			_tweenPropsTarget = new_bm;
			_tweenProps = ['alpha'];
		}
	
		/**
		 * create or update piece's content 
		 * 
		 * @param new_bmd the bitmapdata of the new DisplayObject
		 * @param old_bmd the bitmapdata of the old DisplayObject
		 */
		public function setup(new_bmd:BitmapData, old_bmd:BitmapData):void {
			old_bm.bitmapData.dispose();
			old_bm.bitmapData = old_bmd
			
			new_bm.bitmapData.dispose();
			new_bm.bitmapData = new_bmd;	
		}
		
		public function update(new_bmd:BitmapData, old_bmd:BitmapData):void{
			if(old_bmd != null){
				old_bm.bitmapData.dispose();
				old_bm.bitmapData = old_bmd
			}
			
			if(new_bmd != null){
				new_bm.bitmapData.dispose();
				new_bm.bitmapData = new_bmd;
			}
		}
		
		/** 
		 * remove objects and frees memory that is used to store piece's content.
		 */
		public function dispose():void{ 
			new_bm.bitmapData.dispose();
			if(new_bm.parent == this)
				removeChild(new_bm);
			new_bm = null;
			
			old_bm.bitmapData.dispose();
			if(old_bm.parent == this)
				removeChild(old_bm);
			old_bm = null;
		}
		
		public function get view():IView{ return _view }
		public function set view(value:IView):void{
			if(_view == value)
				return;
			_view = value;
		}
		
		
		/**
		 * Indicates the PieceHolder object that contains this Piece.
		 */
		public function get holder():IPieceHolder{ return _holder;}
		public function set holder(value:IPieceHolder):void{
			if(value == _holder)
				return;
			_holder = value as PieceHolder;
		}
		
		/**
		 * Indecates the Piece Options
		 */
		public function get options():Object{ return _options; }
		public function set options(value:Object):void{ 
			if(value == _options)
				return;
			_options = value;
		}
		
		/**
		 * An array of properties. Each property in the array represents a property name that used by PieceHolder proxy.
		 * @see PieceHolder.proxy 
		 */
		public function get tweenProps():Array{ return _tweenProps;	}
		
		public function get tweenPropsTarget():Object{ return _tweenPropsTarget; }
		
		
		override public function get height():Number { return _height; }
		override public function set height(value:Number):void{
			if (_height == value)
				return;
			_height = value;
		}
		
		override public function get width():Number { return _width; }
		override public function set width(value:Number):void {
			if (_width == value)
				return;
			_width = value;
		}
		
	}
}