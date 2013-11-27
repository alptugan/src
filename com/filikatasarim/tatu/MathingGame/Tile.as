package com.filikatasarim.tatu.MathingGame
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import org.casalib.display.CasaSprite;
	
	public class Tile extends CasaSprite
	{
		private var animationTime:Number = 0.2;
		private var imageOnStage:Number = 1;
		private var imageC:CasaSprite;
		private var imageD:CasaSprite;
		
		public var loaderC:ImageLoader;
		public var loaderD:ImageLoader;
		
		public var imageSrc:String;
		private var imageName:String;
		private var imageW:Number = 320;
		private var imageH:Number = 240;
		
		public var state:int = 0;
		
		private var imageBackSrc:String = "assets/back.jpg";
		
		public var id:String;
		
		private var pp1:PerspectiveProjection=new PerspectiveProjection();
		
		private var pp2:PerspectiveProjection=new PerspectiveProjection();
		
		
		public function Tile(imageSrc:String)
		{
			this.imageSrc = imageSrc;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			/*this.x = imageW*0.5;
			this.y = imageH*0.5;*/
		}
		
		public function unLoadTiles():void
		{
			removeEventListeners();
			TweenMax.killAll(true);
			loaderC.unload();
			loaderD.unload();
			loaderD.dispose(true);
			loaderC.dispose(true);
			
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		
			root.transform.perspectiveProjection.fieldOfView = 100;
			imageC = new CasaSprite();
			imageD = new CasaSprite();
			
			addChild(imageC);
			addChild(imageD);
			
			loaderC = new ImageLoader(imageSrc, {name:imageName, 
				smoothing:true,
				container:imageC, 
				width:imageW,
				height:imageH, 
				x:-imageW/2, 
				y:-imageH/2,
				scaleMode:"none", 
				centerRegistration:false,
				noCache:true,
				autoDispose:true,
				auditSize:false,
				onComplete:onImageCLoad});
			//begin loading
			loaderC.load();
			
			
			
			
			
			
			
			//imageC.addChild(loaderC);
			//imageD.addChild(adNumber2);
			
			
			
		}
		
		protected function onImageCLoad(event:LoaderEvent):void {
			
			//TweenLite.from(loaderC.content, 0.5, {alpha:0});
		
			
			
			loaderD = new ImageLoader(imageBackSrc, {name:imageName, 
				smoothing:true,
				container:imageD, 
				width:imageW,
				height:imageH, 
				x:-imageW/2, 
				y:-imageH/2,
				scaleMode:"none", 
				centerRegistration:false,
				noCache:true,
				autoDispose:true,
				auditSize:false,
				onComplete:onImageDLoad});
			//begin loading
			loaderD.load();
			
		}
		
		protected function onImageDLoad(event:LoaderEvent):void {
			
			//TweenLite.from(loaderD.content, 0.5, {alpha:0});
			
			loaderD.content.x =  - loaderD.content.width/2;
			loaderD.content.y =  - loaderD.content.height/2;
			
			
			
			
			imageC.rotationX = 0;
			imageD.rotationX = 0;
		
			//dispatchEvent(new Event("isLoaded"));
			
			pp1.fieldOfView=100;
			pp1.projectionCenter=new Point(imageC.x,imageC.y);
			
			pp2.fieldOfView=100;
			pp2.projectionCenter=new Point(imageD.x,imageD.y);
			
			
			imageC.transform.perspectiveProjection=pp1;
			imageD.transform.perspectiveProjection=pp2;
			
			
			
			close();
			
		}
		
		public function close():void{
			
			imageD.rotationX = -90;
			imageD.alpha = 0;
			TweenMax.to(imageC, animationTime, {alpha:1,rotationX:90,ease:Quint.easeIn, onComplete:closeComplete, overwrite:0});
			TweenMax.to(imageD,animationTime, {alpha:1,delay:animationTime, rotationX:0, ease:Elastic.easeOut, overwrite:0});
			
		}
		public function closeComplete():void{
			state = 0;
			imageC.alpha = 0;
			imageC.rotationX = -90;
			/*
			
			TweenLite.to(imageD, animationTime, {alpha:1,delay:imageOnStage, rotationX:90,ease:Quint.easeIn, onComplete:checkStat, overwrite:0});
			TweenLite.to(imageC,animationTime, {alpha:1,delay:imageOnStage + animationTime, rotationX:0,delay:0, ease:Elastic.easeOut,overwrite:0});*/
			
		}
		
		
		public function open():void {
			state = 1;
			imageC.alpha = 0;
			imageC.rotationX = -90;
			TweenMax.to(imageD, animationTime, {alpha:1, rotationX:90,ease:Quint.easeIn, onComplete:openComplete, overwrite:0});
			TweenMax.to(imageC,animationTime, {alpha:1,delay:animationTime, rotationX:0, ease:Quint.easeOut,overwrite:0});
		}
		
		private function openComplete():void {
			
			imageD.rotationX = -90;
			imageD.alpha = 0;
		}
		
		public function reset():void{
			
			imageD.rotationX = -90;
			imageD.alpha = 0;
			TweenMax.to(imageC, animationTime, {alpha:1,delay:imageOnStage,rotationX:90,ease:Quint.easeIn, onComplete:resetComplete, overwrite:0});
			TweenMax.to(imageD,animationTime, {alpha:1,delay:imageOnStage+animationTime, rotationX:0, ease:Elastic.easeOut, overwrite:0});
			
		}
		
		public function resetComplete():void{
			state = 0;
			imageC.alpha = 0;
			imageC.rotationX = -90;
			
			
		}
		
		
	}
}