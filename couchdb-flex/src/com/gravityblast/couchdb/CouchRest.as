package com.gravityblast.couchdb
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONParseError;
	import com.gravityblast.couchdb.errors.CouchRestError;
	import com.gravityblast.couchdb.events.CouchRestEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class CouchRest extends EventDispatcher
	{
		public var loader:URLLoader;
		
		public function CouchRest():void
		{									
			this.loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, this.completeEventHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorEventHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusEventHandler);
			super();
		}
		
		private function completeEventHandler(event:Event):void
		{
			var jsonResponse:Object = JSON.decode(this.loader.data);			
			var event:Event = new CouchRestEvent(CouchRestEvent.COMPLETE, jsonResponse, this.loader.data);
			this.dispatchEvent(event);
		}
		
		private function ioErrorEventHandler(event:Event):void
		{			
			try
			{
				var jsonResponse:Object = JSON.decode(this.loader.data);			
				var event:Event = new CouchRestEvent(CouchRestEvent.COMPLETE, jsonResponse, this.loader.data);
				this.dispatchEvent(event);
			}
			catch (error:JSONParseError)
			{				
				if (this.hasEventListener(CouchRestEvent.IO_ERROR))
				{
					var _event:CouchRestEvent = new CouchRestEvent(CouchRestEvent.IO_ERROR);
					this.dispatchEvent(_event);
				}										
				else
				{
					throw new CouchRestError("CouchDb Connection Error");	
				}
			}
		}
		
		private function httpStatusEventHandler(event:Event):void
		{
			// trace("http status: " + event)			
		}
		
		public function get(uri:String, params:*=null):void
		{														
			this.load(uri, URLRequestMethod.GET, params);
		}
		
		public function put(uri:String, params:*=null, body:*=null):void
		{														
			this.load(uri, URLRequestMethod.PUT, params, body);
		}
		
		public function post(uri:String, params:*=null, body:*=null):void
		{											
			this.load(uri, URLRequestMethod.POST, params, body);
		}
		
		public function del(uri:String, params:*=null, body:*=null):void
		{	
			this.load(uri, URLRequestMethod.DELETE);
		}
		
		public function load(uri:String, method:String, params:*=null, body:*=null, callback:Function=null):void
		{			
			var request:URLRequest = new URLRequest(uri);			
			request.contentType = "application/json";
			request.method = method;			
			if (params)
			{
				request.data = this.objectToUrlVariables(params);	
			}
			else if (body)
			{				
				request.data = body;
			}
			
			this.loader.load(request);
		}
		
		public function objectToUrlVariables(object:Object):URLVariables
		{
			var variables:URLVariables = new URLVariables();
			for (var propertyName:String in object)
			{
				variables[propertyName] = object[propertyName];
			}
			
			return variables;
		}
	}
}