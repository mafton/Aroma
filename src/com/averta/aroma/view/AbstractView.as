package com.averta.aroma.view
{
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.tools.RegPoint;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class AbstractView extends Sprite implements IView {
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _oldSource:DisplayObject;
		protected var _newSource:DisplayObject;
		protected var _regPoint:String;
		
		public function AbstractView(){
			super();
			
			_regPoint = RegPoint.TOP_LEFT;
		}
		
		public function get count():uint{ return 1;	}
		
		public function get row():uint{ return 1; }
		
		public function get col():uint{ return 1; }
				
		public function getPieceAt(col:uint, row:uint , effect:IEffect):IPieceHolder{
			return null;
		}
		
		public 	function dispose():void {
		
		}
		
		public function get regPoint():String { return _regPoint; }
		public function set regPoint(value:String):void {
			if (_regPoint == value)
				return;
			_regPoint = value;
		}
		
		public function get newSource():DisplayObject { return _newSource; }
		public function set newSource(value:DisplayObject):void{
			if (_newSource == value)
				return;
			_newSource = value;
		}
		
		public function get oldSource():DisplayObject { return _oldSource; }
		public function set oldSource(value:DisplayObject):void{
			if (_oldSource == value)
				return;
			_oldSource = value;
		}
		
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
		
		public function sortParts():void{}
		public function getPieceBounds(col:uint,row:uint):Rectangle{ return null; }
		
		public function get zSorting():Boolean { return true; } 
		public function set zSorting(value:Boolean):void { }		
		
	}
}