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
	
	<CFSET Provides["configureWebPay"]   = 
		                       pb_serviceNew("Configure attributes of the WebPay system.<XMENU>Configuration:Payment Processor</XMENU>")>
	<CFSET Provides["initializeWebPay"]   = 
		                       pb_serviceNew("Initialize the tables for a WebPay system.")>
							   
	<CFSET Provides["displayHome"]   =
							   pb_serviceNew("Forward the user to the checkout page.",50)>
</CFSILENT>