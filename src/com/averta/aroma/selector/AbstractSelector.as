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
package com.averta.aroma.selector
{
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.view.IView;
	
	public class AbstractSelector implements ISelector {
		
		protected var view:IView;
		protected var effect:IEffect;
		protected var _select_num:uint;
		
		public function AbstractSelector() {
			
		}
		
		public function get count():uint {
			return uint(view.count / _select_num);
		}
		
		public function getPieceList():Array {
			return null;
		}
		
		public function initialize(effect:IEffect, view:IView):void {
			this.view = view;
			this.effect = effect;
			effect.selector = this;
			effect.view = view;
		}
	
		public function get selectNum():uint { return _select_num; }
		public function set selectNum(value:uint):void {
			_select_num = value;
		}
	}
}