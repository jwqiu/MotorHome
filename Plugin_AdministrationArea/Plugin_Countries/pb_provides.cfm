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
	<CFSET xxPluginName = 
	ListLast(ListLast(ReReplace(GetDirectoryFromPath(GetCurrentTemplatePath()), "\\|/$", ""), "\/"),"_")>
	
	<CFSET Provides["#xxPluginName#Delete"] = pb_serviceNew("Delete #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#List"]   = pb_serviceNew("List #xxPluginName#. <XMENU>Configuration:Countries</XMENU>")>
	<CFSET Provides["#xxPluginName#Tree"]   = pb_serviceNew("Treeview #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Edit"]   = pb_serviceNew("Edit #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#New"]    = pb_serviceNew("New  #xxPluginName#.")>
	
	<CFSET Provides["#xxPluginName#Query"]  = pb_serviceNew("Query #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Default"] = pb_serviceNew("Default #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Form"]   = pb_serviceNew("Form  #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Validate"] = pb_serviceNew("Validate #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Insert"]   = pb_serviceNew("Insert #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Update"]   = pb_serviceNew("Update #xxPluginName#.")>
</CFSILENT>