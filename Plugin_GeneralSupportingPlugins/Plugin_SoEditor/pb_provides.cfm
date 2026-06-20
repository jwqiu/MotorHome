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
	<CFSET Provides.showPopupEditor = pb_serviceNew("Show an editor in a popup window.")>
	<CFSET Provides.popupEditor     = pb_serviceNew("Show an editor in a popup window.")>
	<CFSET Provides.htmlArea        = pb_serviceNew("Create an HTMLArea for a form.")>
	<CFSET Provides.soEditor        = pb_serviceNew("Show a soEditor component for a form.")>
	<CFSET Provides.soEditorImage   = pb_serviceNew("Show soEditor image manager.")>
	<CFSET Provides.soEditorImageUpload   = pb_serviceNew("Upload an image for soEditor.")>
	<CFSET Provides.soEditorHelp	= pb_serviceNew("Show soEditor help.")>
</CFSILENT>