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
	<CFSET Local.CFG.RelativeHere = 
	 Replace(ReplaceNoCase(CFG.OurDirectory, CFG.WebRoot, ""), "\", "/", "ALL")>
	
	<!--- Where will we store the images, default to "images/userImages"
		- in the current directory
		--->
	<CFIF NOT (IsDefined("CFG.ImagesDirectory") AND IsDefined("CFG.ImagesURL"))>
		<CFSET Local.CFG.ImagesDirectory = CFG.OurDirectory & "images\userImages">
		<CFSET Local.CFG.ImagesURL       = 
			CFG.AbsoluteWebURL & "/" & Local.CFG.RelativeHere & "images/userImages">
	</CFIF>
		
	<!--- Default width value, over ridden by ATTRIBUTES.Width --->
	<CFSET Local.CFG.Width  = "640px">
	<CFSET Local.CFG.Height = "480px">
	<CFIF ATTRIBUTES.FuseAction eq "soEditor"
	OR    ATTRIBUTES.FuseAction eq "soEditorImage"
	OR    ATTRIBUTES.FuseAction eq "soEditorImageUpload"
	OR    ATTRIBUTES.FuseAction eq "soEditorHelp">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFIF>
	
	<!--- Need to pass the path to the scripts to soGui --->
	<CFSET Local.CFG.soScriptPath = Local.CFG.RelativeHere & "siteobjects/soeditor/lite/">
	
</CFSILENT>