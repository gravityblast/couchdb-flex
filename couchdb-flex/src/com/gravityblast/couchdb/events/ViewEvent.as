package com.gravityblast.couchdb.events
{
	import flash.events.Event;
	
	public class ViewEvent extends Event
	{
		public static const LOADED:String = "COUCH_DB_VIEW_LOADED_EVENT";
		
		public var documents:Array
		
		public function ViewEvent(type:String, documents:Array, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.documents = documents;
			super(type, bubbles, cancelable);
		}
	}
}