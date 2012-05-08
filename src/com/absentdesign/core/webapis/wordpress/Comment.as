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
	
	/**
	*  concrete WPStruct 
	*/
	public class Comment extends WPStruct{
		
		public var date_created_gmt:Date;
		public var user_id:String;
		public var comment_id:String;
		public var parent:String;
		public var status:String;
		public var content:String;
		public var link:String;
		public var post_id:String;
		public var post_title:String;
		public var author:String;
		public var author_url:String;
		public var author_email:String;
		public var author_ip:String;
		public var comment_parent:int;
	}
	
}

