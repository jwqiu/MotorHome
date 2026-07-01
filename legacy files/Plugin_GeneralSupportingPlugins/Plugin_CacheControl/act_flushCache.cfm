<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Service" DEFAULT="">
	<CFIF IsDefined("REQUEST.PLUGBOX.ServiceCacheLock")>
		<CFLOCK NAME="#REQUEST.PLUGBOX.ServiceCacheLock#" TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#">
			<CFLOOP LIST="#StructKeyList(APPLICATION.PLUGBOX.ServiceCache)#" INDEX="CacheKey">
				<CFIF (NOT Len(ATTRIBUTES.Service)) OR
					ATTRIBUTES.Service eq APPLICATION.PLUGBOX.ServiceCache[CacheKey].Service>
					<CFSET retVal = StructDelete(APPLICATION.PLUGBOX.ServiceCache, CacheKey)>	
				</CFIF> 
			</CFLOOP>
		</CFLOCK>
	<CFELSE>
		<CFLOCK NAME="ServiceCache" TIMEOUT="5">
			<CFLOOP LIST="#StructKeyList(APPLICATION.ServiceCache)#" INDEX="CacheKey">
				<CFIF (NOT Len(ATTRIBUTES.Service)) OR
					ATTRIBUTES.Service eq APPLICATION.ServiceCache[CacheKey].Service>
					<CFSET retVal = StructDelete(APPLICATION.ServiceCache, CacheKey)>	
				</CFIF> 
			</CFLOOP>
		</CFLOCK>
	</CFIF>
	
</CFSILENT>