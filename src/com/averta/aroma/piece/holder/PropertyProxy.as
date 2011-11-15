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