package  { 
	
	import GZ.GFX.Object;

	import GZ.File.RcImgSequence;
	import GZ.File.RcImg;
	import GZ.GFX.Root;
	
	import GZ.GFX.Interface;
	import GZ.GFX.Clip;

	import GZ.Math;
	import GZ.Input.Key;
	
	import GZ.GFX.MovieClip;
	import GZ.GFX.Tile.LayerClip;
	import Demo.Screen.DemoSideScroller.Perso;
	
	import GZ.Sff.Xml.Xml;
	import GZ.Sff.Xml.XmlNode;
	import GZ.Sff.Xml.XmlElement;
	import GZ.Sff.Xml.XmlText;
	
	import GZ.Sff.Tmx.Tmx;
	
	
	
	/**
	 * @author Maeiky
	 */	
	public class DemoSideScroller extends Clip {
		
		//use XmlNode.eType;

		public var oXml : Xml;
		public var oCurrNode : XmlNode;
		
		
	
		public var oTmx : Tmx;
		public var oMainLayer : LayerClip;

		
		
		public var oPerso : Perso;
				
		public var nTime : Int;
		
		
		public function DemoSideScroller( _oParent : Root ):Void {
			Clip(_oParent, 0.0, 0.0);
			
			/*
			oXml = new Xml("MyFirstTiles.tmx");
			if(oXml.fLoad()){
				oCurrNode = oXml.fFirst();
				if(oCurrNode.hType == XmlNode.eType.Element){
					var _oElement : XmlElement = oCurrNode;
					Debug.fTrace1("XML Version : " + _oElement.fAttribute("version"));
				}
			}*/
			
			//!Create an image
			oPerso = new Perso(this, 300.0, 500.0);
			oPerso.fAddSequence( E"MegaSam/Walk", 0, 0, true);
			
			oTmx = new Tmx("MyFirstTiles.tmx");
			if(oTmx.fLoad()){
				
			}
			
			oMainLayer = new LayerClip(this, oTmx.oMainMap.aLayer[0], 0, 0);
			
			
			EnYaw(5);
			EnPitch(5);
		}

		
		override public function fUpdateParentToChild():Void {
			/*
			nTime++;
			
			if(nTime == 5){
				TnYaw(3.1416/2.0);
			}
			
			if(nTime == 3000){
				TnYaw(0);
				nTime = 0;
			}*/
			WnX(80);
			WnY(50);
			
			//!Updated each frame, parents before
			var _nMouseX : Float = oItf.oWindow.nMouseX - oItf.nHalfFrameWidth;
			var _nMouseY : Float = oItf.oWindow.nMouseY - oItf.nHalfFrameHeight;

			//!Updated each frame, parents before
			TnYaw(_nMouseX / oItf.nHalfFrameWidth / -1.15);
			TnPitch(_nMouseY /oItf.nHalfFrameHeight / -1.15);
			
			
		}
		


		
		
	}
}