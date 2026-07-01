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
	
	<CFSET Provides["Manual_ConfigForm"]  = pb_serviceNew("Display fields used to configure manual processor.")>
	<CFSET Provides["Manual_PaymentForm"] = pb_serviceNew("Display fields used to make payment using manual processor.")>
	<CFSET Provides["Manual_Charge"]      = pb_serviceNew("Charge a credit card using manual processor, produces a paymentDetails WDDX.")>
	<CFSET Provides["Manual_presentDetails"]      = pb_serviceNew("Present details, given a paymentDetails WDDX.")>
</CFSILENT>