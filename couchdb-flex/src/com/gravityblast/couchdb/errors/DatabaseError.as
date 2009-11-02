package com.gravityblast.couchdb.errors
{
	public class DatabaseError extends Error
	{
		public function DatabaseError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}