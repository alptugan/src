package com.filikatasarim.tatu.MathingGame
{
	import com.alptugan.globals.RootAir;
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	public class CongratsScreen extends CasaSprite
	{
		private var blackBox:CasaShape;
		
		private var str : String;
		public var multi:AText;
		private var holder:CasaSprite;

		public var a:AText;
		
		public function CongratsScreen(str:String)
		{
			this.str = str;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			blackBox = new CasaShape();
			blackBox.graphics.beginFill(0x2c3e50,0.95);
			blackBox.graphics.drawRect(0,0,RootAir.W,RootAir.H);
			blackBox.graphics.endFill();
			
			addChild(blackBox);
			
			multi = new AText("bold",str,RootAir.W-100,66,0xecf0f1,false,false,"center");
			addChild(multi);
			
			multi.x =50;
			multi.y = RootAir.H-multi.height >> 1;
			
			
			
			
			holder = new CasaSprite();
			addChild(holder);
			
			
		}
		
		public function initTopScore(str:String,_y:int,_delay:Number = 0):void {
			
			a = new AText("bold",str,RootAir.W-100,46,0xffffff,false,false,"center");
			addChild(a);
			TweenMax.from(a,0.5,{alpha:0,delay:_delay});
			a.x = 50;
			a.y = _y;
			
		}
		
		
		
	}
}