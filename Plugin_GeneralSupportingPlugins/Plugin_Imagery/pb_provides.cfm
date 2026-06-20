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
	
	<CFSET Provides.imageManager     = pb_serviceNew("Display an image manager.")>
	<CFSET Provides.imageManagerTree = pb_serviceNew("Display a tree for browsing for images.")>
	<CFSET Provides.imageManagerTreeData = pb_serviceNew("Provides data for browse tree.")>
	<CFSET Provides.imageManagerThumbView = pb_serviceNew("Displays thumbnails of images.")>
	<CFSET Provides.imageManagerURLPane   = pb_serviceNew("Component used in image manager.")>
	<CFSET Provides.imager           = pb_serviceNew("Return an image optionally resized.")>
	<CFSET Provides.imageManagerFieldButtons = pb_serviceNew("Displays some buttons to allow browsing for an image and filling a field from the selection.")>
</CFSILENT>