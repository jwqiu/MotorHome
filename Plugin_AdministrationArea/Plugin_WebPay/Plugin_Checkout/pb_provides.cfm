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
	
	<CFSET Provides["checkout"]   = 
		pb_serviceNew("Display & process form for payment.")>
	<CFSET Provides["accepted"]   = 
		pb_serviceNew("Tell the user the payment is accepted.")>
	<CFSET Provides["cvc2"]   = 
		pb_serviceNew("Display information about CvC2 codes.")>
</CFSILENT>