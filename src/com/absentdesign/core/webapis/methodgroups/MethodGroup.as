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


package com.absentdesign.core.webapis.methodgroups{

	import com.absentdesign.core.webapis.Service;
	import com.absentdesign.core.webapis.ServiceRequest;
	import com.absentdesign.core.webapis.events.ServiceEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	
	import mx.rpc.events.FaultEvent;
	
	/**
	*  abstract MethodGroup for loading ServiceRequests
	*/	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	public class MethodGroup extends EventDispatcher{
		
		protected var service:Service;
		protected var helper:MethodGroupHelper;

		public function MethodGroup(service:Service,helper:MethodGroupHelper){
			this.service = service;
			this.helper = helper;
		}
		
		public function load(request:ServiceRequest):void{
			request.addEventListener(ServiceEvent.COMPLETE,processAndDispatch,false,0,true);
			request.load();
		}
		
		protected function processAndDispatch(event:Event):void{
			var request:ServiceRequest = event.target as ServiceRequest;
			request.removeEventListener(ServiceEvent.COMPLETE,processAndDispatch);
			service.dispatchEvent(new ServiceEvent(request.eventType,helper.parse(request.data,request.parseFunction)));
		}
		
		protected function dispatchFault(e:FaultEvent):void {
			dispatchEvent(e);
		}
		

		
	}


}

