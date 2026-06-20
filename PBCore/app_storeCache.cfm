<CFSILENT>
	<!----------------------------------------------------------------
		- PlugBox Core : storeCache
		--------------------------------------------------------------
		- This file contains the routines that plugbox applications
		- use to save the result of a service request into the cache.
		-------------------------------------------------------------->
	<CFPARAM NAME="CFG.CacheThis" DEFAULT="0">
	<!--- If we can't lock, the page just doesn't get cached, big deal. --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.SERVICECACHELOCK#" TIMEOUT="0" THROWONTIMEOUT="No">
	<CFIF CompareNoCase(CFG.CacheThis, "Request") eq 0>
		<!--- We are asked to cache the service output for this request
			- only. (For things that change from request to request
			- but not within a request) --->
			<CFSCRIPT>
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey] = StructNew();
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].ATTRIBUTES = ATTRIBUTES;
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].PlugBox = PlugBox;
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].CFG = CFG;
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].Local = Local;
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].Branch = Branch;
				REQUEST.PLUGBOX.ServiceCache[ServiceCacheKey].BodyData = BodyData;
			</CFSCRIPT>
			
		<CFIF NOT IsDefined("ThisTag.ExecutionMode")>
			<!--- because this is request level caching, and this is a top-level
				- service we don't want the user's browser to cache this for the
				- next request.  --->
			<CFHEADER NAME="Cache-Control" VALUE="no-cache">
			<CFHEADER NAME="Pragma"        VALUE="no-cache">
			<CFHEADER NAME="Expires"       VALUE="Mon, 06 Jan 1990 00:00:01 GMT">
		</CFIF>
	<CFELSEIF CompareNoCase(CFG.CacheThis, "Session") eq 0>
		<!--- Cache this service for the user's session.  Used for things that are
			- unique to a user but don't change for the user within a single session
			--->
		<CFSCRIPT>
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey] = StructNew();
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].ATTRIBUTES = ATTRIBUTES;
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].PlugBox = PlugBox;
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].CFG = CFG;
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].Local = Local;
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].Branch = Branch;
			SESSION.PLUGBOX.ServiceCache[ServiceCacheKey].BodyData = BodyData;
		</CFSCRIPT>
			
		<CFIF NOT IsDefined("ThisTag.ExecutionMode")>
			<!--- As this is a top-level and shoudl be session-cached, the user
				- doesn't need to re-download until thier session expires,
				- so we'll tell the browser not to worry for 20 minutes or so
				--->
			<CFHEADER NAME="Expires"       
			   VALUE="#DateFormat(DateAdd('n', 20, Now()), 'ddd, dd mmm yyyy')# #TimeFormat(DateAdd('n', 20, Now()), 'HH:mm:ss')#">
			<CFHEADER NAME="Cache-Control"   VALUE="pre-check=#Evaluate('20 * 60')#">
		</CFIF>
	
	<CFELSEIF (CompareNoCase(CFG.CacheThis, "Application") eq 0) OR CFG.CacheThis>
		<CFIF NOT IsNumeric(CFG.CacheThis)>
			<CFSET CFG.CacheThis = REQUEST.PLUGBOX.DefaultCacheMinutes>
		</CFIF>
		<!--- This request is permitted to be cached. --->
		<CFSCRIPT>
			CacheItem = StructNew();
			CacheItem.Attributes = ATTRIBUTES;
			CacheItem.PlugBox = PlugBox;
			CacheItem.CFG = CFG;
			CacheItem.Local = Local;
			CacheItem.Branch = Branch;
		</CFSCRIPT>
		<CFWDDX ACTION="CFML2WDDX" INPUT=#CacheItem# OUTPUT="CacheWDDX">
		
		<CFFILE ACTION="WRITE" 
			FILE="#REQUEST.PLUGBOX.CoreRoot#_Cache\#ServiceCacheKey#.wddx" OUTPUT="#CacheWDDX#">
			
		<CFFILE ACTION="WRITE" 
			FILE="#REQUEST.PLUGBOX.CoreRoot#_Cache\#ServiceCacheKey#.html" OUTPUT="#BodyData#">
			
		<CFSET APPLICATION.PLUGBOX.ServiceCache[ServiceCacheKey] = StructNew()>
		<CFSET APPLICATION.PLUGBOX.ServiceCache[ServiceCacheKey].Expires
				 = DateAdd('n', CFG.CacheThis, Now())>
		<CFSET APPLICATION.PLUGBOX.ServiceCache[ServiceCacheKey].Service = ATTRIBUTES.FuseAction>

		<CFIF NOT IsDefined("ThisTag.ExecutionMode")> 
			<!--- If this is a top level, try and get the browser to cache it --->
			<CFHEADER NAME="Expires"       
			   VALUE="#DateFormat(DateAdd('n', CFG.CacheThis, Now()), 'ddd, dd mmm yyyy')# #TimeFormat(DateAdd('n', CFG.CacheThis, Now()), 'HH:mm:ss')#">
			<CFHEADER NAME="Cache-Control"   VALUE="pre-check=#Evaluate('CFG.CacheThis * 60')#">
		</CFIF>
		
	<CFELSEIF NOT IsDefined("ThisTag.ExecutionMode")>
		<!--- Caching is disabled AND this is the top level, we output some
			- special HTTP headers to indicate that the browser should never
			- cache this request. --->
		<CFHEADER NAME="Cache-Control" VALUE="no-cache">
		<CFHEADER NAME="Pragma"        VALUE="no-cache">
		<CFHEADER NAME="Expires"       VALUE="Mon, 06 Jan 1990 00:00:01 GMT">
	</CFIF>
	</CFLOCK>
</CFSILENT>