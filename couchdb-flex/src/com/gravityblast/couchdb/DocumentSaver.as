package com.gravityblast.couchdb
{
	import com.gravityblast.couchdb.events.CouchRestEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	public class DocumentSaver extends EventDispatcher
	{
		
		protected var database:Database;
		protected var document:Document;
		
		public function DocumentSaver(database:Database, document:Document)
		{
			this.database = database;
			this.document = document;
			super();
		}
		
		public function save():void
		{
			var attributes:Object = this.document.attributes;
			if (this.document._rev)
			{
				attributes._id = this.document._id;
				attributes._rev = this.document._rev;
			}						
			this.database.saveDocument(attributes, this.saveHandler);
		}
		
		protected function saveHandler(event:CouchRestEvent):void
		{
			if (event.json.ok)
			{
				this.document._id  = event.json.id;
				this.document._rev = event.json.rev;
			}
			if (this.hasEventListener(CouchRestEvent.COMPLETE))
			{
				// FIXME:
				var e:CouchRestEvent = new CouchRestEvent(CouchRestEvent.COMPLETE, event.json, event.data);
				this.dispatchEvent(e);
			}
		}
	}
}