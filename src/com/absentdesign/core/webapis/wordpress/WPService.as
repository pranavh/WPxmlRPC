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
	
	import com.absentdesign.core.webapis.Service;
	import com.absentdesign.core.webapis.events.ServiceEvent;
	import com.absentdesign.core.webapis.wordpress.events.*;
	import com.absentdesign.core.webapis.wordpress.methodgroups.*;
	
	import mx.rpc.events.FaultEvent;
	import mx.utils.URLUtil;
	
	/**
	* concrete Service class for making WordPress XML-RPC calls
	*/
	[Event(name="WPServiceEventConnected", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetUsersBlogs", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetPageList", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetPages", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetPage", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventDeletePage", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventDeletePost", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventNewPage", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetRecentPosts", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetRecentPostTitles", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetRecentPostCategories", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventSetPostCategories", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventEditPost", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetPost", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventNewPost", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetCategories", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventNewCategory", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventDeleteCategory", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventSuggestCategories", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetTags", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetComments", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetComment", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventEditComment", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventDeleteComment", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventNewComment", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetAuthors", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventUploadFile", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetMediaItem", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="WPServiceEventGetMediaLibrary", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="connectionError", type="com.absentdesign.core.webapis.wordpress.events.WPServiceEvent")]
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	public class WPService extends Service{
		
		internal static const XML_RPC:String = "xmlrpc.php";
		
		private var _blogId:int = 0;
		private var _username:String;
		private var _password:String;
		private var _posts:Posts;
		private var _pages:Pages;
		private var _blogs:Blogs;
		private var _tags:Tags;
		private var _categories:Categories;
		private var _comments:Comments;
		private var _authors:Authors;
		private var _media:Media;
		private var _connected:Boolean;
		private var _connecting:Boolean;
		
		public var maxConnectAttempts:int=5;
		
		/**
		* @param endpoint The main endpoint for the WordPress install eg: http://myblogname.wordpress.com/
		* @param username The username for this WordPress install
		* @param password The password for this WordPress install
		*/
		public function WPService(endpoint:String,username:String,password:String){
			if(endpoint.charAt(endpoint.length-1) != "/") {
				endpoint += "/";
			}
			
			this.endpoint = endpoint;
		    _username = username;
		    _password = password;
			_blogs = new Blogs(this);
			_posts = new Posts(this);
			_pages = new Pages(this);
			_tags = new Tags(this);
			_categories = new Categories(this);
			_comments = new Comments(this);
			_authors = new Authors(this);
			_media = new Media(this);
			
			_posts.userAgent=userAgent;
			_pages.userAgent=userAgent;
			_blogs.userAgent=userAgent;
			_tags.userAgent=userAgent;
			_categories.userAgent=userAgent;
			_comments.userAgent=userAgent;
			_authors.userAgent=userAgent;
			_media.userAgent=userAgent;
		}
		
		protected var _showBusyCursor:Boolean;
		public function get showBusyCursor():Boolean {
			return _showBusyCursor;
		}
		public function set showBusyCursor(value:Boolean):void {
			_showBusyCursor=value;
			_posts.showBusyCursor=value;
			_pages.showBusyCursor=value;
			_blogs.showBusyCursor=value;
			_tags.showBusyCursor=value;
			_categories.showBusyCursor=value;
			_comments.showBusyCursor=value;
			_authors.showBusyCursor=value;
			_media.showBusyCursor=value;
		}
		
		protected var _userAgent:String;
		public function get userAgent():String {
			return _userAgent;
		}
		public function set userAgent(value:String):void {
			_userAgent=value;
			_posts.userAgent=value;
			_pages.userAgent=value;
			_blogs.userAgent=value;
			_tags.userAgent=value;
			_categories.userAgent=value;
			_comments.userAgent=value;
			_authors.userAgent=value;
			_media.userAgent=value;
		}
		
		public function get username():String{
			return _username;
		}
		
		public function get password():String{
			return _password;
		}
		
		public function get blogId():int{
			return _blogId;
		}
		
		public function set blogId(id:int):void{
			_blogId = id;
		}
			
		//methodgroups	
		public function get blogs():Blogs{
			return _blogs;
		}
		
		public function get posts():Posts{
			return _posts;
		}
		
		public function get pages():Pages{
			return _pages;
		}
		
		public function get tags():Tags{
			return _tags;
		}
		
		public function get categories():Categories{
			return _categories;
		}
		
		public function get comments():Comments{
			return _comments;
		}
		
		public function get authors():Authors{
			return _authors;
		}
		
		public function get media():Media {
			return _media;
		}
		
		/**
		* Find the blogId to allow connections to xmlrpc.php
		*
		* Makes a call to wp.getUsersBlogs to find out the correct blogId based on the endpoint/username/password
		* combination. You do not need to call this function directly, as it will be called automatically the first time you
		* make any method call using any WPMethodGroup.
		* <p>This is necessary because there seems to be no way to find out what your blogId is without calling 
		* wp.getUsersBlogs and iterating for a match, and blogId is a required parameter in most wp service calls</p>
		* <p>If you have already set the blogId manually this function will be ignored</p>
		*/
		public function connect():void{
			if(connected){
				return;
			}
			
			if(connectAttempts < maxConnectAttempts) {
				_connecting = true;
				addEventListener(WPServiceEvent.GET_USERS_BLOGS,connectedHandler, false, 0, true);
				blogs.getUsersBlogs();
				connectAttempts++;
			} else {
				dispatchEvent(new WPServiceEvent(WPServiceEvent.CONNECTION_ERROR));
			}
		}
		
		private var connectAttempts:int=0;
		public function reset(username:String, password:String):void {
			connectAttempts=0;
			_connecting=_connected=false;
			this._username=username;
			this._password=password
		}
		
		private function connectedHandler(event:ServiceEvent):void{
			removeEventListener(WPServiceEvent.GET_USERS_BLOGS,connectedHandler);
			for each(var blog:Blog in event.data){
				var rslv:String=endpoint + "xmlrpc.php";
				var rslv2:String;
				var prot:String=URLUtil.getProtocol(endpoint + "xmlrpc.php");
				if(rslv.indexOf(prot+"://www.") != -1) {
					rslv2=rslv.replace(prot+"://www.", prot+"://");
				} else {
					rslv2=rslv.replace(prot+"://", prot+"://www.");
				}
				
				if(blog.xmlrpc_url.toLowerCase() == rslv.toLowerCase() || blog.xmlrpc_url.toLowerCase() == rslv2.toLowerCase()){
					_blogId = blog.blog_id;
					_connecting = false;
					dispatchEvent(new WPServiceEvent(WPServiceEvent.CONNECTED,event.data));
					break;
				}
			}
			/*_connecting = false;
			dispatchEvent(new WPServiceEvent(WPServiceEvent.CONNECTED,event.data));*/
		}
		
		public function get connected():Boolean{
			return blogId != 0;
		}
		
		public function get connecting():Boolean{
			return _connecting;
		}

	}


}

