package com.averta.aroma.effect {
	
	import com.averta.display.display3d.Cube;
	import com.gskinner.motion.easing.*;
	
	import com.averta.aroma.piece.BasicPiece;
	import com.averta.aroma.piece.CubePiece;
	import com.averta.aroma.piece.SlideIn;
	import com.averta.aroma.piece.TwoSides;

	public class Fade extends Effect implements IEffect{
		
		private var i:uint;
		
		public function Fade() {
			super();
			static = false;
			
			getFrom = getFromVars;
			getTo = getToVars;
			
			pieceClass = CubePiece;
			pieceOptions = {depth:800 , flipX:true , flipY:true }
		}
		
		public function getToVars():void{
			addFrame(0.5 , {rotationY:90 *( i++ % 2 == 0 ? 1 : -1) , z:1500} ,  {ease:Exponential.easeIn} );
			addFrame(0.5 , {rotationY:180 *( (i-1) % 2 == 0 ? 1 : -1) , z:400} ,  {ease:Exponential.easeOut} );
		}
		
		public function getFromVars():Object{
			return {  }
		}
	}
}