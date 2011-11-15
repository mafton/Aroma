package com.averta.aroma.engine {
	import com.averta.aroma.effect.IEffect;
	import com.averta.aroma.events.EffectEvent;
	import com.averta.aroma.piece.holder.PieceHolder;
	import com.averta.aroma.selector.ISelector;
	import com.averta.aroma.view.IView;
	import com.averta.tools.CloneObject;
	import com.gskinner.motion.GTween;
	
	import flash.events.EventDispatcher;
	
	public class GTEngine extends EventDispatcher {
		
		protected var _view:IView;
		protected var _gtweenList:Vector.<GTween>;
		protected var _startDelay:Number = 0;
		protected var _overlapping:Number = 0;
		protected var _duration:Number;
		protected var _selector:ISelector;
		protected var _effect:IEffect;
		protected var _part_duration:Number;
		protected var _part_delay:Number;
		
		public function GTEngine(view:IView) {
			_view = view;
			_gtweenList = new Vector.<GTween>();
		}
		
		protected function startEff():void{
			
			_part_duration = _duration / (_selector.count - ( ( 1 - _overlapping) * ( _selector.count - 1 )));
			_part_delay = _part_duration * _overlapping;
						
			var piece_list:Array;
			var tween:GTween;
			var optionVars:Object;
			var delay_buffer:Number = 0;
			var frame_delay_buffer:Number = 0;
			var eff_data:Array;
			var from_eff_data:Object;
			var lastTween:GTween;
			
			// get all pieces for effect 
			for(var i:uint,l:uint = _selector.count ; i < l ; ++i){
				
				piece_list = _selector.getPieceList();
				
				// get piece pack
				for(var j:uint = 0,l2:uint = piece_list.length ; j < l2 ; ++j){	
					
					eff_data = _effect.getToData();
					from_eff_data = _effect.getFromData();
					
					// create frames
					for(var k:uint = 0,l3:uint = eff_data.length; k<l3 ; ++k){
				
						optionVars = CloneObject.clone(eff_data[k].options);
						
						if(k == 0){
							if(optionVars.delay == null )
								optionVars.delay = _part_delay + delay_buffer + _startDelay;
							else 
								optionVars.delay += _part_delay + delay_buffer + _startDelay;	
						}else{
							optionVars.autoPlay = false;
						}
						
						tween = new GTween( piece_list[j].proxy ,_part_duration * eff_data[k].time , eff_data[k].to , optionVars ,eff_data[k].pluginData);
						
						if(lastTween != null)
							lastTween.nextTween = tween;
						
						lastTween = tween;
						
						piece_list[j].applyFromProperties(from_eff_data); 
						
						tween.data = piece_list[j];
						
						if(j == 0 && i == 0 && k == 0)
							tween.onInit = dispatchStartEvent;
						
						if(j+1 == l2 && i+1 == l && k+1 == l3)
							tween.onComplete = dispatchCompleteEvent;
									
						_gtweenList.push(tween);
						
					}
					
					lastTween = null;
				}
				
				delay_buffer += _part_delay;
			}
			
			
			if(view.zSorting)
				view.sortParts();
			
			
			dispatchEvent(new EffectEvent(EffectEvent.INIT));
				
		}
		
		protected function dispatchStartEvent(tween:GTween):void{
			dispatchEvent(new EffectEvent(EffectEvent.START));
		}
		
		protected function dispatchCompleteEvent(tween:GTween):void{
			dispatchEvent(new EffectEvent(EffectEvent.COMPLETE));
		}
				
		public function start(effect:IEffect , selector:ISelector , duration:Number , overlapping:Number = 0.5 , delay:Number = 0):void{
			_selector = selector;
			_effect = effect;
			_duration = duration;
			_overlapping = overlapping;
			_startDelay = delay;
			
			_selector.initialize(_effect , _view);
			
			startEff();
		}
		
		public function reset():void{
			
			_selector = null;
			_effect = null;
			_duration = 0;
			_overlapping = 0;
			_startDelay = 0;
			
			for each(var tween:GTween in _gtweenList)
				tween = null;
			
			_gtweenList = new Vector.<GTween>();
			
		}
		
		public function get view():IView { return _view; }
		public function set view(value:IView):void {
			if (_view == value)
				return;
			_view = value;
		}
	}
}	