package com.absentdesign.core.webapis.wordpress
{
	public class MediaItemFilter extends WPStruct
	{
		public function MediaItemFilter()
		{
			super();
		}
		
		public var number:int, offset:int, parent_id:int;
		public var mime_type:String;// (e.g., 'image/jpeg', 'application/pdf') 
	}
}