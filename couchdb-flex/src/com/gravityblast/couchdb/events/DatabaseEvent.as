package com.gravityblast.couchdb.events
{
	import flash.events.Event;
	
	public class DatabaseEvent extends Event
	{
		
		public static const ERROR:String = "COUCH_DB_DATABASE_ERROR_EVENT";
		
		public function DatabaseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}