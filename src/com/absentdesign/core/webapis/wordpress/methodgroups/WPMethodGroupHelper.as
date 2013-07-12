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

	import com.absentdesign.core.webapis.methodgroups.MethodGroupHelper;
	import com.absentdesign.core.webapis.wordpress.*;

	/**
	*  concrete MethodGroupHelper for parsing results from XML-RPC into WPStructs
	*/
	public class WPMethodGroupHelper extends MethodGroupHelper{

		public static const PARSE_USERS_BLOGS:String = "parseUsersBlogs";
		public static const PARSE_PAGE_LIST:String = "parsePages";
		public static const PARSE_PAGES:String = "parsePages";
		public static const PARSE_PAGE:String = "parsePage";
		public static const DELETE_PAGE:String = "returnStruct";
		public static const DELETE_POST:String = "returnStruct";
		public static const NEW_PAGE:String = "returnStruct";
		public static const NEW_POST:String = "returnStruct";
		public static const PARSE_RECENT_POSTS:String = "parsePosts";
		public static const PARSE_RECENT_POST_TITLES:String = "parsePosts";
		//public static const EDIT_POST:String = "editPost";
		public static const EDIT_POST:String = "returnStruct";
		public static const PARSE_POST:String = "parsePost";
		public static const NEW_CATEGORY:String = "returnStruct";
		public static const DELETE_CATEGORY:String = "returnStruct";
		public static const PARSE_POST_CATEGORIES:String = "parseCategories";
		public static const PARSE_CATEGORIES:String = "parseCategories";
		public static const PARSE_SUGGESTED_CATEGORIES:String = "parseSuggestedCategories";
		public static const SET_POST_CATEGORIES:String = "returnStruct";	
		public static const PARSE_TAGS:String = "parseTags";
		public static const PARSE_COMMENT_COUNT:String = "parseCommentCount";
		public static const PARSE_COMMENTS:String = "parseComments";
		public static const PARSE_COMMENT:String = "parseComment";
		public static const EDIT_COMMENT:String = "returnStruct";
		public static const DELETE_COMMENT:String = "returnStruct";
		public static const NEW_COMMENT:String = "returnStruct";
		public static const PARSE_AUTHORS:String = "parseAuthors";
		public static const UPLOAD_FILE:String = "returnStruct";
		public static const PARSE_MEDIA_LIBRARY:String = "parseMediaLibrary";
		public static const PARSE_MEDIA_ITEM:String = "parseMediaItem";

		public function WPMethodGroupHelper(){
			super();
		}
		
		public function returnStruct(struct:*):*{
			return struct;
		}
		
		public function parseMediaLibrary(struct:*):Array {
			var results:Array = new Array();
			for each(var mediaItem:* in struct) {
				results.push(parseMediaItem(mediaItem));
			}
			return results;
		}
		
		public function parseMediaItem(struct:*):MediaItem {
			var mi:MediaItem=new MediaItem();
			mi.caption=struct.caption;
			mi.date_created=struct.date_created_gmt;
			mi.date_created.minutes += mi.date_created.timezoneOffset;
			mi.description=struct.description;
			mi.link=struct.link;
			mi.metadata=struct.metadata;
			mi.parent=struct.parent;
			mi.thumbnail=struct.thumbnail;
			mi.title=struct.title;
			return mi;
		}
		
		public function parseUsersBlogs(struct:*):Array{
			var results:Array = new Array();
			for each(var blogStruct:* in struct){
				results.push(parseBlog(blogStruct));
			}
			return results;
		}
		
		public function parseBlog(struct:*):Blog{
			var blog:Blog = new Blog();
			blog.is_admin = struct.isAdmin;
			blog.url = struct.url;
			blog.blog_id = struct.blogid;
			blog.blog_name = struct.blogName;
			blog.xmlrpc_url = struct.xmlrpc;
			return blog;
		}

		public function parsePages(struct:*):Array{
			var results:Array = new Array();
			for each(var page:* in struct){
				results.push(parsePage(page));
			}
			return results;
		}
		
		public function parsePage(struct:*):Page{	
			var page:Page = new Page();	
			page.dateCreated = struct.dateCreated;
			page.userid = struct.userid;
			page.page_id = struct.page_id;
			page.page_status = struct.page_status;
			page.description = struct.description;
			page.title = struct.title;
			page.link = struct.link;
			page.permaLink = struct.permaLink;
			page.categories = struct.categories;
			page.excerpt = struct.excerpt;
			page.text_more = struct.text_more;
			page.mt_allow_comments = struct.mt_allow_comments;
			page.mt_allow_pings = struct.mt_allow_pings;
			page.wp_slug = struct.wp_slug;
			page.wp_password = struct.wp_password;
			page.wp_author = struct.wp_author;
			page.wp_page_parent_id = struct.wp_page_parent_id;
			page.wp_page_parent_title = struct.wp_page_parent_title;
			page.wp_page_order = struct.wp_page_order;
			page.wp_author_id = struct.wp_author_id;
			page.wp_author_display_name = struct.wp_author_display_name;
			page.date_created_gmt = struct.date_created_gmt;
			page.custom_fields = parseCustomFields(struct.custom_fields);
			return page;
		}

		public function parseCustomFields(struct:*):Array{
			var results:Array = new Array();
			for each(var field:* in struct){
				results.push(parseCustomField(field));
			}
			return results;
		}
		
		public function parseCustomField(struct:*):CustomField{
			var customField:CustomField = new CustomField();
			customField.id = struct.id;
			customField.key = struct.key;
			customField.value = struct.value;
			return customField;
		}
		
		public function parseCategories(struct:*):Array{
			var results:Array = new Array();
			for each(var category:* in struct){
				results.push(parseCategory(category));
			}
			return results;
		}
		
		public function parseCategory(struct:*):Category{
			var category:Category = new Category();
			category.htmlUrl = struct.htmlUrl;
			category.description = struct.description;
			category.rssUrl = struct.rssUrl;
			category.categoryId = struct.categoryId;
			category.categoryName = struct.categoryName;
			category.slug = struct.slug;
			return category;
		}
		
		/**
		* different to parseCategories because WP inconsistently names category data
		*/
		public function parseSuggestedCategories(struct:*):Array{
			var results:Array = new Array();
			for each(var category:* in struct){
				results.push(parseSuggestedCategory(category));
			}
			return results;
		}
		
		/**
		* different to parseCategory because WP inconsistently names category data
		*/
		public function parseSuggestedCategory(struct:*):Category{
			var category:Category = new Category();
			category.categoryId = struct.category_id;
			category.categoryName = struct.category_name;
			return category;
		}
		
		public function parsePosts(struct:*):Array{
			var results:Array = new Array();
			for each(var post:* in struct){
				results.push(parsePost(post));
			}
			return results;
		}
		
		public function parsePost(struct:*):Post{
			var post:Post = new Post();
			post.userid = struct.userid;
			post.categories = struct.categories;
			post.dateCreated = struct.dateCreated;
			post.sticky = struct.sticky;
			post.postid = struct.postid;
			post.description = struct.description;
			post.title = struct.title;
			post.link = struct.link;
			post.permaLink = struct.permaLink;
			post.mt_excerpt = struct.mt_excerpt;
			post.mt_text_more = struct.mt_text_more;
			post.mt_allow_comments = struct.mt_allow_comments;
			post.mt_allow_pings = struct.mt_allow_pings;
			post.mt_convert_breaks = struct.mt_convert_breaks;
			post.mt_keywords = struct.mt_keywords;
			if(struct.post_thumbnail != null) {
				post.post_thumbnail=struct.post_thumbnail;
			}
			if(struct.wp_post_thumbnail != null) {
				post.wp_post_thumbnail=struct.wp_post_thumbail;
			}
			return post;
		}

		public function parseTags(struct:*):Array{
			var results:Array = new Array();
			for each(var tag:* in struct){
				results.push(parseTag(tag));
			}
			return results;
		}
		
		public function parseTag(struct:*):Tag{
			var tag:Tag = new Tag();
			tag.tag_id = struct.tag_id;
			tag.name = struct.name;
			tag.count = struct.count;
			tag.slug = struct.slug;
			tag.html_url = struct.html_url;
			tag.rss_url = struct.rss_url;
			return tag;
		}
		
		public function parseCommentCount(struct:*):CommentCount{
			var commentCount:CommentCount = new CommentCount();
			commentCount.approved = struct.approved;
			commentCount.awaiting_moderation = struct.awaiting_moderation;
			commentCount.spam = struct.spam;
			commentCount.total_comments = struct.total_comments;
			return commentCount;
		}
		
		public function parseComments(struct:*):Array{
			var results:Array = new Array();
			for each(var comment:* in struct){
				results.push(parseComment(comment));
			}
			return results;
		}
		
		public function parseComment(struct:*):Comment{
			var comment:Comment = new Comment;
			comment.date_created_gmt = struct.date_created_gmt;
			comment.user_id = struct.user_id;
			comment.comment_id = struct.comment_id;
			comment.parent = struct.parent;
			comment.status = struct.status;
			comment.content = struct.content;
			comment.link = struct.link;
			comment.post_id = struct.post_id;
			comment.post_title = struct.post_title;
			comment.author = struct.author;
			comment.author_url = struct.author_url;
			comment.author_email = struct.author_email;
			comment.author_ip = struct.author_ip;
			return comment;
		}
		
		public function parseAuthors(struct:*):Array{
			var results:Array = new Array();
			for each(var author:* in struct){
				results.push(parseAuthor(author));
			}
			return results;
		}

		public function parseAuthor(struct:*):Author{
			var author:Author = new Author();
			author.user_id = struct.user_id;
			author.user_login = struct.user_login;
			author.display_name = struct.display_name;
			author.user_email = struct.user_email;
			author.meta_value = struct.meta_value;
			return author;
		}

	}


}

