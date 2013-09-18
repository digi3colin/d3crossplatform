package com.fastframework.module.d3crossplatform.controller {
	import com.fastframework.log.FASTLog;

	import flash.display.Sprite;
	import flash.system.Capabilities;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerHighResViewPort {
		public function ControllerHighResViewPort(mcVP : Sprite, lowResScale:Number) {
			FASTLog.instance().log('dpi:'+Capabilities.screenDPI, FASTLog.LOG_LEVEL_ACTION);
			if(Capabilities.screenResolutionX>320&&Capabilities.screenDPI>200){
				FASTLog.instance().log('using HighDPI', FASTLog.LOG_LEVEL_DETAIL);
				mcVP.scaleX = mcVP.scaleY = 1;
			}else{
				FASTLog.instance().log('using LowDPI', FASTLog.LOG_LEVEL_DETAIL);
				mcVP.scaleX = mcVP.scaleY = lowResScale;
			}
		}
	}
}
