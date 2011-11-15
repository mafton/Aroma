package com.averta.aroma.piece {
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.display.display3d.Cube;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import net.badimon.five3D.display.Scene3D;
	
	public class CubePiece extends BasicPiece implements IPiece {
		
		protected var _stage3d:Scene3D
		protected var _slidePerc:Number = 0;
		protected var _depth:Number = 100;
		protected var _flipX:Boolean;
		protected var _flipY:Boolean;
		
		protected var box:Cube;
		
		protected var _sideColor:uint;
		protected var _newImageLocation:uint = 3; // back
		

		public function CubePiece() {
			super();
			
			removeChild(old_bm);
			removeChild(new_bm);
			
			_stage3d = new Scene3D();
			box = new Cube();		
			
			_tweenProps = ['rotationX' ,'rotationY' ,'rotationZ' , 'z'  ];
			_tweenPropsTarget = box;
			
			_stage3d.addChild(box);
			_stage3d.startRender();
			box.render(_stage3d);
			
			
			addChild(_stage3d);
		}
		
		protected function setupFlip():void{
			
			if(!_flipX && !_flipY) return;
			
			var matrix:Matrix = new Matrix();
			matrix.scale( _flipX ? -1 : 1 , _flipY ? -1 : 1);
			matrix.translate(_flipX ? new_bm.width : 0 , _flipY ? new_bm.height : 0);
			
			var bmd_copy:BitmapData = new_bm.bitmapData.clone();
			
			new_bm.bitmapData.draw(bmd_copy , matrix);
			
			bmd_copy.dispose();
			bmd_copy = null;
			
		}
		
		protected function locateContent():void{
			
			var _view:DisplayObject = view as DisplayObject;
			
			new_bm.smoothing = true;
			old_bm.smoothing = true;
			
			box.width = new_bm.width;
			box.height = new_bm.height;
			box.depth = _depth;
			box.z = box.depth >> 1;
			
			setupFlip();
			
			box.addBitmapFace(Cube.FRONT , old_bm.bitmapData);
			
			for(var i:uint = 2 ; i <= 6 ; ++i){
				if(i == newImageLocation)
					box.addBitmapFace(i , new_bm.bitmapData);
				else
					box.addSolidFace(i , _sideColor)
			
			}
			
			
			_stage3d.y = (_view.height >> 1) - DisplayObject(holder).y;
			_stage3d.x = (_view.width >> 1) - DisplayObject(holder).x;
			box.x = -_stage3d.x + (new_bm.width >> 1);
			box.y = -_stage3d.y + (new_bm.height >> 1);
		}
					
		override public function setup(new_bmd:BitmapData, old_bmd:BitmapData):void{
			super.setup(new_bmd , old_bmd);
			
			locateContent();
		}
		
		override public function update(new_bmd:BitmapData, old_bmd:BitmapData):void{
			super.update(new_bmd , old_bmd);
			
			/*if(new_bmd != null)
				box.addBitmapFace(Cube.FRONT , old_bm.bitmapData);
			
			if(old_bmd != null)
				box.addBitmapFace(newImageLocation , new_bm.bitmapData);*/
			locateContent();
		}
		
		override public function dispose():void{
			super.dispose();
			removeChild(_stage3d);
			_stage3d.removeChild(box);
			_stage3d = null;
			box = null;
		}
		
		override public function set options(value:Object):void{
			super.options = value;
			
			if(value.newImageLocation != null)
				_newImageLocation = value.newImageLocation;
			
			if(value.sideColor != null)
				_sideColor = value.sideColor;
			
			if(value.depth != null)
				_depth = value.depth;
			
			if(value.flipX !=null)
				_flipX = value.flipX;
			
			if(value.flipY !=null)
				_flipY = value.flipY;
		}
		
		public function get flipX():Boolean { return _flipX; }
		public function set flipX(value:Boolean):void{
			if (_flipX == value)
				return;
			_flipX = value;
		}
		
		public function get flipY():Boolean { return _flipY; }
		public function set flipY(value:Boolean):void{
			if (_flipY == value)
				return;
			_flipY = value;
		}
		
		public function get newImageLocation():uint { return _newImageLocation; }
		public function set newImageLocation(value:uint):void{
			if (_newImageLocation == value)
				return;
			_newImageLocation = value;
		}
		
		public function get sideColor():uint { return _sideColor; }
		public function set sideColor(value:uint):void{
			if (_sideColor == value)
				return;
			_sideColor = value;
		}
		
		public function get depth():Number { return _depth; }
		public function set depth(value:Number):void{
			if (_depth == value)
				return;
			_depth = value;
		}
		
	}
}