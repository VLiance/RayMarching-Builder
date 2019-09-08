package  {

	import GZ.Sys.Window;
	import GZ.GFX.Attribute;
	import GZ.GFX.MovieClip;
	import GZ.GFX.Root;
	import GZ.Input.Key;

	/**
	 * @author Maeiky
	 */

	public class Perso extends MovieClip {

		use Key.eKey;

		public var nSpeed : Float = 3;

		public function Perso( _oParent : Root, _nX: Float, _nY:Float):Void {
			MovieClip(_oParent, _nX , _nY);
		}



		override public function fUpdateParentToChild():Void {

			if(oItf.oKey.fIsDown(eKey.Right)){
				MnX(nSpeed);
				TnWidth(1);
			}
			if(oItf.oKey.fIsDown(eKey.Left)){
				MnX(nSpeed * -1);
				TnWidth(-1);
			}


			fUpdateSequence();
		}





	}
}
