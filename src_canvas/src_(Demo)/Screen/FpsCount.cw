package  {

	import GZ.Gfx.Object;

	import GZ.File.RcImg;
	import GZ.Gfx.Clip.Letter;
	import GZ.File.RcFont;
	import GZ.Gfx.Root;

	import GZ.Gfx.Interface;
	import GZ.Gfx.Clip;
	import GZ.Gfx.Clip.Text;

	import GZ.Math;

	import GZ.Gfx.Clip.Img;
	import GZ.Base.Quaternion;


	/**
	 * @author Maeiky
	 */
	public class FpsCount extends Clip {

		
		public static var nInterger : Int;
		public static var nFloat : Float;
		public static var sTest : String = "Hello";
		
		public var oText : Text;
		public var nAdd : Int = 0;

		public function FpsCount( _oParent : Root, _nX : Float, _nY : Float ):Void {
			Clip(_oParent, _nX, _nY);
			
			//Debug.fTrace1("Static " + DemoRoll.sTest + " : " + DemoRoll.nInterger);
		//		oImg = new Img(this, 400.0, 300.0, "RcEngine:/Transform.png", true);
		//	var _oFont : RcFont = new RcFont("RcEngine:/ProggyClean.ttf", 26);
		
	//		var _oFont : RcFont = "RcEngine:/ProggyClean.ttf";

		//	_oFont.nDefaultScale = 26;
			Debug.fTrace1("LoadFont");
			var _oFont : RcFont = new RcFont( "Exe:/Proggy.ttf", 26);
		//	var _oFont : RcFont = new RcFont( "c:/extra_fonts/ProggyClean.ttf", 26);
		//	var _oFont : RcFont = new RcFont( "c:/extra_fonts/ProggyTiny.ttf", 10);
		
		Debug.fTrace1("fCpuLoad");
			_oFont.fCpuLoad();
			
					Debug.fTrace1(" new Text");
			//oText = new Text(this, _oFont,  oItf.nHalfFrameWidth * -1 + 20.0, -0.0, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");
			oText = new Text(this, _oFont,  0, 0, "aa");
			
				Debug.fTrace1(" Clear");
			oText.oCurrRange.fClear();
			oText.oCurrRange.fAdd("Fps: ");
				Debug.fTrace1(" ok");
		//	WnWidth(1.0);
		//	WnHeight(1.0);
			

		}

		override public function fUpdateParentToChild():Void {
			
			//Debug.fTrace1(" UpdateParentToChild FPS");
						
			nAdd++;
			oText.oCurrRange.fClear();
			oText.oCurrRange.fAdd("Fps:" +  oItf.nFps);
			//oText.oCurrRange.fAdd("Fps:");
			
			//!Updated each frame, parents before
			//Debug.fTrace1("aaa ");
		//	oImg.MnRoll(0.005);
			
			//MnPitch(-0.005);
		//	MnPitch(-0.005);
		}

		override public function fUpdateChildToParent():Void {
			//!Updated each frame, childs before
		}


	}
}
