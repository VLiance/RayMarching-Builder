package  { 
	
	import GZ.Sys.Window;
	import GZ.GFX.Button;
	import GZ.GFX.Object;
	import GZ.GFX.Root;
	import GZ.GFX.Clip.ButtonImg;
	import GZ.GFX.Clip.Slider;
	import GZ.GFX.Clip.Img;
	import GZ.GFX.Clip;
	import GZ.Math;

	/**
	 * @author Maeiky
	 */	
	public class ReverseMenu extends Clip {
		
		private var oSliderAll : Slider;
		private var oSliderRed : Slider;
		private var oSliderGreen : Slider;
		private var oSliderBlue : Slider;
		
		private var nStartX : Int = 11p;
		private var nStartY : Int = 44p;
		private var nSpaceY : Int = 51p;
		
		//private var oSelect : Clip = null;
		private var oSelect : ButtonImg = null;
		
		private var oBack : Img;
	
		public function ReverseMenu( _oParent : Root, _nX: Float, _nY:Float):Void {
			
			Clip(_oParent, _nX, _nY);
			
			oSliderRed = new Slider(this, nStartX, nStartY , false, 150, -75, -75);
			oSliderGreen = new Slider(this, nStartX, nStartY + nSpaceY , false, -75, 130, -75);
			oSliderBlue = new Slider(this, nStartX,  nStartY + nSpaceY * 2, false, -75, -75, 150);
			
			
			oBack = new Img(this, 0p , 0p,  E"Resource:Slider/ReverseMenu.png", false);
		}
		
		public function fSetAssociateClip( _oClip : ButtonImg):Void {
			oSelect = _oClip;
		}
		
		override public function fUpdateParentToChild():Void {
		
			
			if(oSliderRed.oSlider.bDrag  ||  oSliderGreen.oSlider.bDrag  ||  oSliderBlue.oSlider.bDrag ){
		//		oSelect.fToRevRGB(oSliderRed.nPc, oSliderGreen.nPc, oSliderBlue.nPc, 2);
			}
			
		}
	
		
		

	}
}