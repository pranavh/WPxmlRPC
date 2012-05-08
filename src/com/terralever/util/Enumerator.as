package com.terralever.util
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;

	public class Enumerator extends Object
	{
		
		private var target:Object;
		private var keys:Array;
		private var index:int;
		private static var descriptions:Object;
		
		public function Enumerator(obj:*, keys:Array){
			this.target = obj;
			this.keys = keys;
			index = 0;
		}
		
		/**
		 * Returns the next key, or false if we are done.
		 */
		public function next():Object
		{
			var key:String = keys[index];
			index++;
			if(key == null){
				return false;
			}
			return key;
		}
		
		/**
		 * Creates an array of keys for a class object if they do not exist.
		 * Keys are hashed and reused later.
		 */
		public static function create(obj:*):Enumerator
		{
			if(!descriptions){
				descriptions = {};
			}
			//do we have a description saved?
			var name:String = getQualifiedClassName(obj);
			if(descriptions[name]){
				//cool, we got it.'
			}else{
				//nope, let's get it
				var description:XML = describeType(obj);
				var xList:XMLList = description..variable;
				var keys:Array = new Array();
				for each(var node:XML in xList){
					keys.push(node.@name);
				}
				keys.sort(); //sort our keys alphabetically.
				descriptions[name] = keys;
			}
			//ok, we have a description, lets create our enumerator.
			return new Enumerator(obj, descriptions[name]);
		}
		
	}

}
