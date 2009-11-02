package com.gravityblast.couchdb
{	
	import com.adobe.net.URI;

	public class CouchDb
	{
		
		public  var host:String;
		public  var port:uint;
		private var _uri:URI;
		
		public static var defaultDatabase:Database;
		
		public function CouchDb(host:String="127.0.0.1", port:uint=5984)
		{
			this.host = host;
			this.port = port;
			this._uri = new URI();
			this._uri.unknownToURI(this.host);
			this._uri.port = this.port.toString();
		}
		
		public function database(name:String):Database
		{
			var database:Database = new Database(this, name);
			if (defaultDatabase == null)
				defaultDatabase = database;
			return database;
		}
		
		public function get uri():String
		{
			return this._uri.toString();
		}
	}
}
