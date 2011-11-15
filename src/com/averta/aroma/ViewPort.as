/**
 * Interactvive Banner Rotator by Averta
 * Copyright (c) 2011 Averta
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