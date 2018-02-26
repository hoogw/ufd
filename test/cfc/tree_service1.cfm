<cfscript>
  
	// Since we need to deserialize and consume the incoming request, there are a number
	// of things that can go wrong.
	try {

          // by default it is true for getHttpRequestData(true), means get body of the request, which is post data we want.  GET don't have a body. 

		requestBody = toString( getHttpRequestData().content );

		// Not every type of request will have a "body" (ex, "GET"). But, for this demo,
		// we're going to assume the body, if it exists, will always be an object. I find
		// an object easier to work with - I never let the client pass in a simple value
		// or an array.
		if ( len( requestBody ) ) {

			//structAppend( form, deserializeJson( requestBody ) );
             json_post = deserializeJson( requestBody );
		}

	} catch ( any error ) {

		// The incoming request data was either not JSON or was not an "object". A this
		// point, you might want to throw a custom error; or, you might want to let the
		// request continue and defer processing logic to some controller.
		// --
		// throw( type = "BadRequest" );

	}

	// Echo the state of the Form scope (output on the client).
	//writeDump( var = form, label = "Form Scope" );
	 writeDump(json_post);
     // writeDump(json_post.init_specieSelected.name);
</cfscript>