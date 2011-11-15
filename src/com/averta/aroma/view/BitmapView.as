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
package com.averta.aroma.view {
	
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.piece.BasicPiece;
	import com.averta.aroma.piece.IPiece;
	import com.averta.aroma.piece.holder.IPieceHolder;
	import com.averta.aroma.piece.holder.PieceHolder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.utils.object_proxy;
	
	public class BitmapView extends AbstractView implements IView{
		
		protected var _row:uint;
		protected var _col:uint;
		protected var part_width:Number;
		protected var part_height:Number;
		protected var extra_part_width:Number;
		protected var extra_part_height:Number;
		protected var _smoothing:Boolean = true;
		protected var _useOldObject:Boolean = true;
		protected var _oldSourceLive:Boolean;
		protected var _newSourceLive:Boolean;
		protected var old_source_bm:Bitmap;
		protected var new_source_bm:Bitmap;		
		protected var _pieceHolderList:Array;
		protected var _showOldSource:Boolean;
		protected var _zSorting:Boolean;
		
		public function BitmapView(row:uint = 1 , col:uint = 1) {
			super();
						
			_row = row;
			_col = col;
			
			_pieceHolderList = new Array();
		}
		
		protected function posToID(col:uint , row:uint):uint{
			return row * _col + col  ;
		}
		
		protected function createBitmapSlice(col:uint , row:uint , source:Bitmap):BitmapData{
			var pieceBounds:Rectangle = getPieceBounds(col , row);
			
			var bmd:BitmapData = new BitmapData(pieceBounds.width , pieceBounds.height , true , 0xFFFEFE);
			
			bmd.copyPixels(source.bitmapData , pieceBounds , new Point()); 
			
			return bmd;
		}

		protected function getSnapshot(source:DisplayObject , bitmap:Bitmap):Bitmap{
			
			if(bitmap != null){
				bitmap.bitmapData.dispose();
				bitmap = null;
			}
			
			var bmd:BitmapData = new BitmapData(source.width , source.height , true , 0xF7F7F7);
			bmd.draw(source);
			
			bitmap = new Bitmap(bmd);
			bitmap.smoothing = smoothing;
			
			return bitmap;
			
		}
		
		protected function updateSource(force:Boolean = false):void{
			var pieceHolder:IPieceHolder 
			
			if(force){
				new_source_bm = getSnapshot(newSource , new_source_bm);
				old_source_bm = getSnapshot(oldSource , old_source_bm);
				for each(pieceHolder in _pieceHolderList)
					pieceHolder.piece.setup(createBitmapSlice(pieceHolder.col , pieceHolder.row , new_source_bm) , createBitmapSlice(pieceHolder.col , pieceHolder.row , old_source_bm));
			
				return;
			}
			
			if(_newSourceLive)
				new_source_bm = getSnapshot(newSource , new_source_bm);
			if(_oldSourceLive)
			old_source_bm = getSnapshot(oldSource , old_source_bm);
			
			for each(pieceHolder in _pieceHolderList)
				pieceHolder.piece.update((_newSourceLive ?createBitmapSlice(pieceHolder.col , pieceHolder.row , new_source_bm):null) , (_oldSourceLive ? createBitmapSlice(pieceHolder.col , pieceHolder.row , old_source_bm) : null ));
		}
		
		protected function liveUpdate(e:Event):void{
			updateSource();
		}
		
		
		protected function swapchildren(array:Array):void{
			for(var i:uint, l:uint = array.length; i < l/2 ; ++i){
				this.swapChildren(array[i] , array[l-i-1]);
			}
		}
		
		protected function sortInCols():void{
			if(_col == 1) return;
			
			var middle_col:uint = Math.floor(_col >> 1);
			var list_copy:Array = _pieceHolderList.slice();
			
			for(var l:uint = list_copy.length , i:uint = middle_col; i < l ; i += _col){
				swapchildren(list_copy.slice(i , i +( _col - middle_col)));
			}
		}
		
		protected function sortInRows():void{
			if(_row == 1) return;
			
			var middle_row:uint = Math.floor(_row >> 1);
			var list:Array = new Array();
			
			for(var i:uint; i < _col ; ++i){
				for(var j:uint = 0; j < _row - middle_row ; ++j){
					list.push(_pieceHolderList[(middle_row  * _col + i) + j * col]);
				}
				swapchildren(list);
				list = new Array();
			}
			
		}
		
		override public function sortParts():void{
			
			for(var u:uint, len:uint = _pieceHolderList.length ; u < len ; ++u)
				addChildAt(_pieceHolderList[u] , u);
			
			sortInCols();
			sortInRows();
		}
		
		override public function getPieceBounds(col:uint, row:uint):Rectangle{
			var bounds:Rectangle = new Rectangle();
			
			if(extra_part_width == 0){
				bounds.x = col * part_width;
				bounds.width = part_width;
			}else{
				bounds.width = (col > extra_part_width)? part_width : part_width + 1;
				bounds.x = (col > extra_part_width)? (part_width + 1) * extra_part_width + (col - extra_part_width) * part_width : (part_width + 1) * col;			
			}
			
			if(extra_part_height == 0){
				bounds.y = row * part_height;
				bounds.height = part_height;
			}else{
				bounds.height = (row > extra_part_height)? part_height : part_height + 1;
				bounds.y = (row > extra_part_height)? (part_height + 1) * extra_part_height + (row - extra_part_height) * part_height : (part_height + 1) * row;
			}
				
			return bounds;
		}
		
		override public function getPieceAt(col:uint , row:uint , effect:IEffect):IPieceHolder{
			
			var id:uint = posToID(col , row);
						
			if(_pieceHolderList[id] != null && _pieceHolderList[id].piece is effect.pieceClass)
				return _pieceHolderList[id];
			
			var piece:IPiece = new effect.pieceClass();
			
			
			var pieceHolder:PieceHolder = new PieceHolder(row , col , piece);
			var pieceBounds:Rectangle = getPieceBounds(col , row);
			
			pieceHolder.x = pieceBounds.x
			pieceHolder.y = pieceBounds.y
			pieceHolder.piece.width = pieceBounds.width
			pieceHolder.piece.height = pieceBounds.height;
			pieceHolder.regPoint = _regPoint;
			pieceHolder.pieceBounds = pieceBounds;
			
			effect.pieceHolder = pieceHolder;
			piece.view = this;
			piece.options = effect.pieceOptions;
			
			piece.setup(createBitmapSlice(col , row , new_source_bm) , (_useOldObject ? createBitmapSlice(col , row , old_source_bm) : null ));
			
			if(_pieceHolderList[id] != null){
				removeChild(pieceHolderList[id]);
				_pieceHolderList[id].dispose();
				_pieceHolderList[id] = null;
			}
			
			_pieceHolderList[id] = pieceHolder;
			
			addChild(pieceHolder);
			
			return pieceHolder;
		}
		
		override public function dispose():void{
			for each(var pieceHolder:PieceHolder in _pieceHolderList){
				removeChild(pieceHolder);
				pieceHolder.dispose();
				pieceHolder = null;
			}
			
			_pieceHolderList = new Array();
		}
		
		override public function get col():uint{ return _col; }
		override public function get row():uint{ return _row; }
		override public function get count():uint { return _row * _col; }
		
		override public function set oldSource(value:DisplayObject):void{
			if(value == old_source_bm)
				return;		
	
			old_source_bm = getSnapshot(value , old_source_bm);
			
			super.oldSource = value; 
		}
		
		override public function set newSource(value:DisplayObject):void{
			if(value == new_source_bm)
				return;
			
			new_source_bm = getSnapshot(value , new_source_bm);
			
			super.newSource = value;
		}
		
		override public function set width(value:Number):void{
			if(_width == value)
				return;
			
			_width = value;
			
			part_width = int(_width/_col);
			extra_part_width = _width % col;
			
		}
		
		override public function set height(value:Number):void{
			if(_height == value)
				return;
			
			_height = value;
			
			part_height = int(_height/_row);
			extra_part_height = _height % _row;
			
		}
		
		
		
		public function get pieceHolderList():Array{ return _pieceHolderList}
		
		
		public function get newSourceLive():Boolean { return _newSourceLive; }
		public function set newSourceLive(value:Boolean):void{
			if (_newSourceLive == value)
				return;
			_newSourceLive = value;
			
			if(value && !_oldSourceLive)
				addEventListener(Event.ENTER_FRAME , liveUpdate);
			else if(!_oldSourceLive)
				removeEventListener(Event.ENTER_FRAME , liveUpdate);
			
		}
		
		public function get oldSourceLive():Boolean { return _oldSourceLive; }
		public function set oldSourceLive(value:Boolean):void	{
			if (_oldSourceLive == value)
				return;
			_oldSourceLive = value;
			
			if(value && !_newSourceLive)
				addEventListener(Event.ENTER_FRAME , liveUpdate);
			else if(!_newSourceLive)
				removeEventListener(Event.ENTER_FRAME , liveUpdate);
		}
		
		
		public function update():void{
			updateSource(true);
		}
		
		public function get useOldObject():Boolean { return _useOldObject; }
		public function set useOldObject(value:Boolean):void {
			if (_useOldObject == value)
				return;
			_useOldObject = value;
		}
		
		public function get showOldSource():Boolean { return _showOldSource; }
		public function set showOldSource(value:Boolean):void{
			if (_showOldSource == value)
				return;
			if(value)
				addChild(oldSource);
			else if(oldSource.parent == this)
				this.removeChild(oldSource);
			
			_showOldSource = value;
		}
		
		public function get smoothing():Boolean { return _smoothing; }
		public function set smoothing(value:Boolean):void{
			if (_smoothing == value)
				return;
			_smoothing = value;
		}
		
		override public function get zSorting():Boolean { return _zSorting; }
		override public function set zSorting(value:Boolean):void {
			if (_zSorting == value)
				return;
			_zSorting = value;
		}
		
	}
}