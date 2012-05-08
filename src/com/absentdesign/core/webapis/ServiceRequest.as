/**
 * Copyright (c) 2009, Reuben Stanton
	All rights reserved.
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the 
	following conditions are met:
	
	    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following 
		  disclaimer.
	    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the 
		  following disclaimer in the documentation and/or other materials provided with the distribution.
	    * The name "Reuben Stanton" may not be used to endorse or promote products derived from this software without 
		  specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


package com.absentdesign.core.webapis{
	
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.absentdesign.core.webapis.events.ServiceEvent;


	public class ServiceRequest extends EventDispatcher{
		
		protected var method:String;
		public var parseFunction:String; 
		public var eventType:String;
		public var data:String;
		

		public function ServiceRequest(method:String,parseFunction:String,eventType:String){
			this.method = method;
			this.parseFunction = parseFunction;
			this.eventType = eventType;
		}
		
		public function load():void{
			var loader:URLLoader = new URLLoader();
			dispatchEvent(new ServiceEvent(ServiceEvent.LOAD,loader));
			loader.addEventListener(Event.COMPLETE,loadCompleteHandler);
			loader.load(new URLRequest(method));
		}
		
		protected function loadCompleteHandler(event:Event):void{
			var loader:URLLoader = event.target as URLLoader;
			data = loader.data;
			loader.removeEventListener(Event.COMPLETE,loadCompleteHandler);
			dispatchEvent(new ServiceEvent(ServiceEvent.COMPLETE,loader));
		}
		


	}


}

