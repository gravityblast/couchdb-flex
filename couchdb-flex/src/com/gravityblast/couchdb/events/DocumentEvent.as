package com.gravityblast.couchdb.events
{
	import flash.events.Event;
	
	public class DocumentEvent extends Event
	{
		
		public static const LOADED:String = "COUCH_DB_DOCUMENT_LOADED_EVENT";
		
		public var document:Object;
		
		public function DocumentEvent(type:String, document:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.document = document;
			super(type, bubbles, cancelable);
		}
	}
}