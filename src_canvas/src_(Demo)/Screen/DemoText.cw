package  {

	import GZ.Gfx.Object;

	import GZ.File.RcImg;
	import GZ.Gfx.Clip.Letter;
	import GZ.File.RcFont;
	import GZ.Gfx.Root;

	import GZ.Sys.Interface.Interface;
	import GZ.Gfx.Clip;
	import GZ.Gfx.Clip.Text;

	import GZ.Base.Math.Math;

	import GZ.Gfx.Clip.Img;
	import GZ.Base.Quaternion;
	

	/**
	 * @author Maeiky
	 */
	public class DemoText extends Clip {

		public var oImg : Img;
		public var oLetter : Letter;
		public var oText : Text;
		public var oText2 : Text;
		public var oTitle : Text;
		public var nAdd : Int = 0;
		
		
		public function DemoText( _oParent : Root ):Void {
			Clip(_oParent, _oParent.oItf.nHalfFrameWidth,  _oParent.oItf.nHalfFrameHeight);
			
			
			Debug.fTrace("----LoadFont ----");
			
		//	var _oFont : RcFont = new RcFont( "c:/extra_fonts/ProggyClean.ttf");
			var _oFont : RcFont = new RcFont( "Exe|Rc/Fonts/ProggyTiny.ttf", 10);
		//	var _oFont : RcFont = new RcFont("c:/extra_fonts/DroidSans.ttf");
		
		
		
		
			Debug.fTrace("--------");
			_oFont.fCpuLoad();
			
			oImg = new Img(this, 100.0, 100.0, _oFont, true);
			
			//	oImg.vPos.fSetSpeed(10);
			//oImg.vPos.fSetLimit(99900);
			
			//vPos.fSetSpeed(-100);
		//	vPos.fSetLimit(99900);
			
			
		//	oImg.vPos.nX = 256;
		//	oImg.vPos.nY = 256;
			
			
			oImg.vColor.nRed = 1.0;
			Debug.fTrace("--Finish-");
		//	oImg.WnRed(1.0);
			
			
			/*
			oImg.WnWidth(0.5);
			oImg.WnHeight(0.5);
			oImg.TnWidth(1.0);
			oImg.TnHeight(1.0);
			oImg.EnWidth(75);
			oImg.EnHeight(75);
			
			
		//	aaasBugHere
			
		//	floowingnOanal
			
			oImg.TnYaw(3.0 * Math.nPI);
			oImg.EnYaw(150);

			oImg.WnAlpha(0.0);
			oImg.TnAlpha(1.0);
			oImg.EnAlpha(100.0);
			
			*/
			
			
		//	oImg = new Img(this, 400.0, 300.0, _oFont, true);
			
		
			//sssssssssf
			
		//oLetter = new Letter(this, _oFont, -350.0, 50.0, 65);
		oLetter = new Letter(this, _oFont, 100.0, 100.0, 65);
			//		oLetter.vPos.nX = 256;
			//oLetter.vPos.nY = 256;
		oLetter.vColor.nRed = 1.0;
		oLetter.vSize.nHeight = 5.0;
		oLetter.vSize.nWidth = 5.0;
		
		

		//oText = new Text(this, _oFont,  oItf.nHalfFrameWidth * -1 + 20.0, -0.0, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");
		oText = new Text(this, _oFont,  oItf.nHalfFrameWidth * -1 + 20.0, -0.0, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");
		//oText = new Text(this, _oFont,  255, 255, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");

		oText.vColor.nRed = 1.0;
		
		
		oText.oCurrRange.fClear();
		oText.oCurrRange.fAdd("Yeah");
		
		
	//	oText2 = new Text(this, _oFont,  oItf.nHalfFrameWidth * -1 + 20.0, 10.0, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");
	//			oText2.vColor.nRed = 1.0;
		
		
		
		oTitle = new Text(this, _oFont,    oItf.nHalfFrameWidth * -1 + 20.0,120.0, "RayMarching Project");

		oTitle.vColor.nRed = 0.0;
		oTitle.vColor.nBlue = 0.0;
		oTitle.vColor.nGreen = 0.0;
		oTitle.vSize.nHeight = 2.0;
		oTitle.vSize.nWidth = 2.0;
		/*	
		Debug.fTrace1("-oText-");
			oText = new Text(this, _oFont,  oItf.nHalfFrameWidth * -1 + 20.0, -0.0, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");

			Debug.fTrace1("-ok-");
	*/		
			
			/*
			//!Create an image
			oImg = new Img(this, 400.0, 300.0, E"Transform.png", true);
			oImg.WnWidth(0.5);
			oImg.WnHeight(0.5);
			oImg.TnWidth(4.0);
			oImg.TnHeight(4.0);
			oImg.EnWidth(75);
			oImg.EnHeight(75);

			oImg.TnYaw(3.0 * Math.nPI);
			oImg.EnYaw(150);

			oImg.WnAlpha(0.0);
			oImg.TnAlpha(1.0);
			oImg.EnAlpha(100.0);
*/
			/*
			EnYaw(5);
			EnPitch(5);
			
			
			var _nTest : Int = 0;
			*/
			
			
		}	



		
		
		override public function fUpdateParentToChild():Void {
		

			nAdd++;
			oText.oCurrRange.fClear();
			oText.oCurrRange.fAdd("Testing: " + nAdd);

			return; //disable
		
			/*
			var _nMouseX : Float = oItf.oWindow.nMouseX - oItf.nHalfFrameWidth;
			var _nMouseY : Float = oItf.oWindow.nMouseY - oItf.nHalfFrameHeight;

			//!Updated each frame, parents before
			TnYaw(_nMouseX / oItf.nHalfFrameWidth / -1.15);
			TnPitch(_nMouseY / oItf.nHalfFrameHeight / -1.15);
			*/
			
		}




	}
}
