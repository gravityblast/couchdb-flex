package com.gravityblast.couchdb
{
	import com.gravityblast.couchdb.events.CouchRestEvent;
	import com.gravityblast.couchdb.events.ViewEvent;
	
	import flash.utils.getDefinitionByName;

	public class ViewLoader extends DocumentLoader
	{
		public function ViewLoader()
		{
			super();
		}				
		
		override public function loadHandler(event:CouchRestEvent):void
		{						
			if (this.hasEventListener(ViewEvent.LOADED))
			{
				var documents:Array = new Array();
				if (event.json.rows) {
					for each (var row:Object in event.json.rows )
					{
						if (row.value)
						{
							var ClassReference:Class;
							ClassReference = row.value["couchdb-flex-type"] ? (getDefinitionByName(row.value["couchdb-flex-type"]) as Class) : Object;											
							var document:Object = new ClassReference();
							document.attributes = row.value;
							documents.push(document);
						}									
					}
				}
				var e:ViewEvent = new ViewEvent(ViewEvent.LOADED, documents);
				this.dispatchEvent(e);
			}
		}
	}
}