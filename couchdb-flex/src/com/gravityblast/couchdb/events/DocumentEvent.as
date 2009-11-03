package com.gravityblast.couchdb.events
{
	import flash.events.Event;
	
	public class DocumentEvent extends Event
	{
		
		public static const LOADED:String = "COUCH_DB_DOCUMENT_LOADED_EVENT";
		public static const SAVED:String  = "COUCH_DB_DOCUMENT_SAVED_EVENT";
		
		public var document:Object;
		public var json:Object;
		public var data:String;
		
		public function DocumentEvent(type:String, document:Object, json:Object, data:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.document = document;
			this.json = json;
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}