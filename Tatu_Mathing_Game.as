package
{
	import com.alptugan.globals.RootAir;
	import com.filikatasarim.tatu.MathingGame.Core;
	import com.filikatasarim.tatu.MathingGame.SaveDialogScreen;
	
	import flash.display.Sprite;
	
	public class Tatu_Mathing_Game extends RootAir
	{
		
		public function Tatu_Mathing_Game()
		{
			
			initAppWindow(false,1366,768,30);
			initMainClass(Core);
			//initDebugView("tr");
			
			//disableKeyBoard();
			
		}
	}
}