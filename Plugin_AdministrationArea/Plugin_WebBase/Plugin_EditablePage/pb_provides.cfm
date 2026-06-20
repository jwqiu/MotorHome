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
	<CFSET Provides["#xxPluginName#List"]   = pb_serviceNew("List #xxPluginName#. <XMENU>Content:Editable Web Pages</XMENU>")>
	<CFSET Provides["#xxPluginName#Edit"]   = pb_serviceNew("Edit #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#New"]     = pb_serviceNew("Edit #xxPluginName#.")>
	<CFSET Provides["#xxPluginName#Tree"]   = pb_serviceNew("Treeview #xxPluginName#.")>
	
	<CFSET Provides["#xxPluginName#Query"]  = pb_serviceNew("Query #xxPluginName#.")>

</CFSILENT>