package com.absentdesign.core.webapis.wordpress
{
	import flash.utils.ByteArray;

	public class MediaObject extends WPStruct
	{
		public function MediaObject()
		{
			super();
		}
		
		public var name:String;
		public var type:String;
		public var bits:ByteArray;
		public var overwrite:Boolean;
	}
}