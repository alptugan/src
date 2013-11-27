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
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
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
		
		public var loaderD:ImageLoader;
		
		public function SaveDialogScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			blackBox = new CasaShape();
			blackBox.graphics.beginFill(0x2c3e50,0.95);
			blackBox.graphics.drawRect(0,0,stage.stageWidth+10,stage.stageHeight+10);
			blackBox.graphics.endFill();
			
			addChild(blackBox);
			
			loaderD = new ImageLoader("assets/logo.png", {name:"logo", 
				smoothing:true,
				container:this, 
				width:283,
				height:141, 
				x:RootAir.W*0.5, 
				y:180,
				scaleMode:"none", 
				centerRegistration:true,
				noCache:true,
				autoDispose:true,
				auditSize:false,
				onComplete:onImageCLoad});
			//begin loading
			loaderD.load();
			
			
			holder = new CasaSprite();
			addChild(holder);
			
			// Add Name Input
			inputName = new AInputText("regular",0xcccccc,0x333333,600,55,0xffffff,34,0xffffff,"Adınız");
			holder.addChild(inputName);
			
			// Add Surname Input
			inputSurname = new AInputText("regular",0xffffff,0x333333,600,55,0xffffff,34,0xffffff,"Soyadınız");
			holder.addChild(inputSurname);
			inputSurname.y = inputName.height + 5;
			
			// Add Telephone Input
			inputTel = new AInputText("regular",0xffffff,0x333333,600,55,0xffffff,34,0xffffff,"Telefon Numaranız");
			holder.addChild(inputTel);
			inputTel.y =inputSurname.y+ inputSurname.height + 5;
			
			// Add Email Input
			inputEmail = new AInputText("regular",0xffffff,0x333333,600,55,0xffffff,34,0xffffff,"E-Posta Adresiniz");
			holder.addChild(inputEmail);
			inputEmail.y =inputTel.y+ inputTel.height + 5;
			
			Aligner.alignCenterMiddleToBounds(holder,stage.stageWidth,stage.stageHeight,0,0);
			
			// Send Button
			send = new AButton("KAYDET", "bold",0xffffff,34,true,true);
			holder.addChild(send);
			
			send.x = holder.width - send.width >> 1;
			send.y = holder.height+10;
			send.addEventListener(MouseEvent.CLICK,onClick);
			
			inputName.alpha = inputSurname.alpha =inputTel.alpha=inputEmail.alpha=send.alpha=0;
			//initialize();
			inputName.y = inputName.y-100;
			inputSurname.y = inputSurname.y-100;
			inputTel.y = inputTel.y-100;
			inputEmail.y = inputEmail.y-100;
			send.y = send.y+300;
			
			
		}
		
		protected function onImageCLoad(event:LoaderEvent):void {
			
			//TweenLite.from(loaderC.content, 0.5, {alpha:0});
			
			
		}
		
		
		public function initDialog():void
		{this.x=-5;
			this.y = -4;
			TweenMax.to(blackBox,0.5,{autoAlpha:1,ease:Expo.easeOut});
			TweenMax.to(inputName,0.5,{autoAlpha:1,delay:0.1,y:"100",ease:Expo.easeOut});
			TweenMax.to(inputSurname,0.5,{autoAlpha:1,delay:0.15,y:"100",ease:Expo.easeOut});
			TweenMax.to(inputTel,0.5,{autoAlpha:1,delay:0.2,y:"100",ease:Expo.easeOut});
			TweenMax.to(inputEmail,0.5,{autoAlpha:1,delay:0.25,y:"100",ease:Expo.easeOut});
			TweenMax.to(send,0.5,{autoAlpha:1,delay:0.3,y:"-300",ease:Expo.easeOut});
		}
		
		protected function onClick(e:MouseEvent):void
		{
			var ev:AButtonEvent = new AButtonEvent(AButtonEvent.BUTTON_CLICKED,inputName.Tf.text,inputSurname.Tf.text,inputEmail.Tf.text,inputTel.Tf.text);
			
			TweenMax.to(inputName,0.5,{autoAlpha:0,delay:0.1,y:"-100",ease:Expo.easeOut});
			TweenMax.to(inputSurname,0.5,{autoAlpha:0,delay:0.15,y:"-100",ease:Expo.easeOut});
			TweenMax.to(inputTel,0.5,{autoAlpha:0,delay:0.2,y:"-100",ease:Expo.easeOut});
			TweenMax.to(inputEmail,0.5,{autoAlpha:0,delay:0.25,y:"-100",ease:Expo.easeOut});
			TweenMax.to(send,0.5,{autoAlpha:0,delay:0.3,y:"300",ease:Expo.easeOut});
			TweenMax.to(blackBox,0.8,{autoAlpha:0,delay:0.35,ease:Back.easeInOut,onComplete:function():void{dispatchEvent(ev);}});
		}
	}
}