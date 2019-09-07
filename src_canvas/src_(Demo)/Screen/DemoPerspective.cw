package  { 
	
	import GZ.GFX.Object;

	import GZ.File.RcImg;
	import GZ.GFX.Root;
	
	import GZ.GFX.Interface;
	import GZ.GFX.Clip;

	import GZ.Math;
	
	import GZ.GFX.Clip.Img;
	
	/**
	 * @author Maeiky
	 */	
	public class DemoPerspective extends Clip {

		public var oImg : Img;
		public var oImg2 : Img;
		public var oImg3 : Img;
		
		public function DemoPerspective( _oParent : Root ):Void {
			
			Clip(_oParent, 0.0, 0.0);s
			//! First object with rotation of 90deg on Y axis, it is visible because we have a perspective
			oImg = new Img(this, -100.0, 400.0, E"Transform.png", true);
			oImg.WnYaw(Math.nPI / 2.0);
			//! Second object red with half size
			oImg2 = new Img(this, 100.0, 100.0, E"Transform.png", true);
			oImg2.WnWidth(0.5);
			oImg2.WnHeight(0.5);
			oImg2.WnRed(1.0);
			//! Second object blue with half size
			oImg3 = new Img(this, 700.0, 100.0, E"Transform.png", true);
			oImg3.WnWidth(0.5);
			oImg3.WnHeight(0.5);
			oImg3.WnBlue(1.0);
			//! Perspective settings, try different values
			
			oItf.oPerspective.fSetFocal(75.0);
			//! ---- Uncomment below to change prespetive type ----
			//!oItf->oPerspective->fSetFromSelf();
			//!oItf->oPerspective->fSetFromPosition(-300.0, 300.0);
			//!oItf->oPerspective->fSetFromBufferCenter();
			/*
			oItf.oPerspective.fSetFromSelf();
			oItf.oPerspective.fSetFromPosition(0, 0);
			oItf.oPerspective.fSetFromBufferCenter();
			*/
			
		}

		
		override public function fUpdateParentToChild():Void {
			//!Move Image 1 to see the wall effect perspective, and wrap to the beginning
			oImg.MnX(4.0);  //Move
			if (oImg.GnX() >  900.0) {
				oImg.WnX(-100.0);
			}
			
			//!Rotate Y Image 2
			oImg2.MnYaw(0.05);
					
			//!Rotate Z Image 3
			oImg3.MnPitch(0.05);
			
		}
		

	}
}