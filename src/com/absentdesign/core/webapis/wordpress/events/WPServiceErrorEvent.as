package com.absentdesign.core.webapis.wordpress.events
{
	import flash.events.ErrorEvent;
	
	public class WPServiceErrorEvent extends ErrorEvent
	{
		public function WPServiceErrorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, text:String="", id:int=0)
		{
			super(type, bubbles, cancelable, text, id);
		}
		
		public static const CONNECTION_ERROR:String="connectionError";
	}
}