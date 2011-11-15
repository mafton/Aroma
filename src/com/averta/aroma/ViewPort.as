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

package com.averta.aroma {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ViewPort provides a place for all of the Banner Rotator's images
	 **/
	public class ViewPort extends Sprite{
		
		// Width of the ViewPort
		private var _width:Number = 0; 
		
		// Height of the ViewPort
		private var _height:Number = 0; 
		
		// shape of the mask that used in ViewPort
		private var mask_shape:Shape;
		
		
		/**
		 * Creates a new ViewPort instance
		 */
		public function ViewPort(){
			super();
			
			mask_shape = new Shape();
			mask_shape.graphics.beginFill(0);
			// it will be resized 
			mask_shape.graphics.drawRect(0,0,1,1);
			
			addChild(mask_shape);
			// setup mask
			this.mask = mask_shape;
		}
		
		
		override public function get width():Number{ return _width}
		override public function set width(value:Number):void{
			if(value == _width) return;
			_width = value;
			
			mask_shape.width = value;
			// update viewport layout
			
		}
		
		override public function get height():Number{ return _height}
		override public function set height(value:Number):void{
			if(value == _height) return;
			_height = value;
			
			mask_shape.height = value;
			// update viewport layout
			
		}
		
	}
}