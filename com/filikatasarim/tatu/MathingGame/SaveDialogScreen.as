package com.filikatasarim.tatu.MathingGame
{
	import com.alptugan.events.AButtonEvent;
	import com.alptugan.globals.RootAir;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.AInputText;
	import com.alptugan.text.AInputTextField;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	import src.com.azinliklarittifaki.AButton;
	
	import uk.co.soulwire.util.DisplayUtil;
	
	public class SaveDialogScreen extends CasaSprite
	{
		private var blackBox:CasaShape;
		
		private var inputName:AInputText;
		private var inputSurname:AInputText;
		private var inputEmail:AInputText;
		private var inputTel:AInputText;
		
		private var send:AButton;
		
		private var holder:CasaSprite;
		
		public function SaveDialogScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			blackBox = new CasaShape();
			blackBox.graphics.beginFill(0x000000,0.95);
			blackBox.graphics.drawRect(0,0,RootAir.W,RootAir.H);
			blackBox.graphics.endFill();
			
			addChild(blackBox);
			
			
			holder = new CasaSprite();
			addChild(holder);
			
			// Add Name Input
			inputName = new AInputText("regular",0xcccccc,0x333333,400,55,0xffffff,34,0xffffff,"Adınız");
			holder.addChild(inputName);
			
			// Add Surname Input
			inputSurname = new AInputText("regular",0xffffff,0x333333,400,55,0xffffff,34,0xffffff,"Soyadınız");
			holder.addChild(inputSurname);
			inputSurname.y = inputName.height + 5;
			
			// Add Telephone Input
			inputTel = new AInputText("regular",0xffffff,0x333333,400,55,0xffffff,34,0xffffff,"Telefon Numaranız");
			holder.addChild(inputTel);
			inputTel.y =inputSurname.y+ inputSurname.height + 5;
			
			// Add Email Input
			inputEmail = new AInputText("regular",0xffffff,0x333333,400,55,0xffffff,34,0xffffff,"E-Posta Adresiniz");
			holder.addChild(inputEmail);
			inputEmail.y =inputTel.y+ inputTel.height + 5;
			
			Aligner.alignCenterMiddleToBounds(holder,RootAir.W,RootAir.H,0,0);
			
			// Send Button
			send = new AButton("KAYDET", "bold",0xffffff,34,true,true);
			holder.addChild(send);
			send.x = holder.width - send.width >> 1;
			send.y = holder.height+10;
			send.addEventListener(MouseEvent.CLICK,onClick);
			
			TweenMax.from(blackBox,0.5,{alpha:0,ease:Expo.easeOut});
			TweenMax.from(inputName,0.5,{alpha:0,delay:0.1,y:"-100",ease:Expo.easeOut});
			TweenMax.from(inputSurname,0.5,{alpha:0,delay:0.15,y:"-100",ease:Expo.easeOut});
			TweenMax.from(inputTel,0.5,{alpha:0,delay:0.2,y:"-100",ease:Expo.easeOut});
			TweenMax.from(inputEmail,0.5,{alpha:0,delay:0.25,y:"-100",ease:Expo.easeOut});
			TweenMax.from(send,0.5,{alpha:0,delay:0.3,y:"300",ease:Expo.easeOut});
		}
		
		protected function onClick(e:MouseEvent):void
		{
			var ev:AButtonEvent = new AButtonEvent(AButtonEvent.BUTTON_CLICKED,inputName.Tf.text,inputSurname.Tf.text,inputEmail.Tf.text,inputTel.Tf.text);
			TweenMax.to(holder,0.8,{alpha:0,y:"-100",ease:Back.easeInOut});
			TweenMax.to(blackBox,0.8,{alpha:0,delay:0.4,ease:Back.easeInOut,onComplete:function():void{dispatchEvent(ev);}});
		}
	}
}