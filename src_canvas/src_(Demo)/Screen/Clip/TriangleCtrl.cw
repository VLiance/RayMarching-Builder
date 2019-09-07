package  { 
	
	import GZ.GFX.Root;
	import GZ.Math;
	import GZ.GFX.Clip.ButtonImg;
	import GZ.GFX.Clip.TriangleClip;
	import GZ.GFX.Clip.Img;
	import GZ.GFX.Clip.Sprite;
	import GZ.GFX.Object;
	import GZ.GFX.Face;
	import GZ.GFX.Clip;
	
	
	/**
	 * @author Maeiky
	 */	
	public class TriangleCtrl extends Clip {
		
		
		public var oImg : TriangleClip;		
	//	public var oBaseForm : BaseForm;		
		public var oSprite : Sprite;		

	
		public var oBorderTL : Img;		
		public var oBorderTR : Img;		
		public var oBorderC : Img;	
		public var oBorderBL : Img;		
		public var oBorderBR : Img;		

		
		public var n32bLimit : Int = 507p;	//512 - 1(0) - border(4)
		public var nAlpha : Int = 160;	
		public var bSizeMod : Bool = false;	
		public var nSizeDiff : Float = 0;	

		public var nTriPosX : Float = 250;
		public var nTriPosY : Float = 130;
		
		public function TriangleCtrl( _oParent : Root, _nX: Float, _nY:Float):Void {
			Clip(_oParent, _nX, _nY);
			
			/*
			oBorderC = new Img(this, nTriPosX , nTriPosY, E"Resource:Slider/Border.png");
			oBorderTL = new Img(this, nTriPosX - 62, nTriPosY - 62, E"Resource:Slider/Border.png");
			
			oBorderTR = new Img(this, nTriPosX + 62, nTriPosY - 62, E"Resource:Slider/Border.png");
			oBorderBR = new Img(this, nTriPosX + 62, nTriPosY + 62, E"Resource:Slider/Border.png");
			oBorderBL = new Img(this, nTriPosX - 62, nTriPosY + 62, E"Resource:Slider/Border.png");
			
	*/
			
			//oImg = new TriangleClip(this, _nPosX, _nPosY, E"Resource:Transform.png", true);
			
			//oBaseForm  = new BaseForm(this, nTriPosX, nTriPosY, E"Resource:Transform.png", true);
			oSprite  = new Sprite(this, nTriPosX, nTriPosY, E"Resource:Transform.png", true);
		
			fSetCornerOrientation();
		}
		
		
		override public function fUpdateParentToChild():Void {
			
				
			oSprite.nRotation += 0.005;
			oSprite.nParYaw += 0.05;
			//oSprite.nParPitch += 0.15;
			
			/*
			oImg.rPtTR.nX =  oBorderT.nX - oImg.nX;
			oImg.rPtTR.nY =  oBorderT.nY - oImg.nY;
			
			oImg.rPtBR.nX =  oBorderC.nX - oImg.nX;
			oImg.rPtBR.nY =  oBorderC.nY - oImg.nY;
			
			oImg.rPtBL.nX =  oBorderB.nX - oImg.nX;
			oImg.rPtBL.nY =  oBorderB.nY - oImg.nY;
			oImg.rPtTL.nX =  oBorderB.nX - oImg.nX;
			oImg.rPtTL.nY =  oBorderB.nY - oImg.nY;
			*/
			/*
			oBaseForm.aPoint3D[0] = oBorderC.nX  - oBaseForm.nX;
			oBaseForm.aPoint3D[1] = oBorderC.nY - oBaseForm.nY;
			oBaseForm.aPoint3D[2] = 1;
			*/
			
			/*
			oSprite.rPtTR.nX =  nTriPosX + 62 - oSprite.nX;
			oSprite.rPtTR.nY =  nTriPosY - 62 - oSprite.nY;
			
			oSprite.rPtBR.nX =  nTriPosX + 62 - oSprite.nX;
			oSprite.rPtBR.nY =  nTriPosY + 62 - oSprite.nY;
			
			oSprite.rPtBL.nX =   nTriPosX - 62 - oSprite.nX;
			oSprite.rPtBL.nY =   nTriPosY + 62 - oSprite.nY;
			
			oSprite.rPtTL.nX =  nTriPosX - 62 - oSprite.nX;
			oSprite.rPtTL.nY =  nTriPosY - 62 - oSprite.nY;
			*/
			
		//	oSprite.rPtTR.nZ = 44;
		//	oSprite.rPtBR.nZ = 44;
			
			
			
			
			
			/*
			oBaseForm.aPoint3D[3] = oBorderTL.nX - oBaseForm.nX;
			oBaseForm.aPoint3D[4] = oBorderTL.nY  - oBaseForm.nY;
			oBaseForm.aPoint3D[5] = 0;
			
			oBaseForm.aPoint3D[6] = oBorderTR.nX  - oBaseForm.nX;
			oBaseForm.aPoint3D[7] = oBorderTR.nY - oBaseForm.nY;
			oBaseForm.aPoint3D[8] = 44;
			
			oBaseForm.aPoint3D[9] = oBorderBR.nX  - oBaseForm.nX;
			oBaseForm.aPoint3D[10] = oBorderBR.nY - oBaseForm.nY;
			oBaseForm.aPoint3D[11] = 44;
			
			oBaseForm.aPoint3D[12] = oBorderBL.nX  - oBaseForm.nX;
			oBaseForm.aPoint3D[13] = oBorderBL.nY - oBaseForm.nY;
			oBaseForm.aPoint3D[14] = 0;
			*/
			
		}
		
		public function fSetCornerOrientation():Void {

		}
		

		
		override public function fUpdateChildToParent():Void {

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