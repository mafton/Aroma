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
package com.averta.aroma.effect {
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.aroma.selector.ISelector;
	import com.averta.aroma.view.IView;
	

	public class Effect implements IEffect {
		
		protected var static:Boolean;
		protected var data:Array;
		protected var fromData:Object;
		protected var getTo:Function;
		protected var getFrom:Function;
		protected var _pieceClass:Class;
		protected var _pieceOptions:Object = {};
		protected var _view:IView;
		protected var _selector:ISelector;
		private var _pieceHolder:PieceHolder;

		public function Effect() {
		}
		
		public function addFrame(time:Number  , to:Object , options:Object = null , pluginData:Object = null):void{
			data.push({time:time , to:to , options:options , pluginData:pluginData});
		}
		
		public function getToData():Array{
			
			if(data != null && static)
				return data;
			
			data = new Array();
			getTo();
			return data;	
		}
				
		public function getFromData():Object {
			if(fromData != null && static)
				return fromData;
			else if(static){
				fromData = getFrom();
				return fromData;
			}else
				return getFrom();
		}
		
		
		public function get selector():ISelector { return _selector; }
		public function set selector(value:ISelector):void{
			if (_selector == value)
				return;
			_selector = value;
		}
		
		public function get view():IView { return _view; }
		public function set view(value:IView):void{
			if (_view == value)
				return;
			_view = value;
		}
		
		public function get pieceClass():Class { return _pieceClass; }
		public function set pieceClass(value:Class):void{
			if (_pieceClass == value)
				return;
			_pieceClass = value;
		}
		
		public function get pieceOptions():Object { return _pieceOptions; }
		public function set pieceOptions(value:Object):void {
			if (_pieceOptions == value)
				return;
			_pieceOptions = value;
		}
		
		public function get pieceHolder():PieceHolder { return _pieceHolder; }	
		public function set pieceHolder(value:PieceHolder):void
		{
			if (_pieceHolder == value)
				return;
			_pieceHolder = value;
		}
		
	}
}