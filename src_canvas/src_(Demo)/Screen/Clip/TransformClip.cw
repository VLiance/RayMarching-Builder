package  { 
	

	import GZ.GFX.Root;
	import GZ.Math;
	import GZ.GFX.Clip.ButtonImg;
	import GZ.GFX.Clip.Img;
	import GZ.GFX.Object;
	import GZ.GFX.Clip;
	
	/**
	 * @author Maeiky
	 */	
	public class TransformClip extends Clip {
		

		public var oBtnImg : ButtonImg;		
		public var oImg : Img;	
		
		public var oCornerTR : ButtonImg;		
		public var oCornerTL : ButtonImg;		
		public var oCornerBR : ButtonImg;		
		public var oCornerBL : ButtonImg;		
		
	
		public var oBorderT : ButtonImg;		
		public var oBorderB : ButtonImg;	
		public var oBorderR : ButtonImg;		
		public var oBorderL : ButtonImg;	
		
		
		public var oSkewT : ButtonImg;		
		public var oSkewB : ButtonImg;	
		public var oSkewR : ButtonImg;		
		public var oSkewL : ButtonImg;	
		

		public var n32bLimit : Int = 507p;	//512 - 1(0) - border(4)
		public var nAlpha : Int = 160;	
		public var bSizeMod : Bool = false;	
		public var nSizeDiff : Float = 0;	

		public function TransformClip( _oParent : Root, _nX: Float, _nY:Float):Void {
			Clip(_oParent, _nX, _nY);

			
			oCornerTR = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Corner.png");
			oCornerTL = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Corner.png");
			
			oCornerBR = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Corner.png");
			oCornerBL = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Corner.png");
			
			
			oBorderR = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Border.png");
			oBorderB = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Border.png");
			oBorderL = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Border.png");
			oBorderT = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Border.png");
			
			oSkewR = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Skew.png");
			oSkewB = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Skew.png");
			oSkewL = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Skew.png");
			oSkewT = new ButtonImg(this, 0p, 0p, E"Resource:Slider/Skew.png");
			/*
			oCornerTR.fSetAlpha(nAlpha);
			oCornerTL.fSetAlpha(nAlpha);
			oCornerBR.fSetAlpha(nAlpha);
			oCornerBL.fSetAlpha(nAlpha);
			
			oBorderT.fSetAlpha(nAlpha);
			oBorderR.fSetAlpha(nAlpha);
			oBorderL.fSetAlpha(nAlpha);
			oBorderB.fSetAlpha(nAlpha);
				
			oSkewR.fSetAlpha(nAlpha);
			oSkewB.fSetAlpha(nAlpha);
			oSkewL.fSetAlpha(nAlpha);
			oSkewT.fSetAlpha(nAlpha);
			*/
			oBtnImg = new ButtonImg(this, 250p, 130p, E"Resource:Transform.png", true);
			oImg = oBtnImg.oImg;
			oBtnImg.fSetOverPressBrightness(70,70,70,-70,-70,-70,35);
			
			fSetCornerOrientation();
		}
		
		
		override public function fUpdateParentToChild():Void {
		/*
		
			//nClipX += 40;
			//nClipY += 40;
			//oBtnImg.nRotation += 0.01;
			
			if (oCornerTR.bDrag) {
				oBtnImg.nRotation = fFindAngle(oWindow.nMouseX, oWindow.nMouseY, oBtnImg.nX, oBtnImg.nY) -  (fFindAngleFromZero(oBtnImg.oImg.rPtTR.nX, oBtnImg.oImg.rPtTR.nY) - oBtnImg.nRotation);
			}
			if (oCornerTL.bDrag) {
				oBtnImg.nRotation = fFindAngle(oWindow.nMouseX, oWindow.nMouseY, oBtnImg.nX, oBtnImg.nY) -  (fFindAngleFromZero(oBtnImg.oImg.rPtTL.nX, oBtnImg.oImg.rPtTL.nY) - oBtnImg.nRotation);
			}
			if (oCornerBR.bDrag) {
				oBtnImg.nRotation = fFindAngle(oWindow.nMouseX, oWindow.nMouseY, oBtnImg.nX, oBtnImg.nY) -  (fFindAngleFromZero(oBtnImg.oImg.rPtBR.nX, oBtnImg.oImg.rPtBR.nY) - oBtnImg.nRotation);
			}
			if (oCornerBL.bDrag) {
				oBtnImg.nRotation = fFindAngle(oWindow.nMouseX, oWindow.nMouseY, oBtnImg.nX, oBtnImg.nY)  - (fFindAngleFromZero(oBtnImg.oImg.rPtBL.nX, oBtnImg.oImg.rPtBL.nY) - oBtnImg.nRotation);
			}
		
			
				
			if (oBorderR.bDrag || oBorderL.bDrag ) {
				var _nInv : Float = 2.0;
				if (oBorderL.bDrag) {
					_nInv = -2.0;
				}
				if (bSizeMod == false) {
					bSizeMod = true;
					nSizeDiff = oImg.nShapeWidth - (fGetResizeDist() * _nInv);
				}else {
					oImg.nShapeWidth = fGetResizeDist() * _nInv + nSizeDiff;

				}
				fSetCornerOrientation();
				
			}else if (oBorderT.bDrag || oBorderB.bDrag ) {
				
				var _nInv : Float = 2.0;
				if (oBorderB.bDrag) {
					_nInv = -2.0;
				}
				if (bSizeMod == false) {
					bSizeMod = true;
					nSizeDiff = oImg.nShapeHeight - (fGetResizeDist(Math.nR90) * _nInv);
				}else {
					oImg.nShapeHeight = fGetResizeDist(Math.nR90) * _nInv + nSizeDiff;
		
				}
				fSetCornerOrientation();
				
				//////////////////////////////////
				/////////////////SKEW////////////////
				////////////////////////////////////
			///Y///
			}else if (oSkewR.bDrag || oSkewL.bDrag) {
			
				var _nInv : Float = 2.0;
				if (oSkewR.bDrag) {
					_nInv = -2;
				}
				
				if (bSizeMod == false) {
					bSizeMod = true;
					nSizeDiff = oImg.fGetSkewPixelY() - (fGetResizeDist(Math.nR90) * _nInv);
				}else {
					oImg.fSkewPixelY(   fGetResizeDist(Math.nR90) * _nInv + nSizeDiff);
				}
		
				
			///X///
			}else if  (oSkewT.bDrag || oSkewB.bDrag) {
					
					var _nInv : Float = 2.0;
					if (oSkewT.bDrag) {
						_nInv = -2.0;
					}
					
					if (bSizeMod == false) {
						bSizeMod = true;
						nSizeDiff = oImg.fGetSkewPixelX() - (fGetResizeDist() * _nInv);
					}else {
						oImg.fSkewPixelX( fGetResizeDist() * _nInv  + nSizeDiff );
					}
				
			/////////////////////////////////////////	
			}else {
				bSizeMod = false;
			}
			
			*/

			
			
		}
		
		public function fSetCornerOrientation():Void {
			
			oCornerTL.oImg.nShapeWidth = -8p * oImg.nDirWidth;
			oCornerTL.oImg.nShapeHeight = 8p * oImg.nDirHeight;
			
			oCornerBL.oImg.nShapeWidth = -8p * oImg.nDirWidth;
			oCornerBL.oImg.nShapeHeight = -8p * oImg.nDirHeight;
			
			oCornerTR.oImg.nShapeWidth = 8p * oImg.nDirWidth;
			oCornerTR.oImg.nShapeHeight = 8p * oImg.nDirHeight;
			
			oCornerBR.oImg.nShapeWidth = 8p * oImg.nDirWidth;
			oCornerBR.oImg.nShapeHeight = -8p * oImg.nDirHeight;

		}
		
		 public function fGetResizeDist( _nOff : Float = 0):Float {
			var _nAngle : Float;
			var _nDistance : Float;
			_nAngle  = fFindAngle(oWindow.nMouseX, oWindow.nMouseY, oBtnImg.nX  , oBtnImg.nY ) ;
			_nDistance = fGetDistance(oWindow.nMouseX  , oWindow.nMouseY , oBtnImg.nX, oBtnImg.nY);
			return   (Math.fCos(_nAngle - oBtnImg.nRotation + _nOff) * (_nDistance ) );
		 }
		
		
		override public function fUpdateChildToParent():Void {
			/*
			oCornerTR.nClipX = oImg.nLimTRx +  oBtnImg.nClipX;
			oCornerTR.nClipY = oImg.nLimTRy +  oBtnImg.nClipY;
			oCornerTR.nRotation = oBtnImg.nRotation;
			
			oCornerTL.nClipX = oImg.nLimTLx +  oBtnImg.nClipX;
			oCornerTL.nClipY = oImg.nLimTLy +  oBtnImg.nClipY;
			oCornerTL.nRotation = oBtnImg.nRotation;
			
			oCornerBR.nClipX = oImg.nLimBRx +  oBtnImg.nClipX;
			oCornerBR.nClipY = oImg.nLimBRy +  oBtnImg.nClipY;
			oCornerBR.nRotation = oBtnImg.nRotation;
			
			oCornerBL.nClipX = oImg.nLimBLx +  oBtnImg.nClipX;
			oCornerBL.nClipY = oImg.nLimBLy +  oBtnImg.nClipY;
			oCornerBL.nRotation = oBtnImg.nRotation;
			
			
			oBorderR.nClipX = (oImg.nLimTRx + oImg.nLimBRx) / 2 +  oBtnImg.nClipX;
			oBorderR.nClipY = (oImg.nLimTRy + oImg.nLimBRy) / 2  +  oBtnImg.nClipY;
			oBorderR.nRotation = oBtnImg.nRotation;
			
			oBorderB.nClipX = (oImg.nLimBLx + oImg.nLimBRx) / 2 +  oBtnImg.nClipX;
			oBorderB.nClipY = (oImg.nLimBLy + oImg.nLimBRy) / 2  +  oBtnImg.nClipY;
			oBorderB.nRotation = oBtnImg.nRotation + Math.nR90;
			
			oBorderL.nClipX = (oImg.nLimTLx + oImg.nLimBLx) / 2 +  oBtnImg.nClipX;
			oBorderL.nClipY = (oImg.nLimTLy + oImg.nLimBLy) / 2  +  oBtnImg.nClipY;
			oBorderL.nRotation = oBtnImg.nRotation;
			
			oBorderT.nClipX = (oImg.nLimTLx + oImg.nLimTRx) / 2 +  oBtnImg.nClipX;
			oBorderT.nClipY = (oImg.nLimTLy + oImg.nLimTRy) / 2  +  oBtnImg.nClipY;
			oBorderT.nRotation = oBtnImg.nRotation + Math.nR90;
			
			oSkewR.nClipX = oBorderR.nClipX;
			oSkewR.nClipY = oBorderR.nClipY;
			oSkewR.nRotation = oBorderR.nRotation;
			
			oSkewB.nClipX = oBorderB.nClipX;
			oSkewB.nClipY = oBorderB.nClipY;
			oSkewB.nRotation = oBorderB.nRotation;
			
			oSkewT.nClipX = oBorderT.nClipX;
			oSkewT.nClipY = oBorderT.nClipY;
			oSkewT.nRotation = oBorderT.nRotation;
			
			oSkewL.nClipX = oBorderL.nClipX;
			oSkewL.nClipY = oBorderL.nClipY;
			oSkewL.nRotation = oBorderL.nRotation;
			*/
		}
		
		public function fFindAngleFromZero(_nX:Float, _nY : Float):Float {
			//_rLine
			return Math.fATan2(_nY, _nX);
		}
				
		public function fFindAngle( _n1x:Float, _n1y : Float, _n2x : Float, _n2y : Float):Float {
			//_rLine
			return Math.fATan2(_n1y - _n2y, _n1x - _n2x);
		}
		
		public function fGetDistance( _nFx:Float, _nFy : Float, _nTx : Float, _nTy : Float):Int {

			return  Math.fSqrt(  Math.fPow( _nFx-  _nTx , 2 )  +   Math.fPow( _nFy -  _nTy, 2 )  );
		}
		
		/*
				//overrided!!
		override public function fDrawObject(_oSource : Object, _nX_Start:Int, _nX_End:Int, _nY_Start:Int, _nY_End:Int ):Void {
				
			dispatchRender(_oSource, _nX_Start + nPosX, _nX_End  + nPosX,  _nY_Start + nPosY, _nY_End+ nPosY);
			
		}*/
		
	}
}