package com.gravityblast.couchdb
{	
	public class Design extends Document
	{
		public var name:String; 		
		private var documentClass:Class; 
		private var _views:Array;
		
		public function Design(name:String, documentClass:Class=null)
		{
			this.name = name;
			this.documentClass = documentClass;
			this._views = new Array();			
			super();
		}
		
		public function addView(view:View):void
		{
			this._views.push(view); 
		}
		
		override public function get attributes():Object
		{
			var _attributes:Object = super.attributes;
			delete _attributes["couchdb-flex-type"];			
			_attributes.language = "javascript";
			_attributes._id = "_design/" + this.name;			
			var views:Object = new Object();
			for each (var _view:View in this._views)
			{
				var view:Object = new Object();
				view.map = _view.map;
				if (_view.reduce)
					view.reduce = _view.reduce;			
				views[_view.name] = view;
			}
			_attributes.views = views;
			
			return _attributes;
		}
	}
}