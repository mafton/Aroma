/**
 * Aroma Effect Engine
 *
 * Copyright (c) 2011 Averta
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 **/
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