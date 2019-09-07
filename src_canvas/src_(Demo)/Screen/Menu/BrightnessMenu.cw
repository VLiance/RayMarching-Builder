package  { 

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
	public class BrightnessMenu extends Clip {
		
		private var oSliderAll : Slider;
		private var oSliderRed : Slider;
		private var oSliderGreen : Slider;
		private var oSliderBlue : Slider;
		
		private var nStartX : Float = 11;
		private var nStartY : Float = 44;
		private var nSpaceY : Float = 51;
		
		private var oSelect : Clip;
		
		private var oBack : Img;
	
		public function BrightnessMenu( _oParent : Root, _nX: Float, _nY:Float):Void {
			
			Clip(_oParent , _nX, _nY);
			
			
			oSliderAll = new Slider(this, nStartX, nStartY, true, 165, 165, 185);
			oSliderRed = new Slider(this, nStartX, nStartY + nSpaceY, true, 150, -75, -75);
			oSliderGreen = new Slider(this, nStartX, nStartY + nSpaceY * 2, true, -75, 130, -75);
			oSliderBlue = new Slider(this, nStartX,  nStartY + nSpaceY * 3, true, -75, -75, 150);
			
			
			oBack = new Img(this, 0p , 0p,  E"Resource:Slider/BrightnessMenu.png", false);
		}
		
		public function fSetAssociateClip( _oClip : Clip):Void {
			oSelect = _oClip;
		}
		
		override public function fUpdateParentToChild():Void {
			if(oSliderAll.oSlider.bDrag){
				//oSelect.fToLight(oSliderAll.nPc, 2);
			}
			if(oSliderRed.oSlider.bDrag  ||  oSliderGreen.oSlider.bDrag  ||  oSliderBlue.oSlider.bDrag ){
				//oSelect.fToBrRGB(oSliderRed.nPc, oSliderGreen.nPc, oSliderBlue.nPc, 2);
			}
			
		}
	
		
		

	}
}