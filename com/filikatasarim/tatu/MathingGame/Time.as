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
		
		[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-Roman.otf", embedAsCFF="false", fontName="regular", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Roman:Class;
		
		[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-Bd.otf", embedAsCFF="false", fontName="bold", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Bold:Class;
		
		public var tm:int;
		private var tmText:String;
		
		public function Time()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			txt = new ATextSingleLine("01:00","bold",0x000000,86);
			addChild(txt);
			
			Aligner.alignToCenterTopToBounds(txt,stage.stageWidth,0,14);
			
			
			time = Interval.setInterval(this._repeatingFunction, 1000, "CASA");
			//time.repeatCount = 10;
			tm = 60;
			time.start();
		}
		
		
		public function restart():void {
			time.stop();
			txt.SetText("01:00");
			tm = 60;
			time.start();
		}
		
		private function _repeatingFunction(name:String) :void {
			
			if(tm != 0) {
				tm--;
			}
			

			tmText = "00:"+String(tm);
			
			if(tm < 10) {
				tmText = "00:0"+String(tm);
			}
			
			
			txt.SetText(tmText);
			
			if(tm == 0){
				dispatchEvent(new Event("GameFinished"));
				time.stop();
				txt.SetText("01:00");
				tm = 60;
			}
		}
	}
}