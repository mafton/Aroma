package com.averta.aroma.selector {
	
	public class DiagonalSelector extends AbstractSelector implements ISelector {
		
		public static const TOP_LEFT:String = 'tl'; 
		public static const BOTTOM_LEFT:String = 'bl'; 
		public static const TOP_RIGHT:String = 'tr'; 
		public static const BOTTOM_RIGHT:String = 'br'; 
		
		protected var _startPoint:String;
		protected var row_select:uint;
		protected var col_select:int;
		protected var col_start:uint;
		protected var row_start:uint;
		protected var extra_col:uint;
		protected var first_select:Boolean = true;
		
		public function DiagonalSelector(selectNum:uint = 1 , startPoint:String = 'tl'){
			super();
			_startPoint = startPoint;
			_select_num = selectNum;
		}
		
		override public function getPieceList():Array{
			var list:Array = new Array();
			
			for (var i:uint ; i < _select_num; i++) {
				switch(_startPoint) {
					case 'tl':
						if (first_select) {
							first_select = false;
						}else if (col_select != 0 && row_select != view.row -1) {
							col_select--;
							row_select++;
						}else {
							col_select = ++ col_start;
							if (col_select > view.col - 1 ) {
								row_select = ++extra_col;
								col_select = view.col - 1;
							}else {
								row_select = 0;
							}
						}
						break;
					case 'tr':
						if (first_select) {
							first_select = false;
							col_select = view.col - 1;
						}else if (col_select != view.col-1 && row_select != view.row -1) {
							col_select++;
							row_select++;
						}else {
							col_select = (view.col-1) - (++ col_start);
							if (col_select < 0 ) {
								row_select = ++extra_col;
								col_select = 0;
							}else {
								row_select = 0;
							}
						}
						break;
					case 'bl':
						if (first_select) {
							first_select = false; 
							row_select = view.row -1;
						}else if (col_select != 0 && row_select != 0) {
							col_select--;
							row_select--;
						}else {
							col_select = ++ col_start;
							if (col_select > view.col-1 ) {
								row_select = (view.row -1) - (++extra_col);
								col_select = view.col -1;
							}else {
								row_select = view.row -1;
							}
						}
						break;
					case 'br':
						if (first_select) {
							first_select = false; 
							row_select = view.row - 1;
							col_select = view.col -1;
						}else if (col_select != view.col -1 && row_select != 0) {
							col_select++;
							row_select--;
						}else {
							col_select = (view.col-1) - (++ col_start);
							if (col_select < 0  ) {
								row_select = (view.row -1) - (++extra_col);
								col_select = 0;
							}else {
								row_select = view.row -1;
							}
						}
						break;
				}
				
				list[i] = view.getPieceAt(col_select , row_select , effect);
			}
			
			return list;
		}
		
		public function get startPoint():String { return _startPoint; }
		public function set startPoint(value:String):void {
			if (_startPoint == value)
				return;
			_startPoint = value;
		}
	}
}