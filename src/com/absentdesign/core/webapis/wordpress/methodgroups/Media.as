package com.absentdesign.core.webapis.wordpress.methodgroups
{
	import com.absentdesign.core.webapis.events.ServiceEvent;
	import com.absentdesign.core.webapis.wordpress.MediaItemFilter;
	import com.absentdesign.core.webapis.wordpress.MediaObject;
	import com.absentdesign.core.webapis.wordpress.WPService;
	import com.absentdesign.core.webapis.wordpress.WPServiceRequest;
	import com.absentdesign.core.webapis.wordpress.WPStruct;
	import com.absentdesign.core.webapis.wordpress.events.WPServiceEvent;
	
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	import mx.utils.Base64Encoder;
	
	public class Media extends WPMethodGroup
	{
		public function Media(service:WPService)
		{
			super(service);
		}
		
		/**
		 * Wrapper for wp.uploadFile - uploads the supplied file
		 * <p>Will dispatch a ServiceEvent of type WPServiceEvent.UPLOAD_FILE with an array of blogs 
		 * as the WPServiceEvent.data once loaded</p>
		 */
		public function uploadFile(name:String, type:String, data:ByteArray, overwrite:Boolean=true):void{
			
			/*wp.uploadFile
			
			Upload a file.
				Parameters
			
			int blog_id
			string username
			string password
			struct data
				string name
				string type
				base64 bits
				bool overwrite
			
			Return Values
			
			struct
				string file
				string url
				string type*/
			
			var content:MediaObject=new MediaObject();
			content.name=name;
			content.type=type;
			content.bits=data;
			content.overwrite=overwrite;
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.uploadFile",
				[blogId,username,password,content],
				WPMethodGroupHelper.UPLOAD_FILE,
				WPServiceEvent.UPLOAD_FILE
			);
			loadRequest(request,uploadFile,name,type,data,overwrite);
		}
		
		public function getMediaItem(attachmentId:int):void {
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getMediaItem",
				[blogId,username,password,attachmentId],
				WPMethodGroupHelper.PARSE_MEDIA_ITEM,
				WPServiceEvent.GET_MEDIA_ITEM
			);
			loadRequest(request,getMediaItem,attachmentId);
		}
		
		public function getMediaLibrary(number:int=-1, offset:int=-1, parentId:int=-1,  mimeType:String="", useFilter:Boolean=false):void {
			var argsArray:Array;
			if(useFilter) {
				var filter:MediaItemFilter=new MediaItemFilter();
				filter.mime_type=mimeType;
				filter.number=number;
				filter.offset=offset;
				filter.parent_id=parentId;
				argsArray=[blogId,username,password,filter];
			} else {
				argsArray=[blogId,username,password];
			}
			var request:WPServiceRequest = new WPServiceRequest(
				service as WPService,
				"wp.getMediaLibrary",
				argsArray,
				WPMethodGroupHelper.PARSE_MEDIA_LIBRARY,
				WPServiceEvent.GET_MEDIA_LIBRARY
			);
			loadRequest(request,getMediaLibrary,number,offset,parentId,mimeType,useFilter);
		}
		
	/*	
		wp.getMediaLibrary
		
		This call get a list of items in the user's Media Library with IDs, titles, descriptions, remote links, and any other relevant metadata. A filter parameter could be provided that would allow the caller to filter based on content type, file size, or other properties.
		Parameters
		
		int blog_id
		string username
		string password
		struct filter (optional)
			int number
			int offset
			int parent_id
			string mime_type (e.g., 'image/jpeg', 'application/pdf') 
		
		Return Values
		
		array
			struct Same as wp.getMediaItem 
		
		wp.getMediaItem
		
		This call would get a specific item in the user's Media Library by providing an ID. The call would return the item's ID, title, description, remote link, and any other available metadata.
Parameters

    int blog_id
    string username
    string password
    int attachment_id 

Return Values

    struct
        date_created_gmt
        parent
        link
        thumbnail
        title
        caption
        description
        metadata 
*/
		
		
	}
}