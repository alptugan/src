package com.filikatasarim.tatu.MathingGame
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	
	public class Time extends CasaSprite
	{
		private var time : Interval;
		
		private var txt : ATextSingleLine;
		
		public var gameLength:int = 60*3;
		public var tm:int;
		private var tmText:String;
		private var timeTxt:String = "03:00";
		
		public function Time()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			txt = new ATextSingleLine(timeTxt,"bold",0xecf0f1,80);
			addChild(txt);
			
			Aligner.alignToCenterTopToBounds(txt,stage.stageWidth,0,14);
			
			
			time = Interval.setInterval(this._repeatingFunction, 1000, "CASA");
			//time.repeatCount = 10;
			tm = gameLength;
			time.start();
		}
		
		
		public function restart():void {
			time.stop();
			txt.SetText(timeTxt);
			tm = gameLength;
			time.start();
		}
		
		private function _repeatingFunction(name:String) :void {
			
			if(tm != 0) {
				tm--;
			}
						
			// here is the magic
			
			var min:int = Math.floor(tm/60); // we compute an absolute difference in minutes
			var sec:int = Math.floor(tm - min*60);
			//var ms:int = (tm)%1000; // we compute an absolute difference in milliseconds
			
			var mint:String;
			var sect:String;
			
			if(min < 10) {
				mint = "0"+String(min);
			}else{
				mint = String(min);
			}
			
			if(sec < 10) {
				sect = "0"+String(sec);
			}else{
				sect = String(sec);
			}
			
			tmText = mint + ":" + String(sect);
			
			txt.SetText(tmText);
			
			if(tm == 0){
				Core.endWhy = "time";
				dispatchEvent(new Event("GameFinished",true));
				time.stop();
				txt.SetText(timeTxt);
				tm = gameLength;
			}
		}
	}
}