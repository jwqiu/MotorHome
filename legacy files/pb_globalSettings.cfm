<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Global Settings
    	------------------------------------------------------------------------
    	- This file is used to define the settings that you want visible to all
		- plugins in your application.  It's the usual place for things like
		- database connection definitions.
		-
		- The PlugBox specification provides some global settings for you
		-	CFG.AppRoot :
		-		absolute path to the root of your "application"
		-   CFG.WebRoot :
		-		absolute path to the root of the  "web"
    	----------------------------------------------------------------------->

	 <!--- Database location
		 -
		 - "No Datasource" Connection Example : 
		 - <CFSET CFG.DS = ""> <CFSET CFG.DBTYPE="dynamic"> 
		 - <CFSET CFG.CONNECTSTRING= "Driver={Microsoft Access Driver (*.mdb)};DBQ=#REQUEST.AppRoot#/_Database/myDatabase.mdb;UID=Admin;Pwd=;">
		 -
		 - "Datasource" Connection Example :
		 - <CFSET CFG.DS="myDatasource"> <CFSET CFG.DBTYPE="odbc">
		 - <CFSET CFG.CONNECTSTRING="">
		 -
		 - No Database At All Example :
		 - <CFSET CFG.DS=""> <CFSET CFG.DBTYPE="">
		 - <CFSET CFG.CONNECTIONSTRING="">
		 --->
<!---	<CFSET CFG.DS = ""> 
	<CFSET CFG.DBTYPE = "dynamic">
	<CFSET CFG.CONNECTSTRING = "Driver={Microsoft Access Driver (*.mdb)};DBQ=#REQUEST.AppRoot#/_Database/webfusion.mdb;UID=Admin;Pwd=;">
--->	
	<CFSET CFG.DS = "motorhomeex"> 
	<CFSET CFG.DBTYPE = "">
	<CFSET CFG.CONNECTSTRING = "">
	
	<!--- Required Settings
		- the following are required by the PlugBox itself
		-	CFG.WebSiteName :
		-		name of your website
		-   CFG.AbsoluteWebURL :
		-		URL to where the Application.cfm file is, this is probably the 
		-		root of your site (eg http://www.your.site).
		-	CFG.DefaultFuseAction :
		-		Fuseaction to use when no fuseaction is given
		-   CFG.errorMail  :
		-		email address to send error reports to   (empty = off)
		-   CFG.hackerURL  :
		-		URL to send possible hack attempts to
		-   CFG.hackerMail :
		-		email address to notify of hack attempts (empty = off)
		-	CFG.debug      :
		-		set to 1 to allow debug output to appear, or 0 to turn it off
		--->
	<!--- <CFSET CFG.WebSiteName = "Example PlugBox Application"> --->
	<CFSET CFG.AbsoluteWebURL = 
		"#IIF(ListFindNoCase('on,true,1,yes', CGI.HTTPS), DE('https'), DE('http'))#://#CGI.SERVER_NAME#:#CGI.SERVER_PORT#" & 
		 Replace(CGI.SCRIPT_NAME, '/' & ListLast(CGI.SCRIPT_NAME, '/'), '')>
	<CFSET CFG.defaultFuseAction = "displayHome">						
	<CFSET CFG.errorMail   = "">
	<CFSET CFG.hackerURL   = "http://www.fbi.gov/">
	<CFSET CFG.hackerMail  = "james@innovativemedia.co.nz">
	<CFSET CFG.debug       = 1>
	
	<!--- Your own settings
		- specify any of your own CFG.* settings here, or store them in a database
		- table named "Configuration" with the columns...
		- [CoID] [Co<settingName1>] ... [Co<settingNameN>]
		- and one row with CoID = 1 and other columns filled with the setting 
		- values.  You will be able to access the values as 
		- CFG.<settingName1> ... CFG.<settingNameN> (note the Co prefix is 
		- dropped).
		--->
	<CFSET CFG.ImagesDirectory = ExpandPath("Content/images")>
	<CFSET CFG.ImagesURL       = CFG.AbsoluteWebURL & "/Content/images">


</CFSILENT>