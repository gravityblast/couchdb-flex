package com.gravityblast.couchdb.events
{
	import flash.events.Event;
	
	public class CouchRestEvent extends Event
	{
		
		public static const COMPLETE:String = "COUCH_REST_COMPLETE"
		public static const IO_ERROR:String = "COUCH_REST_IO_ERROR"
		
		public var json:Object;
		public var data:String;
		
		public function CouchRestEvent(type:String, json:Object=null, data:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.json = json;
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}