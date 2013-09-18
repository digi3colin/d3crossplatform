package com.fastframework.module.d3crossplatform {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * @author Digi3Studio - Colin Leung
	 * consolidate the keyboard and mouse input
	 */
	public class UserInput extends FASTEventDispatcher implements IFASTEventDispatcher{
		public static const CLICK:String 		= MouseEvent.CLICK;
		public static const MOUSE_DOWN:String 	= MouseEvent.MOUSE_DOWN;
		public static const MOUSE_MOVE:String 	= MouseEvent.MOUSE_MOVE;
		public static const MOUSE_UP:String 	= MouseEvent.MOUSE_UP;
		public static const KEY_DOWN:String 	= KeyboardEvent.KEY_DOWN;
		public static const KEY_UP:String 		= KeyboardEvent.KEY_UP;

		public var target:Object;
		public var isMouseDown:Boolean=false;

		private var _enable:Boolean = true;
		private var listenMove : Boolean;
		private var stage : Stage;

		public function UserInput(stage:Stage) {
			if(stage==null)throw new Error('stage is undefined');
			this.stage = stage;
			stage.addEventListener(KeyboardEvent.KEY_UP,   this.forwardKeyboardEvent,false,9999);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.forwardKeyboardEvent,false,9999);
			stage.addEventListener(MouseEvent.CLICK,   	   this.up,false,9999);
			stage.addEventListener(MouseEvent.MOUSE_UP,    this.up,false,9999);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,  this.down,false,9999);
		}

		public override function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false):void{
			//mouse move is demanding... only add on require..
			if(listenMove!=true && type==MouseEvent.MOUSE_MOVE){
				stage.addEventListener(MouseEvent.MOUSE_MOVE, this.move, false, priority, useWeakReference);
				listenMove = true;
			}

			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		private function down(e:MouseEvent):void{
			isMouseDown = true;
			forwardMouseEvent(e);
		}

		private function up(e:MouseEvent):void{
			isMouseDown = false;
			forwardMouseEvent(e);
		}
		
		private function move(e:MouseEvent):void{
			if(this.hasEventListener(MouseEvent.MOUSE_MOVE)){
				forwardMouseEvent(e);
			}else{
				//clean up if no more move event
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.move);
				listenMove = false;
			}
		}

		private function forwardMouseEvent(e:MouseEvent):void{
			if(_enable==false)return;
			this.target = e.target;
			dispatchEvent(e);
		}

		private function forwardKeyboardEvent(e:KeyboardEvent):void{
			if(_enable==false)return;
			this.target = e.target;
			dispatchEvent(e);
		}

		public function enable():void{
			_enable = true;
		}

		public function disable():void{
			_enable = false;
		}

		public function getObjectsUnderPoint():Array{
			return this.stage.getObjectsUnderPoint(new Point(stage.mouseX,stage.mouseY));
		}
		
		public function getMousePosition():Point{
			return new Point(stage.mouseX,stage.mouseY);
		}
	}
}
