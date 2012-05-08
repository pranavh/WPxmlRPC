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


package com.absentdesign.core.webapis.wordpress{
	
	import com.absentdesign.core.webapis.events.ServiceEvent;
	import com.ak33m.rpc.core.RPCEvent;
	import com.ak33m.rpc.xmlrpc.XMLRPCObject;
	
	import flash.net.URLRequestDefaults;
	
	import mx.rpc.events.ResultEvent;
	
	/**
	*  wrapper for XMLRPCObject to make requests to WordPress XML-RPC
	*/
	public class WPServiceRequest extends XMLRPCObject{
		
		protected var service:WPService;
		protected var callMethod:String;
		protected var args:Array;
		public var parseFunction:String;
		public var eventType:String;
		public var data:*;
		public var userAgent:String="";
		
		
		/**
		* @param service The WPService that is making the request
		* @param callMethod The method that you are calling (eg wp.getPages)
		* @param args Any method arguments
		* @param parseFunction The parseFunction reference from WPMethodGroupHelper to parse the server response
		* @param eventType The event to dispatch once the response has been loaded successfully 
		*/
		public function WPServiceRequest(service:WPService,callMethod:String,args:Array,parseFunction:String,eventType:String){
			this.service = service;
			this.callMethod = callMethod;
			this.args = args;
			this.parseFunction = parseFunction;
			this.eventType = eventType;
			this.userAgent=service.userAgent;
		}
		
		/**
		* Load the request
		*/
		public function load():void{
			this.endpoint = service.endpoint;
			this.destination = WPService.XML_RPC;
			if(this.headers==null) {
				this.headers=new Object();
			}
			this.headers["User-Agent"]=this.userAgent;
			makeCall(callMethod,args);
		}
		
		/**
		* fired when the service call is complete and dispatches a ServiceEvent to let the WPMethodGroup know
		* that data is available
		*/
		override protected function onResult(evt:RPCEvent):void{
			var resultEvent:ResultEvent = ResultEvent(evt.data);
			super.onResult(evt);			
			data = resultEvent.result;
			var obj:Object={"method": callMethod, "request": args, "response": data};
			dispatchEvent(new ServiceEvent(ServiceEvent.COMPLETE,data,obj));
		}
		
	}
	
}