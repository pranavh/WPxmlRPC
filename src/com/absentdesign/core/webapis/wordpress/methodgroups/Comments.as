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
	* concrete WPMethodGroup for manipulating Comments 
	*/
	public class Comments extends WPMethodGroup{
		
		public function Comments(service:WPService){
			super(service);
		}
		
		/**
		* Wrapper for wp.newComment - create a new comment
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.NEW_COMMENT with a struct
		* as the WPServiceEvent.data once loaded</p>
		*
		* <p>wp.newComment only seems to be able to add comments authored by the logged in user as per the 
		* username/password on <code>service</code>), and will ignore any <code>author</code> info on <code>comment</code>
		* You can, however use <code>editComment</code> to change the author details on a comment, regardless of the 
		* logged in user</p>
		* @param postId the id of the post to add the comment to
		* @param comment the new comment
		*/
		public function newComment(postId:int,comment:Comment):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.newComment",
				[blogId,username,password,postId,comment],
				WPMethodGroupHelper.NEW_COMMENT,
				WPServiceEvent.NEW_COMMENT
			);
			loadRequest(request,newComment,postId,comment);
		}
		
		/**
		* Wrapper for wp.editComment - edit an existing comment
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.EDIT_COMMENT with a struct
		* as the WPServiceEvent.data once loaded</p>
		* @param commentId the id the comment
		* @param comment the replacement comment
		*/
		public function editComment(commentId:int,comment:Comment):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.editComment",
				[blogId,username,password,commentId,comment],
				WPMethodGroupHelper.EDIT_COMMENT,
				WPServiceEvent.EDIT_COMMENT
			);
			loadRequest(request,editComment,commentId,comment);
		}
		
		/**
		* Wrapper for wp.deleteComment - delete a comment
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.DELETE_COMMENT with a struct
		* as the WPServiceEvent.data once loaded</p>
		* @param commentId the id the comment
		*/
		public function deleteComment(commentId:int):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.deleteComment",
				[blogId,username,password,commentId],
				WPMethodGroupHelper.DELETE_COMMENT,
				WPServiceEvent.DELETE_COMMENT
			);
			loadRequest(request,deleteComment,commentId);
		}
		
		/**
		* Wrapper for wp.getComment - gets an individual comment
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_COMMENT with a Comment 
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param commentId the id the comment
		*/
		public function getComment(commentId:int):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getComment",
				[blogId,username,password,commentId],
				WPMethodGroupHelper.PARSE_COMMENT,
				WPServiceEvent.GET_COMMENT
			);
			loadRequest(request,getComment,commentId);
		}
		
		/**
		* Wrapper for wp.getComments - gets a list of comments for a specific post
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_COMMENTS with an array of Comments 
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param postId the id of the post to edit
		* @param status a status string from CommentStatusList
		* @param offset 
		* @param number the number of comments to get
		*/
		public function getComments(postId:int,status:String="",offset:int=0,number:int=10):void{
			var struct:WPStruct = new WPStruct();
			struct.postId = postId;
			struct.status = status;
			struct.offset = offset;
			struct.number = number;
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getComments",
				[blogId,username,password,struct],
				WPMethodGroupHelper.PARSE_COMMENTS,
				WPServiceEvent.GET_COMMENTS
			);
			loadRequest(request,getComments,postId,status,offset,number);
		}
		
		
		
	}
	
}