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

	import com.terralever.util.Enumerator;
	import com.ak33m.rpc.xmlrpc.IXMLRPCStruct;
	
	/**
	*  abstract IXMLRPCStruct implementation for strongly typed WordPress structs
	*/
	dynamic public class WPStruct implements IXMLRPCStruct{

		public function WPStruct(){
			
		}
		
		/**
		* IXMLRPCStruct implementation to allow proper serialization
		* <p>null values are converted to empty strings to avoid being serialized as strings with a value of "null"</p>
		*
		* @return a weakly typed object containing all instance data that can be serialized by XMLRPCSerializer
		*/
		public function getPropertyData():*{
			var e:Enumerator = Enumerator.create(this);
			var key:Object;
			var data:Object = new Object();
			while(key = e.next()){
				data[key] = this[key];
				if(data[key] == null){
					data[key] = "";
				}
			}
			return data;
		}
		
		/**
		* @return a string listing all properties of this object
		*/
		public function getDump():String{
			var e:Enumerator = Enumerator.create(this);
			var key:Object;
			var str:String = this+"\n";
			while(key = e.next()){
				str += "   "+key +":"+ this[key] + "\n";
			}
			return str;
		}
		

	}


}

