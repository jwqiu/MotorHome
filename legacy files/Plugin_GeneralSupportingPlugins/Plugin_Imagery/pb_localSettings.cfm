<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Local Settings
    	------------------------------------------------------------------------
    	- If you want to add anything to the CFG structure, or make any
		- other local settings that apply to this directory only
		- (settings here do not filter down to children)
		- this is the place to do it.
		-
		- The PlugBox spec defines some local settings for you...
		- CFG.OurDirectory    : 
		-		absolute path to the current directory
		- CFG.RelativeAppRoot :
		-		relative path to the root application directory 
		-		(where Application.cfm lives)
		- CFG.RelativeWebRoot :
		-		relative path to the root web directory 
		-		(where the initial fusebox.cfm/index.cfm file you requested lives)
		- CFG.CustomTags      :
		-		relative path to the directory _Tags in the root application 
		-		directory (use it for referencing custom tags !)
    	----------------------------------------------------------------------->
		
	<!--- <CFSET Local.CFG.Example = "An Example !"> --->
	<CFSET Local.CFG.RelativeHere = ReplaceNoCase(CFG.OurDirectory, CFG.WebRoot, "")>
	<CFSET Local.CFG.RelativeHere = Replace(LOCAL.CFG.RelativeHere, "\", "/", "ALL")>
	<!--- Where will we store the images, default to "images/userImages"
		- in the current directory
		--->
	<CFSET Local.CFG.ImagesDirectory = CFG.OurDirectory & "images\">
	<CFSET Local.CFG.ImagesURL       = 
		"/" & Local.CFG.RelativeHere & "images/">
		
	<!--- Turn on/off last modified date checking for images 
		- set to "yes" to enable, anything else to disable --->
	<CFSET Local.CFG.CheckLastModifiedDate = "no">
	
	<!--- Number of minutes to add to the last modified date of
		- the remote image --->
	<CFSET Local.CFG.TimeDifference = "10">


</CFSILENT>