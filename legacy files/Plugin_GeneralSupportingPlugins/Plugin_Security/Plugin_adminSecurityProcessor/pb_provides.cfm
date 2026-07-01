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
	<CFSET SMPrefix = 
		ReplaceNoCase(ListLast(GetDirectoryFromPath(GetCurrentTemplatePath()), "/\_"),
			"SecurityProcessor", "")>

	<CFSCRIPT>
		Provides["#SMPrefix#processAuthenticate"]   = pb_serviceNew("Authenticate a user.");
		Provides["#SMPrefix#processSudo"]           = pb_serviceNew("Start or end a sudo session.");
		Provides["#SMPrefix#processForgotPassword"] = pb_serviceNew("Remind a user about thier password.");
		Provides["#SMPrefix#processLogOut"]         = pb_serviceNew("Log a user out of the system.");
		Provides["#SMPrefix#processLogIn"]          = pb_serviceNew("Log a user into the system.");
	</CFSCRIPT>
</CFSILENT>