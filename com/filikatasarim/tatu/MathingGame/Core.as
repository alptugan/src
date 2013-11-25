package com.filikatasarim.tatu.MathingGame
{
	import com.alptugan.display.Gradient_Bg;
	import com.alptugan.events.AButtonEvent;
	import com.alptugan.globals.RootAir;
	import com.alptugan.utils.LoadXML;
	import com.greensock.TweenLite;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Expo;
	
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.dns.AAAARecord;
	import flash.utils.Timer;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	import org.casalib.util.UrlVariablesUtil;
	import org.osmf.events.TimeEvent;
	
	public class Core extends CasaSprite
	{
		[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-Roman.otf", embedAsCFF="false", fontName="regular", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Roman:Class;
		
		[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-Bd.otf", embedAsCFF="false", fontName="bold", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Bold:Class;
		
		
		private var first_tile:Tile;
		private var second_tile:Tile;
		private var pause_timer:Timer;
		
		private var mainHolder:CasaSprite;
		
		private var tiles:Array = [];
		private var id:int = 0;
		
		private var t:Time;
		private var gameScoreTime:int;
		
		private var xInit:int = 450;
		private var yInit:int = 280;
		
		private var gap:int = 20;
		private var scoreCount:int = 0;
		private var prevIdm:int = -1;
		private var isReset:Boolean = false;
		
		private var colordeck:Array = new Array(1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8);
		private var img_Arr:Array = new Array(
			"assets/puzzle1_transfer.jpg",
			"assets/puzzle2_arackiralama.jpg",
			"assets/puzzle3_hizligecisler.jpg",
			"assets/puzzle4_lounge.jpg",
			"assets/puzzle5_ring.jpg",
			"assets/puzzle6_dutyfree.jpg",
			"assets/puzzle7_restorankafeler.jpg",
			"assets/puzzle8_checkin.jpg",
			"assets/puzzle9_otoparkvale.jpg",
			"assets/puzzle10_konaklama.jpg",
			"assets/puzzle1_transfer.jpg",
			"assets/puzzle2_arackiralama.jpg",
			"assets/puzzle3_hizligecisler.jpg",
			"assets/puzzle4_lounge.jpg",
			"assets/puzzle5_ring.jpg",
			"assets/puzzle6_dutyfree.jpg",
			"assets/puzzle7_restorankafeler.jpg",
			"assets/puzzle8_checkin.jpg",
			"assets/puzzle9_otoparkvale.jpg",
			"assets/puzzle10_konaklama.jpg"
		);
		
		private var img_ArrPlacement:Array = [];
		
		private var searchStr:String;
		private var xmlLoad:LoadXML;

		private var scene1:SaveDialogScreen;
		private var cacheObject:Object = new Object();
		
		private var bg :Gradient_Bg;
		private var phpURL:String ="http://localhost:8888/test/add_score.php";
		
		public function Core()
		{
			addEventListener(Event.ADDED_TO_STAGE,onComplete);
		}
		
		protected function onComplete(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onComplete);
			
			bg = new Gradient_Bg(RootAir.W,RootAir.H,[0x8e44ad,0x9b59b6],GradientType.LINEAR);
			addChild(bg);
			
			mainHolder = new CasaSprite();
			addChild(mainHolder);
			
			img_ArrPlacement = img_Arr;
			
			// Shoe save screeen
			scene1 = new SaveDialogScreen();
			addChild(scene1);
			
			scene1.addEventListener(AButtonEvent.BUTTON_CLICKED,onclickedSave);
			
			/*
			*/
			
		}
		
		/**
		 * When user hits kaydet, user's data stored to the cache 
		 * @param e
		 * 
		 */
		protected function onclickedSave(e:AButtonEvent):void
		{
			//trace(e.inputName,e.inputSurname,e.inputEmail,e.inputTel);
			// store variables to the cache
			cacheObject.name = e.inputName;
			cacheObject.surname = e.inputSurname;
			cacheObject.email = e.inputEmail;
			cacheObject.tel = e.inputTel;
			cacheObject.score = 10000000000;
	
			
			loadGameScene2();
		}
		
		
		
		
		/**
		 * After user recor, start game 
		 * 
		 */		
		private function loadGameScene2():void
		{
			for (y=0; y<4; y++) {
				for (x=0; x<5; x++) {
					id = x + (y*5);
					var randomImg : int = Math.floor(Math.random()*img_ArrPlacement.length);
					tiles[id] = new Tile(img_ArrPlacement[randomImg]);
					img_ArrPlacement.splice(randomImg,1);
					
					mainHolder.addChild(tiles[id]);
					tiles[id].id = String(id);
					tiles[id].x = xInit + x*tiles[id].width + (x*gap);
					tiles[id].y = yInit + y*tiles[id].height + (y*gap);
					tiles[id].addEventListener(MouseEvent.CLICK,onClicked);
					
					//first_tile.addEventListener("isLoaded", isTileAddedToStage);
				}
			}
			
			xmlLoad = new LoadXML("http://localhost:8888/test/topten.php");
			
			
			mainHolder.scaleX = mainHolder.scaleY = 0.6;
			addTimer();
		}
		
		/**
		 * GAME TIMER 
		 * 
		 */
		private function addTimer():void
		{
			t = new Time();
			addEventListener("GameFinished",GameFinished);
			addChild(t);
		}
		
		/**
		 * GAME FINISHED  
		 * @param e
		 * 
		 */		
		private function GameFinished(e:Event) :void{
			
			TweenLite.to(t,0.5,{alpha:0,y:"-200",ease:Expo.easeOut});
			TweenLite.to(mainHolder,0.5,{alpha:0,delay:0.3,ease:Expo.easeOut,onComplete:onGameFinishComplete});
		}
		
		/**
		 * GAME FINISHED COMPLETE 
		 * 
		 */
		private function onGameFinishComplete():void {
			for(var i: int = 0; i < tiles.length ; i++){
				
				tiles[i].removeEventListener(MouseEvent.CLICK,onClicked);
				tiles[i].removeEventListeners();
				tiles[i].close();
				
				tiles[i].addEventListener(MouseEvent.CLICK,onClicked);
			}
			
			TweenLite.to(t,0.5,{alpha:1,y:"200",ease:Expo.easeOut,onComplete:function():void{t.restart();}});
			TweenLite.to(mainHolder,0.5,{alpha:1,delay:0.3,ease:Expo.easeOut});
			
			
		}
		
		protected function onClicked(e:MouseEvent):void {
			var idm:int = e.currentTarget.id;
			
			var stateTotal : int = 0;
			
			for(var i: int = 0; i < tiles.length ; i++){
				
				stateTotal += tiles[i].state;
			}
			
			if(stateTotal < 2){//less than 2 on stage
				
				//open and close
				if(tiles[idm].state == 0){
					//opening
					tiles[idm].open();
					
					
					
					if(searchStr != tiles[idm].imageSrc && prevIdm !=-1) {
						//they are not equal
						
						tiles[prevIdm].reset();
						tiles[idm].reset();
						isReset = true;
					}
					
					if(searchStr == tiles[idm].imageSrc && prevIdm !=-1){
						//they are equal
						
						tiles[idm].removeEventListener(MouseEvent.CLICK,onClicked);
						tiles[prevIdm].removeEventListener(MouseEvent.CLICK,onClicked);
						tiles[idm].state = 0;
						tiles[prevIdm].state = 0;
						isReset = true;
						
						scoreCount ++;
						
						if(scoreCount > 0) {
							gameScoreTime = t.tm;
							trace("gameScoreTime :"+gameScoreTime);
							dispatchEvent(new Event("GameFinished",true));
						}
					}
					
					searchStr = tiles[idm].imageSrc;
					if(!isReset){
						prevIdm = idm;
						
					}else{
						prevIdm = -1;
						isReset = false;
					}
					
					
				}
				else{
					//close
					tiles[idm].close();
				}
				
			}
			
			
		}
		
		/**
		 * SAVE USER INFO TO DATABASE 
		 * 
		 */
		private function saveScoreToDataBase():void {
			var urlLoader:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest(phpURL);
			var requestVars:URLVariables = new URLVariables();
			requestVars.pScore = cacheObject.score; 
			requestVars.pName = cacheObject.name;
			requestVars.pSurname = cacheObject.surname;
			requestVars.pEmail = cacheObject.email;
			requestVars.pTelephone = cacheObject.tel;
			req.data = requestVars;
			req.method = URLRequestMethod.POST;
			urlLoader.load(req);
			urlLoader.addEventListener(Event.COMPLETE, scoreSent);
		}
		
		private function scoreSent(e:Event):void {
			trace("score sent to php");
		}
		
		protected function isTileAddedToStage(event:Event):void
		{
			
			
		}
	}
}