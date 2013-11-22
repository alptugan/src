package com.filikatasarim.tatu.MathingGame
{
	import com.alptugan.utils.LoadXML;
	import com.greensock.TweenLite;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	import org.osmf.events.TimeEvent;
	
	public class Core extends CasaSprite
	{
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
		
		public function Core()
		{
			addEventListener(Event.ADDED_TO_STAGE,onComplete);
		}
		
		protected function onComplete(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onComplete);
			
			mainHolder = new CasaSprite();
			addChild(mainHolder);
			
			img_ArrPlacement = img_Arr;
			
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
			
			xmlLoad = new LoadXML("http://localhost/topten.php");
						
			
			mainHolder.scaleX = mainHolder.scaleY = 0.6;
			addTimer();
			
		}
		
		private function addTimer():void
		{
			t = new Time();
			addEventListener("GameFinished",GameFinished);
			addChild(t);
		}
		
		private function GameFinished(e:Event) :void{
			
			TweenLite.to(t,0.5,{alpha:0,y:"-200",ease:Expo.easeOut});
			TweenLite.to(mainHolder,0.5,{alpha:0,delay:0.3,ease:Expo.easeOut,onComplete:onGameFinishComplete});
		}
		
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
		
		protected function isTileAddedToStage(event:Event):void
		{
			
			
		}
	}
}