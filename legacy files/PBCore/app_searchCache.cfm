<CFSILENT>
	<!----------------------------------------------------------------
		- PlugBox Core : searchCache
		--------------------------------------------------------------
		- This file contains the routines that plugbox applications
		- use to search for a cached service request result.
		-
		- When executing a service request, the variable CFG.CacheThis
		- may be set to one of four values - "Request", "Session", 
		- "Application" and "No", the contents of this variable
		- causes the page to be cached within one of these scopes.
		- 
		- This file will check for any given service request if it has been
		- cached.  If it has, then the cached version will be returned.
		- --->
		
	<!--- Calculate the cache key.  This is done by first removing the 
		- CFID and CFTOKEN from the attributes given the service (because
		- these would interfere for application level caching), serializing
		- the resultant attributes and hashing the serialization.
		-
		- The serialization and hash could potentially be a problem, but a 
		- better solution for getting a unique identification of a request
		- hasn't presented itself.  One other problem, aside from speed
		- is that the same set of attributes, given in a different order,
		- could produce a different key. Generally though that wouldn't
		- happen. --->
	<CFSCRIPT>
		ServiceAttributes = Duplicate(ATTRIBUTES);
		StructDelete(ServiceAttributes, "CFTOKEN", "No");
		StructDelete(ServiceAttributes, "CFID", "No");
	</CFSCRIPT>
	<CFWDDX ACTION="CFML2WDDX" INPUT=#ServiceAttributes# OUTPUT="ServiceAttributes">
	<CFSET ServiceCacheKey = Hash(ServiceAttributes)>
		
	<!--- the timeout is effectively saying that if it takes longer
		- to get into the cache than that then it'll be quicker to 
		- generate a page --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.ServiceCacheLock#" TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#" 
	  TYPE="EXCLUSIVE" THROWONTIMEOUT="No">
	  
		<!--- Set up the three levels of cache structure, REQUEST, SESSION and APPLICATION
			- REQUEST level is for services that may change between but not within requests
			- SESSION level is for services that change from user to user but not for a given user
			- APPLICATION level is for services that change only very rarely and are the same for 
			- all users (eg a static page returned from a database) --->
		
		<!--- The request and session cache's are stored in RAM, possibly the session
			- cache should be stored on disk if you are doing a lot of session level
			- cacheing, but request definatly only needs to be done in RAM. --->
		<CFPARAM NAME="REQUEST.PLUGBOX.ServiceCache" DEFAULT="#StructNew()#">
		<CFPARAM NAME="SESSION.PLUGBOX.ServiceCache" DEFAULT="#StructNew()#">
		
		<CFIF NOT IsDefined("APPLICATION.PLUGBOX.ServiceCache")>
			<!--- The application level cache is stored on disk for the most part, 
				- due to the fact that it'll hang around for a while and possibly
				- be quite large.
				--->
			<!--- If the application cache hasn't yet been initialized, clear out the
				- cache directory before we set up the structure --->
			<CFDIRECTORY ACTION="LIST" DIRECTORY="#REQUEST.PLUGBOX.CoreRoot#_Cache\" NAME="Q_CacheFiles">
			<CFLOOP QUERY="Q_CacheFiles">
				<CFIF Name neq "." AND Name neq "..">
					<CFFILE ACTION="Delete" FILE="#REQUEST.PLUGBOX.CoreRoot#_Cache\#Name#">
				</CFIF>
			</CFLOOP>
			<CFSET APPLICATION.PLUGBOX.ServiceCache = StructNew()>
		</CFIF>
		
		<!--- now we search the 3 caches in order (REQUEST > SESSION > APPLICATION)
			- and try and find a matching set of data --->
		<CFIF StructKeyExists(REQUEST.PLUGBOX.ServiceCache, ServiceCacheKey)>
			<!--- Set the structures from request structure --->
			<CFSCRIPT>
				CacheItem  = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey];
				ATTRIBUTES = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].ATTRIBUTES;
				PlugBox    = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].PlugBox;
				CFG        = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].CFG;
				LOCAL      = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].Local;
				BRANCH     = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].Branch;
				BodyData   = REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].BodyData;
			</CFSCRIPT>
		<CFELSEIF STRUCTKEYEXISTS(SESSION.PLUGBOX.SERVICECACHE, SERVICECACHEKEY)>
			<!--- Set the structures from session structure --->
			<CFSCRIPT>
				CacheItem  = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey];
				ATTRIBUTES = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].ATTRIBUTES;
				PlugBox    = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].PlugBox;
				CFG        = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].CFG;
				LOCAL      = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].Local;
				BRANCH     = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].Branch;
				BodyData   = SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].BodyData;
			</CFSCRIPT>
		<CFELSE>
			<!--- Find out if the cache key is available in the persistent cache --->
			<CFIF StructKeyExists(APPLICATION.PLUGBOX.ServiceCache, ServiceCacheKey)>
				<CFIF NOT DateCompare(Now(), APPLICATION.PLUGBOX.ServiceCache[ServiceCacheKey].Expires) eq 1>
					
					<!--- Read in the wddx file and DE-wddx it --->
					<CFFILE ACTION="READ" 
					FILE="#REQUEST.PLUGBOX.CoreRoot#_Cache\#ServiceCacheKey#.wddx" VARIABLE="CacheWDDX">
					<CFWDDX ACTION="WDDX2CFML" INPUT="#CacheWDDX#" OUTPUT="CacheItem">
					
					<!--- Read in the html file --->
					<CFFILE ACTION="READ" 
					FILE="#REQUEST.PLUGBOX.CoreRoot#_Cache\#ServiceCacheKey#.html" VARIABLE="BodyData">
					
					<!--- Set the structures from wddx --->
					<CFSCRIPT>
						ATTRIBUTES = CacheItem.ATTRIBUTES;
						PlugBox    = CacheItem.PlugBox;
						CFG        = CacheItem.CFG;
						LOCAL      = CacheItem.Local;
						BRANCH     = CacheItem.Branch;
						BodyData   = BodyData;
					</CFSCRIPT>
				</CFIF>
			</CFIF>
		</CFIF>
	</CFLOCK>
</CFSILENT>