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


package com.absentdesign.core.webapis.wordpress.methodgroups{
	
	import com.absentdesign.core.webapis.wordpress.events.WPServiceEvent;
	import com.absentdesign.core.webapis.wordpress.*;
	import com.absentdesign.core.webapis.events.*;

	/**
	* concrete WPMethodGroup for Authors
	*/
	public class Authors extends WPMethodGroup{

		public function Authors(service:WPService){
			super(service);
		}
		
		/**
		* Wrapper for wp.getAuthors - gets a list of the authors associated with this blog
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_AUTHORS with an array of authors 
		* as the WPServiceEvent.data once loaded</p>
		*/
		public function getAuthors():void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getAuthors",
				[blogId,username,password],
				WPMethodGroupHelper.PARSE_AUTHORS,
				WPServiceEvent.GET_AUTHORS
			);
			loadRequest(request,getAuthors);
		}


	}


}

