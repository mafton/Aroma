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
package com.averta.display.display3d {
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import net.badimon.five3D.display.Bitmap3D;
	import net.badimon.five3D.display.Shape3D;
	import net.badimon.five3D.display.Sprite2D;
	import net.badimon.five3D.display.Sprite3D;
	
	/*
	
		Face Number:
	
		|---|
		| 3 |
	|---|---|---|---|
	| 4 | 6 | 2 | 5 |
	|---|---|---|---|
		| 1 |
		|---|
	*/
	
	public class Cube extends Sprite3D {
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _depth:Number;
		
		protected var _faceList:Array;
		
		public static const FRONT:int = 1;
		public static const BACK:int = 3;
		public static const RIGHT:int = 2;
		public static const LEFT:int = 4;
		public static const TOP:int = 5;
		public static const BOTTOM:int = 6;
		
		public function Cube() {
			
			_faceList = [];
		}
		
		protected function getFaceDimension(face:uint):Rectangle{
			var rect:Rectangle = new Rectangle();
			
			switch(face){
				case 1: // front and back
				case 3:
					rect.width = _width;
					rect.height = _height;
				break;
				case 2: // right
				case 4: // left
					rect.width = _depth;
					rect.height = _height;
				break;
				case 5: // top
				case 6: // bottom
					rect.width = _width;
					rect.height = _depth;
				break;
			}	
			
			rect.x = -rect.width >> 1;
			rect.y = -rect.height >> 1;
				
			return rect;
		}
		
		protected function setFacePosition(face:uint , face_obj:Object ):void{
			switch(face){
				case 1: // front
					face_obj.z = -_depth >> 1;
					break;
				case 3: // back
					face_obj.rotationX = 180;
					face_obj.z = _depth >> 1;
					break;
				case 2: // right
					face_obj.rotationY = -90;
					face_obj.x = width >> 1;
					break;	
				case 4: // left
					face_obj.rotationY = 90;
					face_obj.x = -width >> 1;
					break;
				case 5: // top
					face_obj.rotationX = -90;
					face_obj.y = -height >> 1;
					break;
				case 6: // bottom
					face_obj.rotationX = 90;
					face_obj.y = height >> 1;
			}	
		}
		
		public function addSolidFace(face:uint , color:uint = 0 , alpha:Number = 1 , border:Number = 0 , borderColor:uint = 0 , borderAlpha:Number = 1):void{
			
			if(_faceList[face] != null){
				removeChild(_faceList[face]);
				_faceList[face] = null
			}
			
			var face_shape:Shape3D = new Shape3D();
			var face_dim:Rectangle = getFaceDimension(face);
			
			face_shape.graphics3D.beginFill(color , alpha);
			face_shape.graphics3D.lineStyle(border , borderColor , borderAlpha);
			face_shape.graphics3D.drawRect(face_dim.x , face_dim.y , face_dim.width , face_dim.height);
			face_shape.graphics3D.endFill();
			face_shape.singleSided = true;
			face_shape.flatShaded = true;
			
			childrenSorted = true;
			
			setFacePosition(face , face_shape);
			
			_faceList[face] = face_shape;
			
			addChild(face_shape);
		}
		
		public function addBitmapFace(face:uint , bmd:BitmapData):void{
			if(_faceList[face] != null){
				removeChild(_faceList[face]);
				_faceList[face] = null
			}
			
					
			var cont3d:Sprite3D = new Sprite3D();
			var bm3d:Bitmap3D = new Bitmap3D(bmd);
			var bmd_dim:Rectangle = getFaceDimension(face);
			
			bm3d.singleSided = true;
			bm3d.x = bmd_dim.x;
			bm3d.y = bmd_dim.y;
			
			//cont3d.flatShaded = true;
			cont3d.addChild(bm3d);
			
			setFacePosition(face , cont3d);
			
			_faceList[face] = cont3d;
			
			addChild(cont3d);
		}		
		
		public function get depth():Number { return _depth; }
		public function set depth(value:Number):void {
			if (_depth == value)
				return;
			_depth = value;
		}
		
		override public function get height():Number { return _height; }
		override public function set height(value:Number):void {
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