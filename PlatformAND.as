package com.fastframework.module.d3crossplatform {
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3crossplatform.controller.ControllerHighResViewPort;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class PlatformAND implements IPlatform {
		public function setup(mcVP:Sprite):void
		{
			FASTLog.instance().log('Platform AND');
			new ControllerHighResViewPort(mcVP,0.5);

			if(Capabilities.cpuArchitecture=="ARM")
			{
				NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
				NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
			}
		}

		private function handleActivate(event:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		 
		private function handleDeactivate(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		 
		private function handleKeys(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			NativeApplication.nativeApplication.exit();
		}
	}
}
