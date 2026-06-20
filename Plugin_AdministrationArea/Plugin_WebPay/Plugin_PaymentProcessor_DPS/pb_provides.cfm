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
	
	<CFSET Provides["DPS_Validate"]   = 
		                       pb_serviceNew("Validate the given attributes for DPS processor and return a WDDX.")>
	<CFSET Provides["DPS_ConfigForm"]  = pb_serviceNew("Display fields used to configure DPS processor.")>
	<CFSET Provides["DPS_PaymentForm"] = pb_serviceNew("Display fields used to make payment using DPS processor.")>
	<CFSET Provides["DPS_Charge"]      = pb_serviceNew("Charge a credit card using DPS processor, produces a paymentDetails WDDX.")>
	<CFSET Provides["DPS_presentDetails"]      = pb_serviceNew("Present details, given a paymentDetails WDDX.")>
</CFSILENT>