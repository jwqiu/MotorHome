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
	<CFSET xxPluginName = 
		ListLast(ListLast(ReReplace(GetDirectoryFromPath(GetCurrentTemplatePath()), "\\|/$", ""), "\/"),"_")>
		
	<CFSET Provides["#xxPluginName#Initialize"]   = pb_serviceNew("Create default tables for #xxPluginName#.")>
	
	<CFSET Provides["displayHome"]   = pb_serviceNew("Foward the user to Content/index.cfm",200)>


</CFSILENT>