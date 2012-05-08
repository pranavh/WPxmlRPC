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
	* concrete WPMethodGroup for manipulating Categories 
	*/
	public class Categories extends WPMethodGroup{

		public function Categories(service:WPService){
			super(service);
		}
		
		/**
		* Wrapper for wp.getCategories - get an array of all categories
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_CATEGORIES with an Array 
		* of categories as the WPServiceEvent.data once loaded</p>
		*/
		public function getCategories():void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getCategories",
				[blogId,username,password],
				WPMethodGroupHelper.PARSE_CATEGORIES,
				WPServiceEvent.GET_CATEGORIES
			);
			loadRequest(request,getCategories);
		}
		
		
		/**
		* Wrapper for mt.getPostCategories - get an array of categories for a specific post
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_POST_CATEGORIES with an Array 
		* of Categories as the WPServiceEvent.data once loaded</p>
		* 
		* @param postId the id of the post to get categories for
		*/
		public function getPostCategories(postId:uint):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"mt.getPostCategories",
				[postId,username,password],
				WPMethodGroupHelper.PARSE_POST_CATEGORIES,
				WPServiceEvent.GET_POST_CATEGORIES
			);
			loadRequest(request,getPostCategories,postId);
		}
		
		/**
		* Wrapper for mt.setPostCategories - set the categories for a specific post
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.SET_POST_CATEGORIES with a struct 
		* of Categories as the WPServiceEvent.data once loaded</p>
		* <p>There appears to be an issue where the XML-RPC interface will occasionally return different data to the HTML
		* interface when this method is used - if you set the categories on a post, the HTML interface will return the old 
		* category set until the user has logged in and clicked "update post" in the admin - the XML-RPC interface (and hence flash)
		* <em>will</em> return the correct category set however.</p> 
		* 
		* @param postId the id of the post to set categories on
		* @param categories an array of categories containing int categoryId and boolean isPrimary. Using isPrimary to set the primary category is optional—in the absence of this flag, the first element in the array will be assigned the primary category for the post.
		*
		*/
		
		public function setPostCategories(postId:uint,categories:Array):void{			
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"mt.setPostCategories",
				[postId,username,password,categories],
				WPMethodGroupHelper.SET_POST_CATEGORIES,
				WPServiceEvent.SET_POST_CATEGORIES
			);
			loadRequest(request,setPostCategories,postId,categories);
		}
		
		/**
		* Wrapper for wp.newCategory - add a new Category
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.NEW_CATEGORY with a struct
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param category the new Category to add
		*/
		public function newCategory(category:Category):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.newCategory",
				[blogId,username,password,category],
				WPMethodGroupHelper.NEW_CATEGORY,
				WPServiceEvent.NEW_CATEGORY
			);
			loadRequest(request,newCategory,category);
		}
		
		
		/**
		* Wrapper for wp.deleteCategory - delete a Category
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.DELETE_CATEGORY with a struct 
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param categoryId the id of the Category to delete
		*/
		public function deleteCategory(categoryId:int):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.deleteCategory",
				[blogId,username,password,categoryId],
				WPMethodGroupHelper.DELETE_CATEGORY,
				WPServiceEvent.DELETE_CATEGORY
			);
			loadRequest(request,deleteCategory,categoryId);
		}

		/**
		* Wrapper for wp.suggestCategories - get an array of categories that start with a given string
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.SUGGEST_CATEGORIES with an Array 
		* of categories as the WPServiceEvent.data once loaded</p>
		*
		* @param category the string to use
		* @param maxResults
		*/
		public function suggestCategories(category:String, maxResults:int = 5):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.suggestCategories",
				[blogId,username,password,category,maxResults],
				WPMethodGroupHelper.PARSE_SUGGESTED_CATEGORIES,
				WPServiceEvent.SUGGEST_CATEGORIES
			);
			loadRequest(request,suggestCategories,category,maxResults);
		}
		
	}
		
}


