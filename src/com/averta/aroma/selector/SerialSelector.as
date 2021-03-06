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
package com.averta.aroma.selector{
	
	import com.averta.tools.RegPoint;
	
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.piece.IPiece;
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.selector.ISelector;
	import com.averta.aroma.view.IView;
	
	public class SerialSelector extends AbstractSelector implements ISelector{
		
		public static const TOP_LEFT_RIGHT:String = "tlr";
		
		public static const TOP_LEFT_DOWN:String = "tld";
		
		public static const TOP_RIGHT_LEFT:String = "trl";
		
		public static const TOP_RIGHT_DOWN:String = "trd";
		
		public static const BOTTOM_LEFT_UP:String = "blu";
		
		public static const BOTTOM_LEFT_RIGHT:String = "blr";
		
		public static const BOTTOM_RIGHT_UP:String = "bru";
		
		public static const BOTTOM_RIGHT_LEFT:String = "brl";
		
		protected var row:uint;
		protected var col:uint;
		protected var row_len:uint;
		protected var col_len:uint;
		
		private var _zigzag:Boolean;
		private var _dir:String;
		
		public function SerialSelector(dir:String = "tlr" , zigzag:Boolean = false , select_num:uint = 1){
			_zigzag = zigzag;
			_select_num = select_num;
			_dir = dir;
			
		}
				
		protected function convertPoint(row:uint , col:uint):Object{
			
			switch(_dir){
				case TOP_LEFT_RIGHT:
					return {row:row , col:col};
				break;
				case TOP_LEFT_DOWN:
					return {row:col , col:row};
				break;
				case TOP_RIGHT_LEFT:
					return {row:row , col: col_len - col - 1};
				break;
				case TOP_RIGHT_DOWN:
					return {row:col , col:row_len - row - 1};
				break;
				case BOTTOM_RIGHT_LEFT:
					return {row:row_len - row - 1, col: col_len - col - 1};
				break;
				case BOTTOM_RIGHT_UP:
					return {row:col_len - col - 1 , col:row_len - row - 1};
				break;
				case BOTTOM_LEFT_RIGHT:
					return {row:row_len - row - 1 , col:col};
				break;
				case BOTTOM_LEFT_UP:
					return {row:col_len - col - 1 , col:row};
				break;
			}
			
			return {row:row , col:col};
		}
		
	
		override public function getPieceList():Array{
			
			var list:Array = new Array();
			var point:Object;
			
			if(_dir.charAt(2) == 'u' || _dir.charAt(2) == 'd'){
				col_len = view.row;
				row_len = view.col;
			}else{
				col_len = view.col;
				row_len = view.row;
				
			}
			for(var i:uint ; i < _select_num ; i++ ){
				point = convertPoint(row , ((_zigzag && row % 2 != 0)? col_len - col - 1 : col));
				
				list.push(view.getPieceAt(point.col , point.row , effect));
				
				col ++;
				
				if(col == col_len){
					col = 0;
					row ++;
				}
						
			}
		
			return list;
		}
				
		public function get dir():String { return _dir; }
		public function set dir(value:String):void {
			_dir = value;
		}
		
		public function get zigzag():Boolean { return _zigzag; }
		public function set zigzag(value:Boolean):void {
			_zigzag = value;
		}
				
	}
}