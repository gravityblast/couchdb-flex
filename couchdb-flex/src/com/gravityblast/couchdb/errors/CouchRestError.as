package com.gravityblast.couchdb.errors
{
	public class CouchRestError extends Error
	{
		public function CouchRestError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}