package com.averta.drawing {
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Morteza F.Shojaei
	 */
	
	public class Arc {
		
		
		public static function drawSolid (graphic:Graphics , centerX:Number, centerY:Number, innerRadius:Number, outerRadius:Number, startAngle:Number, arcAngle:Number, steps:Number ) : void{
			
			var twoPI:Number = 2 * Math.PI;
			var angleStep:Number = arcAngle/steps;
			var angle:Number
			var endAngle:Number
			var xx:Number = centerX + Math.cos(startAngle * twoPI) * innerRadius;
			var yy:Number = centerY + Math.sin(startAngle * twoPI) * innerRadius;
			var startPoint:Point = new Point(xx,yy);
			var i:uint;
			
			graphic.moveTo(xx, yy);
			
			for(i=0; i<=steps; i++){
				angle = (startAngle + i * angleStep) * twoPI;
				xx = centerX + Math.cos(angle) * innerRadius;
				yy = centerY + Math.sin(angle) * innerRadius;
				graphic.lineTo(xx, yy);
			}
			
			endAngle = startAngle + arcAngle;
			
			for (i = 0; i <= steps; i++) {
				angle = (endAngle - i * angleStep) * twoPI;
				xx = centerX + Math.cos(angle) * outerRadius;
				yy = centerY + Math.sin(angle) * outerRadius;
				 graphic.lineTo(xx, yy);
			}
			
			graphic.lineTo(startPoint.x, startPoint.y);
		}
		
		
		public static function draw(graphic:Graphics , _x:Number, _y:Number , a1:Number , a2:Number, r:Number, dir:int):void{
			a2 = a2*(Math.PI/180);
			a1 = a1*(Math.PI/180);
			graphic.lineTo(r+_x,_y);
			var diff:Number = Math.abs(a2 - a1);
			var divs:Number = Math.floor(diff/(Math.PI/4))+1;
			var span:Number = dir * diff/(2*divs);
			var rc:Number = r / Math.cos(span);
			graphic.moveTo(_x+Math.cos(a1)*r, _y+Math.sin(a1)*r);
			for (var i:uint; i<divs; ++i){
				a2 = a1 + span;
				a1 = a2 + span;
				graphic.curveTo(
							   _x+Math.cos(a2)*rc,
							   _y+Math.sin(a2)*rc,
							   _x+Math.cos(a1)*r,
							   _y+Math.sin(a1)*r
						  );
			}
			graphic.lineTo(_x, _y);
		}
		
		
		
	}

}