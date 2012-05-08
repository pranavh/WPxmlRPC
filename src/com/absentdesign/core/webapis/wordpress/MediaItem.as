package com.absentdesign.core.webapis.wordpress
{
	import flash.utils.ByteArray;

	public class MediaItem extends WPStruct
	{
		public function MediaItem()
		{
			super();
		}
		
		public var date_created:Date;
		public var parent:String;
		public var link:String;
		public var thumbnail:Boolean;
		public var title:String;
		public var caption:String;
		public var description:String;
		public var metadata:Array; 
	}
}