package com.gravityblast.couchdb
{
	import com.gravityblast.couchdb.events.CouchRestEvent;
	import com.gravityblast.couchdb.events.DocumentEvent;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	dynamic public class Document
	{				
		public static var database:Database;
				
		public 	var _id:String;
		public 	var _rev:String;
		
		public function Document()
		{				
			if (Document.database == null)
				database = CouchDb.defaultDatabase;			
			super();			
		}
		
		public function get attributes():Object
		{						
			var _attributes:Object = {};				
			for each (var attributeName:String in this.attributeNames())		
				_attributes[attributeName] = this[attributeName];								
			for (var dynamicAttributeName:String in this)
				_attributes[dynamicAttributeName] = this[dynamicAttributeName];
			_attributes["couchdb-flex-type"] = getQualifiedClassName(this);
			
			return _attributes;
		}
		
		public function set attributes(value:Object):void
		{			
			for (var propertyName:String in value)
			{				
				try
				{
					this[propertyName] = value[propertyName];	
				}					
				catch(error:Error)
				{
					trace(error);	
				}					
			}
		}
				
		public function save(completeCallback:Function=null):void
		{			
			var saver:DocumentSaver = new DocumentSaver(database, this);
			if (completeCallback != null)
				saver.addEventListener(CouchRestEvent.COMPLETE, completeCallback);
			saver.save();			
		}
		
		private function attributeNames():Array
		{
			var names:Array = new Array();
			var classInfo:XML = describeType(this);			
			for each ( var v:XML in classInfo..*.((true) && (name() == "variable" || (name() == "accessor" && attribute( "access" ).charAt( 0 ) == "r") )))
			{	
				if (v.@name != "attributes" && v.@name != "database" && v.@name != "_id" && v.@name != "_rev")
					names.push(v.@name);
			}

			return names;
		}
		
		public static function load(id:String, completeCallback:Function=null):void
		{
			var loader:DocumentLoader = new DocumentLoader();
			if (completeCallback != null)
				loader.addEventListener(DocumentEvent.LOADED, completeCallback);
			loader.load(id);
		}
	}
}