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
	
	/*
	'title'=>$title,
	'description'=>$body,
	'mt_allow_comments'=>0,  // 1 to allow comments
	'mt_allow_pings'=>0,  // 1 to allow trackbacks
	'post_type'=>'post',
	'categories'=>$categories,
	'tags'=>$tags,
	'publish'=>1,
	'sticky'=>$sticky,
	*/
	public class Post extends WPStruct{
		
		public var userid:String;
		public var dateCreated:Date;
		public var postid:int;
		public var description:String; //Contents of the post
		public var title:String; //Title of the post 
		public var link:String;
		public var permaLink:String;
		public var mt_excerpt:String;
		public var mt_text_more:String;
		public var mt_allow_comments:int;
		public var mt_allow_pings:int;
		public var mt_convert_breaks:String;
		public var mt_keywords:String;
		public var post_type:String="post";
		public var categories:Array;
		public var sticky:Boolean;
		public var publish:int=1;
		
	}
	
}