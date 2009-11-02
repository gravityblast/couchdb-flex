package com.gravityblast.couchdb
{
	import com.gravityblast.couchdb.events.ViewEvent;

	public class View
	{
		
		public var name:String;
		public var map:String;
		public var reduce:String;
		
		public function View(name:String, map:String, reduce:String=null)
		{
			this.name = name;
			this.map = map;
			this.reduce = reduce;
		}		
		
		public static function load(designName:String, viewName:String, params:Object, completeCallback:Function=null):void
		{
			var loader:ViewLoader = new ViewLoader();
			if (completeCallback != null)
				loader.addEventListener(ViewEvent.LOADED, completeCallback);
			loader.load("_design/" + designName + "/_view/" + viewName);			
		}
	}
}