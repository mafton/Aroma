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
package com.averta.aroma.selector {
	
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.view.IView;
	
	public class RandSelector extends AbstractSelector implements ISelector {
		
		protected var id_rand_list:Array;
		
		public function RandSelector(selectNum:uint = 1) {
			_select_num = selectNum;
			
			id_rand_list = new Array();
			
		}
	
		protected function removeArrayIndex(array:Array , index:uint):void{
			array.splice(index , 1);
		}
		
		protected function shuffle(array:Array):uint{
			var r_index:uint = Math.floor(Math.random() * array.length);
			var value:uint = array[r_index];
			
			removeArrayIndex(array , r_index);
			
			return value;
		}
		
		override public function getPieceList():Array {
			var list:Array = new Array();
			var index:uint;
			
			
			for(var i:uint ; i<_select_num ; ++i){
				index = shuffle(id_rand_list);
				
				list[i] = view.getPieceAt( uint(index / view.row) , index % view.row , effect);
				
			}
				
			return list;
		}
		
		override public function initialize(effect:IEffect, view:IView):void{
			super.initialize(effect , view);
			
			for(var i:uint, l:uint = view.col * view.row; i <l ; ++i) id_rand_list[i] = i;
		}
	
	}
}