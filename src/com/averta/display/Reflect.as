package com.averta.display {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	/**
	 * ...
	 * @author Morteza F.Shojaie 
	 */
	
	public class Reflect extends Sprite{
		
		private var reflect_bm:Bitmap;
		private var reflect_mask:Shape;
		public var reflect_parent:Sprite;
		private var vars:Object;
		private var interval :uint;
		private var ratios:uint;
		private var _height:Number;
		private var _width:Number;
		
		public function Reflect(target:Sprite , obj:Object, _width:Number = 0 , _height:Number = 0,  _ratios:uint = 255 , update_fer:int = -1 ) {
			reflect_parent = target;
			vars = obj;
			ratios = _ratios;
			
			
			
			if (_height == 0)
				this._height = target.height;
			else 
				this._height = _height;
				
			if (_width == 0)
				this._width = target.width;
			else 
				this._width = _width;	
				
			createReflect();
			this.y = this._height + ((vars.space != undefined)? vars.space : 0);
			
			reflect_parent.addChild(this);
			
			if (update_fer != -1) {
				addEventListener(Event.ENTER_FRAME , update );
			}
			
			
		}
		
		private function createReflect():void {
			
			reflect_bm = new Bitmap(createBMD());
			reflect_bm.cacheAsBitmap = true;
			reflect_bm.scaleY = -1;
			reflect_bm.y = reflect_bm.height
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(_width, vars.height , Math.PI / 2 );
			
			reflect_mask = new Shape();
			
			reflect_mask.graphics.beginGradientFill(GradientType.LINEAR , [0xFFFFFF, 0xFFFFFF] , [ vars.start_alpha/100 , vars.end_alpha/100 ] , [0 , ratios] , matrix);
			reflect_mask.graphics.drawRect(0, 0, _width , vars.height);
			reflect_mask.cacheAsBitmap = true;
			
			reflect_bm.mask = reflect_mask;
			
			addChild(reflect_bm);
			addChild(reflect_mask);
			
		}
		
		private function createBMD():BitmapData {
			var bmd_full:BitmapData = new BitmapData(_width , _height , true , 0xFFFFFF);
			bmd_full.draw(reflect_parent);
			
			var bmd:BitmapData = new BitmapData(_width , vars.height , true , 0xFFFFFF);
			bmd.copyPixels(bmd_full , new Rectangle(0 , _height - vars.height , _width , vars.height ) , new Point( 0 , 0));
			
			bmd_full = null;
			
			return bmd;
		}
		
		public function update(e:Event = null):void {
			reflect_bm.bitmapData.dispose();
			reflect_bm.bitmapData = createBMD();
		}
		
		public function clear():void {
			removeChild(reflect_bm);
			removeChild(reflect_mask);
			
			reflect_mask = null;
			reflect_bm = null;
			
			reflect_parent.removeChild(this);
			stop();
			//clearInterval(interval);			
		}
		
		public function stop():void {
			removeEventListener(Event.ENTER_FRAME , update );
		}
		
		public function start():void {
			addEventListener(Event.ENTER_FRAME , update );
		}
		
	}

}