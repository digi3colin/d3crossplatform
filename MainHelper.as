package com.fastframework.module.d3crossplatform {
	import asset.MainView;

	import com.fastframework.module.d3mobile.MobileProfile;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	//MainHelper to make sure application start after all asset loaded.
	public class MainHelper implements IMain {
		private var delegate:IMain;
		private var main:Sprite;

		public function MainHelper(main:Sprite, mcVP:MainView,delegate:IMain,platform:IPlatform) {
			//setup stage align
			this.delegate = delegate;
			this.main = main;

			main.stage.align 	 = StageAlign.TOP_LEFT;
			main.stage.scaleMode = StageScaleMode.NO_SCALE;

			//platform specify setup.
			platform.setup(mcVP);

			main.addEventListener(Event.EXIT_FRAME, doNextFrame);
		}

		private function doNextFrame(e : Event) : void {
			main.removeEventListener(Event.EXIT_FRAME, doNextFrame);
			MobileProfile.STAGE = main.stage;
			start();
		}

		public function start() : void {
			delegate.start();
			main = null;
			delegate = null;
		}
	}
}
