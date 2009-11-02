package com.gravityblast.couchdb
{
	import com.adobe.serialization.json.JSON;
	import com.gravityblast.couchdb.errors.DatabaseError;
	import com.gravityblast.couchdb.events.CouchRestEvent;
	import com.gravityblast.couchdb.events.DatabaseEvent;
	
	import flash.events.EventDispatcher;
	

	public class Database extends EventDispatcher
	{
		
		public var couchdb:CouchDb;
		public var name:String;
		
		public function Database(couchdb:CouchDb, name:String)
		{
			this.couchdb = couchdb;
			this.name 	 = name;
			super();
		}
		
		public function create(completeCallback:Function=null):void
		{
			var couchRest:CouchRest = this.buildCouchRest(completeCallback);			
			couchRest.put(this.couchdb.uri + "/" + this.name);
		}
		
		public function del(completeCallback:Function=null):void
		{
			var couchRest:CouchRest = this.buildCouchRest(completeCallback);			
			couchRest.del(this.couchdb.uri + "/" + this.name);
		}
		
		public function saveDocument(document:Object, completeCallback:Function=null):void
		{
			var couchRest:CouchRest = this.buildCouchRest(completeCallback);
			if (document._id)			
				couchRest.put(this.couchdb.uri + "/" + this.name + "/" + document._id, null, JSON.encode(document));	
			else			
				couchRest.post(this.couchdb.uri + "/" + this.name, null, JSON.encode(document));					
		}
		
		public function get(id:String, params:Object=null, completeCallback:Function=null):void
		{			
			var couchRest:CouchRest = this.buildCouchRest(completeCallback);
			couchRest.get(this.couchdb.uri + "/" + this.name + "/" +  id);
		}
		
		public function documents(params:Object=null, completeCallback:Function=null):void
		{
			var couchRest:CouchRest = this.buildCouchRest(completeCallback);
			couchRest.get(this.couchdb.uri + "/" + this.name + "/" +  "_all_docs");
		}				
		
		protected function couchRestErrorHandler(event:CouchRestEvent):void
		{
			if (hasEventListener(DatabaseEvent.ERROR))
			{
				var _event:DatabaseEvent = new DatabaseEvent(DatabaseEvent.ERROR);
				this.dispatchEvent(_event);
			}
			else
			{
				throw new DatabaseError();	
			}				
		}
		
		protected function buildCouchRest(completeCallback:Function=null):CouchRest
		{
			var couchRest:CouchRest = new CouchRest();
			couchRest.addEventListener(CouchRestEvent.IO_ERROR, this.couchRestErrorHandler);
			if (completeCallback != null)			
				couchRest.addEventListener(CouchRestEvent.COMPLETE, completeCallback);											
			return couchRest;
		}
	}
}