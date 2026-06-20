<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Provides
    	------------------------------------------------------------------------
    	- This is where you specify what services (fuseactions) this
		- directory can provide.  The format is simple....
		-
		-  Provides.ServiceName = pb_serviceNew("Comments"[, Level])
		- 
		- to make a service override a service of the same name offered
		- by another directory you should supply the Level argument
		- as a level higher than the overridden service's level
		- (level's default to 1)
		-
		- Example :
		- <CFSET Provides.helloWorld = pb_serviceNew("Say hello.")>
    	----------------------------------------------------------------------->
	
		<CFSET Provides.search = pb_serviceNew("Display simple search form.")>
		<CFSET Provides.listing = pb_serviceNew("Display search results.")>
		<CFSET Provides.listingDetails = pb_serviceNew("Display detailed view of a listing.")>
		<CFSET Provides.sendEnquiry = pb_serviceNew("Send enquiry to listing owner.")>
	
</CFSILENT>