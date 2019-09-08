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
	public class DemoArrow extends Clip {

	
		
		public var oImg : Img;
		public var oTest : Img;
		

			public var sVwwdar : String;
		
		public function DemoArrow( _oParent : Root ):Void {
			Clip(_oParent, 0.0, 0.0);
			//Just a test///////////////////
		
			
			
			
			oImg = new Img(this, 650.0, 0.0, E"Arrow.png", false, 220, 82);

			hRotateOrder = eRotateOrder.YawPitchRoll;      //By default

			//Container setup
			TnX(oItf.nHalfFrameWidth);    //Center to screen X
			TnY(oItf.nHalfFrameHeight);   //Center to screen Y
			TnZ(600);					  //Put the container a little further
			
			//Arrow setup
			oImg.hRotateOrder = eRotateOrder.YawPitchRoll;  //By default
			oImg.MnYaw( Math.nPI/2.0);    //Turn Arrow at 90deg
			oImg.WnAlpha(0.0);
			oImg.TnAlpha(0.85);
			oImg.EnAlpha(200.0);
		}


		override public function fUpdateParentToChild():Void {

			MnYaw(0.025);		 //Container rotate, Arrow inside then follow a circular path on Z axis
			MnRoll(0.005);       //Container rotate, Arrow inside then follow a circular path on X axis
			oImg.MnRoll(0.255);  //Arrow rotate itself, Rolling on is Yaw rotation (90 deg in setup)
		}
	}
}
