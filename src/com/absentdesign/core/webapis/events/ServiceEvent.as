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


package com.absentdesign.core.webapis.events{

	import com.ak33m.rpc.xmlrpc.XMLRPCSerializer;
	
	import flash.events.Event;
	
	import mx.utils.ObjectUtil;

	/**
	* abstract event for use with Service calls
	*/
	public class ServiceEvent extends Event{
		
		public static var LOAD:String = "serviceEventLoad";
		public static var COMPLETE:String = "serviceEventComplete";

		private var _data:Object = new Object();
		private var _method:String="";
		private var req:Array;
		private var resp:Array;
		
		/**
		* @param type The event type 
		* @param data The data to send with the event
		*/
		public function ServiceEvent(type:String, data:Object = null, rpcRequest:Object=null, bubbles:Boolean = false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			this.data = data;
			if(rpcRequest) {
				if(rpcRequest is String) {
					this.method=rpcRequest.toString();
					this.resp=null;
					this.req=null;
				} else {
					this.method = rpcRequest.method;
					this.req = rpcRequest.request as Array;
					this.resp = rpcRequest.response as Array;
				}
			}
			
		}

		public function get data():Object{
			return _data;
		}

		public function set data(d:Object):void{
			_data = d;
		}
		
		public function get method():String {
			return _method;
		}
		
		public function set method(m:String):void {
			_method=m;
		}
		
		public function get request():Array {
			return req;
		}
		
		public function get response():Array {
			return resp;
		}
		
		public function get requestXML():XML {
			return XMLRPCSerializer.serialize(this.method, this.req);
		}
		
		public function get responseString():String {
			return ObjectUtil.toString(this.resp);
		}
		

	}


}
