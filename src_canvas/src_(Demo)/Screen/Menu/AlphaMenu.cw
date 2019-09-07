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
	public class AlphaMenu extends Clip {
		
		private var oSliderAlpha : Slider;

		private var nStartX : Int = 11p;
		private var nStartY : Int = 44p;
		private var nSpaceY : Int = 51p;
		
		//private var oSelect : Clip = null;
		private var oSelect : ButtonImg = null;
		
		private var oBack : Img;
	
		public function AlphaMenu( _oParent : Root, _nX: Float, _nY:Float):Void {
			
			Clip(_oParent : Root, _nX, _nY);
			
			oSliderAlpha = new Slider(this, nStartX, nStartY , false, 100, 180, 255);

			oBack = new Img(this, 0p , 0p,  E"Resource:Slider/AlphaMenu.png", false);
		}
		
		public function fSetAssociateClip( _oClip : ButtonImg):Void {
			oSelect = _oClip;
		}
		
		override public function fUpdateParentToChild():Void {
		
			if(oSliderAlpha.oSlider.bDrag  ){
			//	oSelect.fToAlpha(oSliderAlpha.nPc);
			}
			
		}
	
		
		

	}
}