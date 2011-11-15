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