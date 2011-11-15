package com.averta.loader {
	import flash.display.Shape;
	import flash.display.Sprite;
	import com.averta.drawing.Arc;
	
	/**
	 * ...
	 * @author Morteza F.Shojaie
	 */
	
	public class ArcLoading extends Sprite{
		
		private var loadingMask:Shape;
		private var bgMask:Shape;
		private var loading:Shape;
		public var bg:Shape;
		private var _teta:Number = -90;
		
		public var bgColor:uint;
		public var loadingColor:uint;
		public var innerRadius:Number;
		public var outerRadius:Number;
		public var dir:int = 1;
		
		public function ArcLoading(innerRadius:Number , outerRadius:Number , step:uint = 10 , bgColor:uint = 0xEEEEEE , loadingColor:uint = 0xD83D5D) {
			this.innerRadius = innerRadius;
			this.outerRadius = outerRadius;
			this.bgColor = bgColor;
			this.loadingColor = loadingColor;
			
			loadingMask = new Shape();
			loadingMask.graphics.beginFill(0x000000);
			Arc.drawSolid(loadingMask.graphics , 0 , 0 ,innerRadius , outerRadius , -90/360, 1,step);
			
			bgMask = new Shape();
			bgMask.graphics.beginFill(0x000000);
			Arc.drawSolid(bgMask.graphics , 0 , 0 ,innerRadius , outerRadius , -90/360, 1,step);
			
			bg = new Shape();
			bg.graphics.beginFill(bgColor);
			bg.graphics.drawCircle(0 , 0 , outerRadius);
			bg.mask = bgMask;
			
			loading = new Shape();
			loading.mask = loadingMask;
			
			
			addChild(bgMask);
			addChild(loadingMask);
			addChild(bg);
			addChild(loading);
			
		}
		
		
		public function set theta(value:Number):void {
			_teta = value;
			
			loading.graphics.clear();
			loading.graphics.beginFill(loadingColor);
			Arc.draw(loading.graphics , 0 , 0 , -90 , value-90 , outerRadius , dir);
			loading.graphics.endFill();
		}
		
		public function get theta():Number {
			return _teta;
			
		}
		
	}

}