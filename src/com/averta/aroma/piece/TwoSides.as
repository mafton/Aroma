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
package com.averta.aroma.piece {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import org.bytearray.tools.SideDetector;
	import org.bytearray.tools.events.FlippedEvent;
	
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.piece.holder.PieceHolder;
	
	/**
	 * Used for creating two side pieces in effects
	 */
	public class TwoSides extends BasicPiece implements IPiece{
		
		protected var side_detector:SideDetector;
		
		/**
		 * Creates a new TwoSides instance
		 */	
		public function TwoSides(){ 
			super();
			
			new_bm.visible = false;
				
		} 
		
		protected function onFlipped(event:FlippedEvent):void{
			if(event.position == SideDetector.BACKFACE){
				new_bm.visible = true;
				old_bm.visible = false;	
				
				var rx:Number = _holder.content.rotationX % 360;
				var ry:Number = _holder.content.rotationY % 360;
				
				if(ry > 0 && ry < 180){
					new_bm.scaleX = -1;
					new_bm.x = new_bm.width;
				}else{
					new_bm.scaleX =1;
					new_bm.x = 0;
				}
					
				if(rx > 0 && rx < 180){
					new_bm.scaleY = -1;
					new_bm.y = new_bm.height;
				}else{
					new_bm.scaleY = 1;
					new_bm.y = 0;
				}
				
			}else{
				new_bm.visible = false;
				old_bm.visible = true;	
			}
		}
		
		
		/** 
		 * remove objects and frees memory that is used to store piece's content
		 */
		override public function dispose():void{
			super.dispose();
			
			side_detector.remove();
			side_detector.removeEventListener(FlippedEvent.FLIPPED , onFlipped);
			side_detector = null;
		}
		
		override public function set holder(value:IPieceHolder):void{
			super.holder = value;
			
			if(side_detector != null){
				side_detector.remove();
				side_detector.removeEventListener(FlippedEvent.FLIPPED , onFlipped);
				side_detector = null;
			}
			
			side_detector = new SideDetector(_holder.content);
			side_detector.addEventListener(FlippedEvent.FLIPPED , onFlipped);
			
		}
		
	}
}