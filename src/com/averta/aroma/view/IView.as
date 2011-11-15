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