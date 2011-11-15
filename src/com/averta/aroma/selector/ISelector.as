package com.averta.aroma.selector {
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.view.IView;
	
	public interface ISelector {
		
		function get count():uint;
		
		function getPieceList():Array;
		
		// @private
		function initialize(effect:IEffect , view:IView):void;
		
		
	}
}