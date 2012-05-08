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
	* concrete WPMethodGroup for manipulating pages  
	*/
	public class Pages extends WPMethodGroup{

		public function Pages(service:WPService){
			super(service);
		}
		
		/**
		* Wrapper for wp.getPageList - gets a summary list of all pages on the site
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.PARSE_PAGE_LIST with an array of Pages 
		* as the WPServiceEvent.data once loaded</p>
		*/
		public function getPageList():void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getPageList",
				[blogId,username,password],
				WPMethodGroupHelper.PARSE_PAGE_LIST,
				WPServiceEvent.GET_PAGE_LIST
			);
			loadRequest(request,getPageList);
		}
		
		/**
		* Wrapper for wp.getPages - gets all pages on the site
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.PARSE_PAGES with an array of Pages 
		* as the WPServiceEvent.data once loaded</p>
		*/
		public function getPages():void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getPages",
				[blogId,username,password],
				WPMethodGroupHelper.PARSE_PAGES,
				WPServiceEvent.GET_PAGES
			);
			loadRequest(request,getPages);
		}
		
		/**
		* Wrapper for wp.getPage - gets a single page
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.GET_PAGE with a Page 
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param pageId the id of the page you want to retreive
		*/
		public function getPage(pageId:int):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getPage",
				[blogId,pageId,username,password],
				WPMethodGroupHelper.PARSE_PAGE,
				WPServiceEvent.GET_PAGE
			);
			loadRequest(request,getPage,pageId);
		}
		
		/**
		* Wrapper for wp.newPage - adds a page to the blog
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.NEW_PAGE 
		* with a struct as the WPServiceEvent.data once loaded</p>
		*
		* @param content The new Page to add
		* @param publish
		*/
		public function newPage(content:Page,publish:Boolean):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.newPage",
				[blogId,username,password,content,publish],
				WPMethodGroupHelper.NEW_PAGE,
				WPServiceEvent.NEW_PAGE
			);
			loadRequest(request,newPage,content,publish);
		}
		
		/**
		* Wrapper for wp.editPage - edit an existing page
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.EDIT_PAGE with a struct
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param pageId:int The id of the page you are editing
		* @param content The edited page
		* @param publish
		*/
		public function editPage(pageId:int,content:Page,publish:Boolean):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.editPage",
				[blogId,pageId,username,password,content,publish],
				WPMethodGroupHelper.NEW_PAGE,
				WPServiceEvent.NEW_PAGE
			);
			loadRequest(request,editPage,pageId,content,publish);
		}
		
		/**
		* Wrapper for wp.deletePage - deletes a single page
		* <p>Will dispatch a ServiceEvent of type WPServiceEvent.DELETE_PAGE with a struct
		* as the WPServiceEvent.data once loaded</p>
		*
		* @param pageId the id of the page you want to delete
		*/
		public function deletePage(pageId:int):void{
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.deletePage",
				[blogId,username,password,pageId],
				WPMethodGroupHelper.DELETE_PAGE,
				WPServiceEvent.DELETE_PAGE
			);
			loadRequest(request,deletePage,pageId);
		}

	}


}

