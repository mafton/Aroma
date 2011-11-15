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