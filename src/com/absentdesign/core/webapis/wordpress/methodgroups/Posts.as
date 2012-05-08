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

	/**
	* concrete WPMethodGroup for manipulating Posts 
	*/
	public class Posts extends WPMethodGroup{

		public function Posts(service:WPService){
			super(service);
		}
		
		/**
		 * Wrapper for metaWeblog.deletePost - deletes a single post
		 * <p>Will dispatch a ServiceEvent of type WPServiceEvent.DELETE_POST with a struct 
		 * as the WPServiceEvent.data once loaded</p>
		 * 
		 * @param postId The id of the post to delete
		 */
		public function deletePost(postId:int):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"metaWeblog.deletePost",
				[0,postId,username,password,true],
				WPMethodGroupHelper.DELETE_POST,
				WPServiceEvent.DELETE_POST
			);
			
			loadRequest(request,deletePost,postId);
		}
		
		/**
		 * Wrapper for metaWeblog.getPost - gets a single post
		 * <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_POST with a Post 
		 * as the WPServiceEvent.data once loaded</p>
		 * 
		 * @param postId The id of the post to retreive
		 */
		public function getPost(postId:int):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"metaWeblog.getPost",
				[postId,username,password],
				WPMethodGroupHelper.PARSE_POST,
				WPServiceEvent.GET_POST
			);
			loadRequest(request,getPost,postId);
		}
		
		/**
		* Wrapper for metaWeblog.newPost - add a new Post
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.NEW_POST once loaded</p>
		* 
		* @param content the new Post
		* @param publish whether to publish immediately or save as a draft
		*/
		public function newPost(content:Post,publish:Boolean):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"metaWeblog.newPost",
				[blogId,username,password,content,publish],
				WPMethodGroupHelper.NEW_POST,
				WPServiceEvent.NEW_POST
			);
			loadRequest(request,newPost,content,publish);
		}
		
		
		/**
		* Wrapper for metaWeblog.getRecentPosts - gets an array of recent posts
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_RECENT_POSTS with an Array 
		* of posts as the WPServiceEvent.data once loaded</p>
		* 
		* @param count The number of posts to retreive. If you want all posts just use a really high number (999999)
		*/
		public function getRecentPosts(count:uint = 10):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"metaWeblog.getRecentPosts",
				[blogId,username,password,count],
				WPMethodGroupHelper.PARSE_RECENT_POSTS,
				WPServiceEvent.GET_RECENT_POSTS
			);
			loadRequest(request,getRecentPosts,count);
		}
		
		/**
		* Wrapper for metaWeblog.editPost - edit a specific post
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.EDIT_POST with a struct
		* as the WPServiceEvent.data once loaded</p>
		* 
		* @param postId the id of the post to edit
		* @param content the new post data
		* @param publish whether to publish immediately or save as a draft 
		*/
		public function editPost(postId:int,post:Post,publish:Boolean):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"metaWeblog.editPost",
				[postId,username,password,post,publish],
				WPMethodGroupHelper.EDIT_POST,
				WPServiceEvent.EDIT_POST
			);
			loadRequest(request,editPost,postId,post,publish);
		}
		
		/**
		* Wrapper for mt.getRecentPostTitles - gets a bandwidth friendly an array of recent posts
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_RECENT_POST_TITLES with an Array 
		* of Posts as the WPServiceEvent.data once loaded</p>
		* 
		* @param numberOfPosts The number of posts to retreive. If you want all weblog posts just use a really high number (999999)
		*/
		public function getRecentPostTitles(numberOfPosts:uint = 10):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"mt.getRecentPostTitles",
				[blogId,username,password,numberOfPosts],
				WPMethodGroupHelper.PARSE_RECENT_POST_TITLES,
				WPServiceEvent.GET_RECENT_POST_TITLES
			);
			loadRequest(request,getRecentPostTitles,numberOfPosts);
		}


	}


}

