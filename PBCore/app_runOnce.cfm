<CFSILENT>
	<!--------------------------------------------------------------------------
		- RunOnce
		------------------------------------------------------------------------
		- As the name implies this file is run once per request from the 
		- application.cfm file.  
		----------------------------------------------------------------------->
	
	<!--- Setup the application tag ---> 
	<CFAPPLICATION NAME="#Hash(GetCurrentTemplatePath()&CGI.HTTP_HOST)#" CLIENTMANAGEMENT="Yes"
	   CLIENTSTORAGE="Registry"  SESSIONMANAGEMENT="Yes"
	   SESSIONTIMEOUT=#CreateTimeSpan(1,0,0,0)#
	   SETCLIENTCOOKIES="Yes"
	   APPLICATIONTIMEOUT=#CreateTimeSpan(1,0,0,0)#>
	
	<!--- Make a structure in REQUEST for the PlugBox stuff --->
	<CFSET REQUEST.PlugBox = StructNew()>
	
	<!--- The full path to the core --->
	<CFSET REQUEST.PlugBox.CoreRoot  = GetDirectoryFromPath(GetCurrentTemplatePath())>
	<CFSET REQUEST.CoreRoot          = REQUEST.PlugBox.CoreRoot>
	
	<!--- The full path to the root of the application. --->
	<CFSET REQUEST.PlugBox.AppRoot  = ReplaceNoCase(REQUEST.PlugBox.CoreRoot, "PBCore\", "")> 
	<CFSET REQUEST.AppRoot          = REQUEST.PlugBox.AppRoot>
	
	<!--- The full path to the root of the web --->
	<CFSET REQUEST.PlugBox.WebRoot  = GetDirectoryFromPath(GetBaseTemplatePath())>
	<CFSET REQUEST.WebRoot          = REQUEST.PlugBox.WebRoot>
	
	<!--- We need to use some named locks to prevent race conditions etc, 
		-   this is not a great solution for two reasons - 
		-  A) we need to create names unique to this application because lock
		-		names are server-wide not application-wide
		-  B) this will in no way prevent simultaneous writes to the APPLICATION
		-		or SESSION scopes in the case where the core is doing something in
		-		the PLUGBOX structures of these and other code is modifying other 
		-		sections.  The behaviour of CF in this case is undefined, I THINK
		- 		it should be fine because remember structures are stored by reference
		-		so editing SESSION.PLUGBOX shoudl be different internally than editing
		-		SESSION itself, we should be able to do FOO = SESSION.PLUGBOX and
		-		structClear(SESSION) without any effect to FOO, so it shoudl be fine.
		-		I just can't think of a way of doing SCOPE based locks in the core 
		-		code without unfairly limiting the abilities of services.
		---->
	<CFSET REQUEST.PLUGBOX.ServicesLock = Hash("Services" & GetCurrentTemplatePath())>
	<CFSET REQUEST.PLUGBOX.ConfigLock	= Hash("Config"   & GetCurrentTemplatePath())>
	<CFSET REQUEST.PLUGBOX.ServiceCacheLock = Hash("Cache" & GetCurrentTemplatePath())>
	<CFSET REQUEST.PLUGBOX.SessionLock  = Hash("Session"  & GetCurrentTemplatePath())>
	<CFSET REQUEST.PLUGBOX.RLockTimeout  = 10> <!--- if the locked code is required, timeout at --->
	<CFSET REQUEST.PLUGBOX.OLockTimeout  = 1>  <!--- if the locked code is optional, timeout at --->
	<CFSET REQUEST.PLUGBOX.DefaultCacheMinutes  = 5>  <!--- number of minutes cached pages are retained --->
	
	<!--- Construct our PLUGBOX structures in APPLICATION and SESSION --->
	<CFLOCK SCOPE="APPLICATION" THROWONTIMEOUT="NO" TYPE="EXCLUSIVE" TIMEOUT="#REQUEST.PLUGBOX.OLockTimeout#">
		<CFPARAM NAME="APPLICATION.PLUGBOX" DEFAULT=#StructNew()#>
	</CFLOCK>
	<CFLOCK SCOPE="SESSION" THROWONTIMEOUT="NO" TYPE="EXCLUSIVE" TIMEOUT="#REQUEST.PLUGBOX.OLockTimeout#">
		<CFPARAM NAME="SESSION.PLUGBOX" DEFAULT=#StructNew()#>
	</CFLOCK>
		
	<!--- bring in attributes --->
	<CFINCLUDE TEMPLATE="app_formURLToAttributes.cfm">
	
	<!--- Load in configuration settings --->
	<CFINCLUDE TEMPLATE="app_loadConfig.cfm">
	
	<!--- the app_runCore.cfm files need to be able to use the 
		- pb_relPath function to work out how to get back to the
		- site root from the plugin directory.  Problem is that
		- they need the path to be able to load the functions to 
		- give them the path.
		- So we put the function they need into the REQUEST scope
		- when the request is first fired.
		--->
	<CFSET REQUEST.pb_relPath = pb_relPath>
	
	<!--- Check for a hacking attempt (can cflocate) --->
	<CFINCLUDE TEMPLATE="app_hackerCheck.cfm">
	
	<!--- Check for hijackers this may need to write output, so drop out of 
		- silent running before, and go silent right after (can redirect) --->
	</CFSILENT><CFINCLUDE TEMPLATE="app_hijackerCheck.cfm"><CFSILENT>
	
	<!--- Ensure we have a services structure 
		- if we can't get this lock, it just means that another thread
		- has already done our job, so it doesn't matter --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.SERVICESLOCK#" TYPE="EXCLUSIVE" TIMEOUT="#REQUEST.PLUGBOX.OLockTimeout#" THROWONTIMEOUT="No">
		<CFPARAM NAME="APPLICATION.PLUGBOX.Services" DEFAULT=#StructNew()#>
	</CFLOCK>
	
	<!--- Setup error pages --->
	<CFIF Len(CFG.errorMail)>
		<CFERROR TYPE="REQUEST"                   TEMPLATE="app_error-request.cfm"    MAILTO="CFG.errorMail">
		<CFERROR TYPE="EXCEPTION" EXCEPTION="ANY" TEMPLATE="app_error-exception.cfm"  MAILTO="CFG.errorMail">
	</CFIF>
	
	<!--- Save Return Fuse Action if one is supplied --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.SESSIONLOCK#" TYPE="EXCLUSIVE" 
	  THROWONTIMEOUT="Yes" TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#">
		<CFPARAM NAME="SESSION.PLUGBOX.RFAStack" DEFAULT="#ArrayNew(1)#">
		<CFIF IsDefined("ATTRIBUTES.RFA") AND Len(ATTRIBUTES.RFA)>
			<CFSET SESSION.PLUGBOX.RFAStack[ArrayLen(SESSION.PLUGBOX.RFAStack) + 1] = ATTRIBUTES.RFA>
			<CFSET x = StructDelete(ATTRIBUTES, "RFA")>
		</CFIF>
	</CFLOCK>
	
	
	<!--- handle backStack (this can cflocate) --->
	<CFINCLUDE TEMPLATE="app_backStack.cfm">	

</CFSILENT>