package com.gravityblast.couchdb
{
	import com.gravityblast.couchdb.events.CouchRestEvent;
	import com.gravityblast.couchdb.events.DocumentEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	
	public class DocumentLoader extends EventDispatcher
	{
		public function DocumentLoader()
		{			
			super(null);
		}
		
		public function load(id:String):void
		{			
			CouchDb.defaultDatabase.get(id, null, this.loadHandler);
		}
		
		public function loadHandler(event:CouchRestEvent):void
		{						
			if (this.hasEventListener(DocumentEvent.LOADED))
			{
				var document:*;
				if (event.json["couchdb-flex-type"])
				{
					var ClassReference:Class = getDefinitionByName(event.json["couchdb-flex-type"]) as Class;
					document = new ClassReference();
					document.attributes = event.json;					
				}
				else
				{
					document = event.json;
				}
				var e:DocumentEvent = new DocumentEvent(DocumentEvent.LOADED, document, event.json, event.data);
				this.dispatchEvent(e);
			}
		}
	}
}