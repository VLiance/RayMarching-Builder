package  {

	import GZ.Gfx.Object;

	import GZ.File.RcImg;
	import GZ.Gfx.Root;

	import GZ.Sys.Interface.Interface;
	import GZ.Gfx.Clip;

	import GZ.Base.Math.Math;
	import GZ.Gfx.Clip.Img;
	
	import Demo.TestResult;

	/**
	 * @author Maeiky
	 */
	public class DemoRoll extends Clip {

		
		
		public static var nInterger : Int;
		public  var nTime : Int = 0;
		
		public static var nFloat : Float;
		public static var sTest : String = "Hello";

		
		public var oImg : Img;

		
		public function DemoRoll( _oParent : Root ):Void {
			Clip(_oParent, 0.0, 0.0);
			
			//Debug.fTrace1("Static " + DemoRoll.sTest + " : " + DemoRoll.nInterger);
			
			
			
			<cpp>
				gzEase<gzFloat> _nEase = 5.5f;
				_nEase = 7.5;
				_nEase = _nEase + 5.5f;
			</cpp>
			
			
 
			//! ----------------------------------------------------------------------------
			//! ------------ Object as attribute variable to do transformation -------------
			//! ----------------------------------------------------------------------------
			//! -------- Pos -- In Screen Coordinate (0.0, 0.0, 0.0 = Top left)
			//!nX = Position X
			//!nY = Position Y
			//!nZ = Position X
			//! --------Size ------ (1.0 = Normal, 0.5 Half, 2.0 Double)
			//!nWidth  = Width
			//!nHeight = Height
			//!nLength = Length
			//! -----Rotation ----- (0.0 = Normal, PI/2.0 = 90deg,  PI = 180deg ) *All in radian
			//!nRoll  = Rot X
			//!nPitch = Rot Y
			//!nYaw   = Rot Z
			//! -----Brightness --- (0.0 = Normal, -1.0 = Dark, 1.0 = Bright)
			//!nRed =   Red%
			//!nBlue =  Blue%
			//!nGreen = Green%
			//! -----Alpha -------- (0.0 = Transparent, 1.0 = Normal)
			//!nAlpha = Alpha%
			//!
			//! ----------------------------------------------------------------------------
			//! -------------------------- Function Modifier  ------------------------------
			//! ----------------------------------------------------------------------------
			//!	Add one of these modifier to change how the attributes react, in a fonction call
			//!
			//! W = Wrap -> Wrap/Teleport to a specific position/value
			//! T = To -> Move to a specifique destination -- NOTE: without Limit or Ease this will teleport to destination (infinite speed) ---
			//! M = Move -> Move continuously with speed (+=)
			//! L = Limit -> Set maximum speed (use with To or Move)
			//! E = Ease -> Set gradually decreasing speed value (or gradually increasing speed when value are negative)
			//! G = Get -> Getter on attibute (To get is value)
			//!
			//!----------------------------------------------------------------------------
			//!Create an image
			
			
			
			//oImg = new Img(this, 400.0, 300.0, "C:/Transform.png", true);
		//	oImg = new Img(this, 400.0, 300.0, "RcEngine|Transform.png", true);
		//	oImg = new Img(this, 400.0, 300.0, "Exe:/Transform.png", true);
			oImg = new Img(this, 400.0, 300.0, "Exe|Rc/Tf.png", true);
			
			oImg.vPos.fSetSpeed(10);
			oImg.vPos.fSetLimit(99900);
			
			//vPos.fSetSpeed(-100);
		//	vPos.fSetLimit(99900);
			
			
			oImg.vPos.nX = 100;
			oImg.vPos.nY = 250;
			
			
			oImg.vPos.nX.fTo(500);
			
			oImg.vSize.nWidth = 0.5;
			oImg.vSize.nHeight = 0.5;
			//oImg.vSize = 0.5;
			
			
			oImg.vSize.nWidth.fTo(1.5);
			oImg.vSize.nHeight.fTo(1.5);
			oImg.vSize.fSetSpeed(15);
			oImg.vSize.fSetLimit(99900);
			
			
			oImg.vColor.nRed = -1.0;
			
			oImg.vRot.nRoll = 15;
			oImg.vColor.nRed.fTo(1.0);
			oImg.vColor.nAlpha = 0.1;
			oImg.vColor.nAlpha.fTo(1.0);
			oImg.vColor.fSetSpeed(5);
			oImg.vColor.fSetLimit(99900);
			//oImg.vRot.nRoll = 10;
			//oImg.vRot.nYaw = 2.5;
			
		//	oImg.WnX(250);
		//	oImg.WnY(250);
	

	
			/*
			oImg.TnYaw(3.0 * Math.nPI);
			oImg.EnYaw(150);

			oImg.WnAlpha(0.0);
			oImg.TnAlpha(1.0);
			oImg.EnAlpha(100.0);
			*/

		}

		override public function fUpdateParentToChild():Void {
			oImg.vRot.nPitch = oImg.vRot.nPitch + 0.005;
			oImg.vRot.nRoll = oImg.vRot.nRoll + 0.008;
			nTime++;
			if(nTime > 250){
				//oImg.vColor.nGreen.fTo(-1.0);
				oImg.vColor.nRed.fTo(0.0);
				oImg.vColor.fSetSpeed(30);
			}
			//!Updated each frame, parents before
			//Debug.fTrace("fUpdateParentToChild ");
	//		oImg.MnRoll(0.005);
			// oImg.WnX(oImg.nAttX + 0.5);
			/*
		<cpp>
		printf("\nAAAAAA");
		</cpp>
			*/
		}

				
		<cpp_class_h>
		inline virtual void ViewAddInst() const{
			printf("\nAdd Inst DemoRooll %d ", nSharedCount);
		}
		inline virtual void ViewSubInst() const {
			printf("\nSubInst DemoRooll %d ", nSharedCount);
		}
		</cpp_class_h>
		
		
		
		
		
		override public function fUpdateChildToParent():Void {
			//!Updated each frame, childs before
		}


	}
}
