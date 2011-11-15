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
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * Used for creating sliding pieces in effects
	 */
	public class SlideIn extends BasicPiece implements IPiece {
		
		/** slide from right */
		public static const SLIDE_RIGHT:uint = 0;
		
		/** slide from left */
		public static const SLIDE_LEFT:uint = 1;
		
		/** slide from bottom*/
		public static const SLIDE_BOTTOM:uint = 2;
		
		/** slide from top */
		public static const SLIDE_TOP:uint = 3;
	
		protected var mask_shape:Shape;
		protected var _push:Boolean = true;
		protected var _slideDir:uint;
		protected var _slidePerc:Number = 0;
		
		
		/**
		 * Creates a new SlideIn instance
		 */	
		public function SlideIn(){
			super();
			
			_tweenPropsTarget = this;
			_tweenProps = ['slide'];
			
			mask_shape = new Shape();
			mask_shape.graphics.beginFill(0);
			// it will be resized 
			mask_shape.graphics.drawRect(0,0,1,1);
			
			
			addChild(new_bm);
			
			_slideDir = SLIDE_LEFT;
			
			addChild(mask_shape);
			this.mask = mask_shape;
		}
		
		/**
		 * set the position of new image
		 */
		protected function setSlidePosition():void{
			
			if(_slideDir == SLIDE_RIGHT || _slideDir == SLIDE_LEFT){
				
				new_bm.x = (_slideDir == SLIDE_RIGHT? 1 : -1) *( _width - _width * _slidePerc * .01) ;
				
				if(push)
					old_bm.x = (_slideDir == SLIDE_RIGHT? -1 : 1) * _width * _slidePerc * .01;
				
				return;
			}
			
			if(_slideDir == SLIDE_TOP || _slideDir == SLIDE_BOTTOM){
				new_bm.x = 0
				
				new_bm.y = (_slideDir == SLIDE_BOTTOM? 1 : -1) * ( _height - _height * _slidePerc * .01);
					
				if(push)
					old_bm.y = (_slideDir == SLIDE_BOTTOM? -1 : 1) * _height * _slidePerc * .01;	
			}
		}
		
		
		override public function setup(new_bmd:BitmapData, old_bmd:BitmapData):void{
			super.setup(new_bmd , old_bmd);
			
			setSlidePosition();
		}
		
		override public function update(new_bmd:BitmapData, old_bmd:BitmapData):void{
			super.update(new_bmd , old_bmd);
			
			setSlidePosition();
		}
		
		/**
		 * Direction of slide in 
		 * values of this property can be setted by SLIDE_*;
		 */
		public function get slideDir():uint { return _slideDir; }
		public function set slideDir(value:uint):void {
			if (_slideDir == value)
				return;
			_slideDir = value;
		}
		
		/**
		 * Whether or not the old image push by new image.
		 */
		public function get push():Boolean { return _push; }
		public function set push(value:Boolean):void{
			if (_push == value)
				return;
			_push = value;
		}
		
		/** 
		 * Indicates the position value of the new image specified.
		 */
		public function get slide():Number { return _slidePerc; }
		public function set slide(value:Number):void{
			if (_slidePerc == value)
				return;
			_slidePerc = value;
			
			setSlidePosition();
		}
		
		override public function set options(value:Object):void{
			super.options = value;
			
			if(options.dir != null)
				_slideDir = options.dir;
			
			if(options.push != null)
				_push = options.push;
		}
		
		
		override public function dispose():void{
			super.dispose();
			removeChild(mask_shape);
			this.mask = null;
			mask_shape = null;
		}
		
		override public function set height(value:Number):void{
			if (_height == value)
				return;
			_height = value;
			mask_shape.height = value;
			setSlidePosition();
		}
		
		override public function set width(value:Number):void {
			if (_width == value)
				return;
			_width = value;
			mask_shape.width = value;
			setSlidePosition();
		}
	}
}