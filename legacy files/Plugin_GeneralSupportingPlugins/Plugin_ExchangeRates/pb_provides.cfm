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
    	----------------------------------------------------------------------->
	
	<CFSET Provides["exchangeRate"]   = 
		                       pb_serviceNew("Source a recent exchange rate between two currencies.")>
	<CFSET Provides["currencyQuery"]   = 
		                       pb_serviceNew("Get a list of currencies.")>
</CFSILENT>