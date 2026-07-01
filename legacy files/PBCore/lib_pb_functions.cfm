<CFSILENT>
	<CFSCRIPT>
		function pb_functions() {
			return 1;	
		}
		
		function pb_relPath(inFrom, inTo) {
			var from = ucase(inFrom);
			var to = ucase(inTo);
			var backTrack = "";
			var x = 0;
			// Calculate a relative path from the from directory to the to directory
			
			// Strip off the section of the path that is the same (ie until they branch).
			while (listLen(from) AND listLen(To) AND (listFirst(from, "/\") eq listFirst(to, "/\"))) {
				from = listRest(from, "/\");
				to = listRest(to, "/\");
			};
			
			// step back the number of directories forward we are from the branch
			for (x = 1; x LTE listLen(from, "/\"); x = x + 1) {
				backTrack = listAppend(backTrack, "..", "\");
			};
			
			// step forward into the directories from the branch
			backTrack = backTrack & "\" & to;
			
			// strip leading and trailing \ if present
			if (len(backTrack)) {
				if (right(backTrack, 1) eq "\") { // last char is '\'
					if (len(backTrack) gt 1) {
						backTrack = left(backTrack, Len(backTrack) - 1); // strip last char
					} else { 
						backTrack = ''; 
					}
				};
				if (left(backTrack, 1) eq "\") { // first char is '\'
					if (len(backTrack) gt 1) {
						backTrack = right(backTrack, Len(backTrack) - 1); // strip first char
					} else {
						backTrack = '';
					};
				};			
			}
			
			// If backTrack is now empty, set it to "." (current directory)
			if (not Len(backTrack)) {
				backTrack = ".";
			}
			
			return backTrack;	// Strip trailing slash
		}
		
		function pb_webRoot(fromHere) {
			// return a relative path to the "webRoot" 
			return pb_relPath(fromHere, ucase(CFG.webRoot));
		}
		
		function pb_appRoot(fromHere) {
			// return a relative path to the "appRoot" 
			return pb_relPath(fromHere, ucase(CFG.appRoot));
		}
		
		function pb_relExpandPath() {
			var fromHere = "";
			var fileName = "";
			var siteRoot = "";
			if (arrayLen(arguments) eq 1) {
				fileName = arguments[1];
				fromHere = PlugBox.BoxPath;
			} else {
				fileName = arguments[2];
				fromHere = arguments[1];
			}
			
			siteRoot = pb_webRoot(fromHere);
			// Make a relative path to a file/dir from the webroot of the site...
			if (len(siteRoot)) {
				return siteRoot & "\" & fileName;
			} else {
				return fileName;
			}
		}
		
		function pb_serviceNew(comments) {
			var service = StructNew();
			
			service.Comments = comments;
			service.level = 1;
			service.subpath = "";
			
			if (arrayLen(arguments) GTE 2) {
				service.level = arguments[2];
			}
			
			if (arrayLen(arguments) GTE 3) {
				service.subpath = arguments[3];
			}
	
			return service;
		}
		
		function pb_serviceAvailable(serviceName) {
			// Takes a service name (fuseaction) and returns the level of the 
			// service offered if the rootWeb can supply the service, or 0 if the 
			// service is not offered at all.
			if (listFind(StructKeyList(REQUEST.Services), UCase(serviceName))) {
				return REQUEST.Services[serviceName].level;
			} else {
				return 0;
			}
		}
	</CFSCRIPT>
</CFSILENT>
