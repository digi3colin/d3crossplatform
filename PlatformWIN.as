﻿package com.fastframework.module.d3crossplatform {
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3crossplatform.controller.ControllerHighResViewPort;
	import flash.display.Sprite;



	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class PlatformWIN implements IPlatform {
		public function setup(mcVP:Sprite):void
		{
			FASTLog.instance().log('Platform WIN');
			new ControllerHighResViewPort(mcVP,PlatformSetting.LOW_RES_SCALE);
		}

	}
}
