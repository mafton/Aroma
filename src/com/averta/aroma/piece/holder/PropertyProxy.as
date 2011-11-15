package com.averta.aroma.piece.holder {
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public dynamic class PropertyProxy extends Proxy {
		use namespace flash_proxy;
		
		
		private var pieceHolder:Object;
		
		public function PropertyProxy(pieceHolder:Object){
			this.pieceHolder = pieceHolder;
		}
		
		flash_proxy override function getProperty(prop:*):* {
			
			if(pieceHolder.piece == null) return;
			
			for(var i:uint,l:uint = pieceHolder.piece.tweenProps.length ; i<l ; ++i){
				if(pieceHolder.piece.tweenProps[i] == String(prop))
					return pieceHolder.piece.tweenPropsTarget[prop];
			}
			
			if( ! pieceHolder.content.hasOwnProperty(prop) || 
				! pieceHolder.container.hasOwnProperty(prop))
				return;
			
			if(String(prop) == 'x' || String(prop) == 'y' || String(prop) == 'z')
				return pieceHolder.container[prop];
			
			return pieceHolder.content[prop];
		}
		
		flash_proxy override function setProperty(prop:*,value:*):void {
			
			if(pieceHolder.piece == null) return;
				
			for(var i:uint,l:uint = pieceHolder.piece.tweenProps.length ; i<l ; ++i){
				if(pieceHolder.piece.tweenProps[i] == String(prop)){
					pieceHolder.piece.tweenPropsTarget[prop] = value;
					return
				}
			}
			
			if( ! pieceHolder.content.hasOwnProperty(prop) || 
				! pieceHolder.container.hasOwnProperty(prop))
				return;
			
			
			if(String(prop) == 'x' || String(prop) == 'y' || String(prop) == 'z'){
				pieceHolder.container[prop] = value;
				return;
			}
			
			pieceHolder.content[prop] = value;
		}	
	}
}