package  { 
	
	import GZ.Sys.Interface.Interface;
	
	
	//import GZ.Gfx.Object;
//	import GZ.Gfx.Screen.Redraw;
	
	import GZ.Sys.Interface.Window;
	//import GZ.File.RcImg;
//	import GZ.Gfx.Root;
	
	
	//import GZ.Gfx.Clip.Img;
	import GZ.Gfx.Clip;
	
	
	import Demo.Screen.DemoRoll;
	//import Demo.Screen.FpsCount;
	import Demo.Screen.DemoText;
	
	/*
	import Demo.Screen.DemoPerspective;
	import Demo.Screen.DemoSideScroller.DemoSideScroller;
	import Demo.Screen.DemoText;
	import Demo.Screen.DemoArrow;
	*/
 
	import GZ.Base.Math.Math;
	
	import GZ.Base.Thread.Thread;
	import GZ.Sys.ThreadItf;
	
	import GZ.Base.Mat4x4;
	import GZ.Base.Perspective;
	
	/*
	<cpp>
		int oRcObj_Rc_GZ_RcEngine_Transform_png;
	</cpp>
	*/
	/**
	 * @author Maeiky
	 */	
	public thread<ThreadItf> MainInterface extends Interface {
		
		use Window.eWinClick;
		use Window.eWinBorder;
		
		public var oDemo : Clip;
	//	public var oFps : FpsCount;
		
//		public var oImg : Img;
		
	//	public evar mTest : Mat4x4;
//		public var oPersv : Perspective;
		
	
		public function MainInterface( _oThreadItf : ThreadItf ):Void {
			//!New thread started, this and subclass are isolated for thread safety
			//!Select rendering on GPU on CPU, default, true
			
			//Debug = new Debug();
			//Lib_GZ::Sys::Debug::SetInst(oMain->thread) = Lib_GZ::Sys::Debug::Get(oMain->thread)->New(oMain.get()).get();
	
			Debug.fTrace("!!!!!!!!!!!!!MainInterface!!!!");
			
			//bGpuDraw = false;
			bGpuDraw = true;
			
			
			//!Make window transparent (Render or CPU)
			var _bTranparent : Bool = false;
			_bTranparent = false;
			
			//Create a new windows
			Interface(_oThreadItf, "GroundZero", 800, 600, _bTranparent, 0xFFFFFFFF);
			//, eWinBorder.Normal, true, true, true, _bCpuGraphique);
		
			
			//fCreateInterface();
			fCreateInterface(300,100);
		}
		
		override public function fWinStart():Void {
			Debug.fPass(" ---- Interface C~ initialised ----");
			//!The windows was created
			//-------------------------------
			//! Select your demo
			var _nDemo : Int = 1;
			//-------------------------------
		
		Debug.fTrace("---WinStart");
		
		
		Debug.fTrace("---DemoRoll");
		oDemo = new DemoRoll(this);
		//oDemo = new DemoText(this);
					
		//		Debug.fTrace1("---FpsCount");
		//	oFps = new FpsCount(this, oItf.nFrameWidth - 150, 30);
			
		//	oDemo = new DemoText(this);
			
			/*
			if(_nDemo == 1){
				oDemo = new DemoRoll(this);
			}else if(_nDemo == 2){
				oDemo = new DemoPerspective(this);
			}else if(_nDemo == 3){
				oDemo = new DemoSideScroller(this);
			}else if(_nDemo == 4){
				oDemo = new DemoText(this);
			}else if(_nDemo == 5){
				oDemo = new DemoArrow(this);
			
			}*/
			
			//oPersv = new Perspective();
			
			//Debug.fTrace2(oPersv.mProj.v3.nZ);
				
			//	mTest.v3.nW = 21;
		}
		
		
		override public function fUpdateChildToParent():Void {
			//!Updated each frame, parents before
		}
		
		
		override public function fUpdateParentToChild():Void {
			//!Updated each frame, childs before
		}
		
	}
}