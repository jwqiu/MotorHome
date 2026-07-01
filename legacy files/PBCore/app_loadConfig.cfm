<CFSILENT>
	<!--------------------------------------------------------------------------
		- loadConfig
		------------------------------------------------------------------------
		- This file handles loading the initial configuration information.
		----------------------------------------------------------------------->
		
	<!--- This needs functions from lib_pb_functions.cfm --->
	<CFIF NOT IsDefined("pb_functions")>
		<CFINCLUDE TEMPLATE="lib_pb_functions.cfm">
	</CFIF>
	
	<!--- If we don't get this exclusive lock, it just means that somebody
		- else is doing our job/has already done it.  So don't panic about it
		- --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.CONFIGLOCK#" TYPE="EXCLUSIVE" 
		TIMEOUT="#REQUEST.PLUGBOX.OLockTimeout#" THROWONTIMEOUT="No">
		<CFIF IsDefined("ATTRIBUTES.ForceCFGReload") OR NOT IsDefined("APPLICATION.PLUGBOX.CFG")>

			<CFSCRIPT>
				APPLICATION.PLUGBOX.CFG = StructNew();
				// AppRoot is the root of the application, it never changes
				APPLICATION.PLUGBOX.CFG.AppRoot = REQUEST.PLUGBOX.AppRoot;
			</CFSCRIPT>
			
			<!--- Include the user's settings from pb_settings.cfm 
				- (which is in the approot, which is the parent directory)]
				--->
			<CFSET CFG = StructNew()>
			<CFINCLUDE TEMPLATE="../pb_globalSettings.cfm">
			<CFSET returnValue = StructAppend(APPLICATION.PLUGBOX.CFG, CFG, "No")>
		
			<!--- Try to pull the rest of the data out of the database --->
			<CFTRY>
				<CFQUERY DATASOURCE="#APPLICATION.PLUGBOX.CFG.DS#" DBTYPE="#APPLICATION.PLUGBOX.CFG.DBTYPE#" 
						 CONNECTSTRING="#APPLICATION.PLUGBOX.CFG.CONNECTSTRING#" NAME="Q_Configuration">
					SELECT * FROM Configuration 
					WHERE CoID = 1;
				</CFQUERY>
				
				<CFSCRIPT>
					columns = Q_Configuration.ColumnList;
					while(listLen(columns)) {
						column = listFirst(columns);
						columns = listRest(columns);
						if (not structKeyExists(APPLICATION.PLUGBOX.CFG, ReplaceNoCase(column, "Co", "")) ) {
							APPLICATION.PLUGBOX.CFG[ReplaceNoCase(column, "Co", "")] = Q_Configuration[column][1];
						}
					}
				</CFSCRIPT>
				<CFCATCH TYPE="Any">
					<!--- An error just indicates that we can't get config
						- from the database. --->
				</CFCATCH>
			</CFTRY>
			
			<!--- Loop through each item in the CFG structure and if it is a WDDX UnWDDX it
				- if the key contains the string WDDX the unwddx stuff is stored as the key
				- without the first WDDX, if the key doeosn't contain WDDX it is stored as 
				- the key suffixed by an inderscore.
				-
				- eg ExtraDetailsWDDX gets unwddx'd and the result is stored in CFG.ExtraDetails
				--->
			<CFLOOP LIST="#StructKeyList(APPLICATION.PLUGBOX.CFG)#" INDEX="Key">
				<CFIF IsWDDX(APPLICATION.PLUGBOX.CFG[key])>
					<CFIF FindNoCase("WDDX", key)>
						<CFSET Target = "APPLICATION.PLUGBOX.CFG.#ReplaceNoCase(key, 'WDDX', '')#">	
					<CFELSE>
						<CFSET Target = "APPLICATION.PLUGBOX.CFG.#key#_">
					</CFIF>
					
					<CFWDDX ACTION="WDDX2CFML" INPUT="#APPLICATION.PLUGBOX.CFG[key]#" OUTPUT="#Target#">
				</CFIF>
			</CFLOOP> 
			
			<CFIF IsDefined("ATTRIBUTES.ForceCFGReload")>
				<CFSET returnVal = StructDelete(ATTRIBUTES, "ForceCFGReload")>
			</CFIF>
			
		</CFIF> 
	</CFLOCK>
	
	<!--- Bring configuration in from application settings 
		- we absolutely require to get this lock, if we don't then we don't
		- have any configuration settings ! --->
	<CFLOCK NAME="#REQUEST.PLUGBOX.CONFIGLOCK#" TYPE="READONLY" 
		TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#" THROWONTIMEOUT="Yes">
		<CFSET CFG = Duplicate(APPLICATION.PLUGBOX.CFG)>
	</CFLOCK>

	<!--- If debug is switched on in CFG turn it on in cfsetting --->
	<CFIF CFG.debug>
		<CFSETTING SHOWDEBUGOUTPUT="Yes">
	</CFIF>
	
	<!--- And put in any variables that will change from request to request --->
	<CFSET CFG.WebRoot         = REQUEST.PLUGBOX.WebRoot>
	<CFIF IsDefined("PlugBox")>
		<!--- If we don't have PlugBox yet (if this file is called from app_runOnce.cfm)
			- we can't supply these.  Just means that app_runOnce.cfm doesn't have
			- access to these values (they have no use in that context anyway).
			--->
		<CFSET CFG.OurDirectory    = PlugBox.BoxPath>
		<CFSET CFG.RelativeAppRoot = pb_appRoot(PlugBox.BoxPath)>
		<CFSET CFG.RelativeWebRoot = pb_webRoot(PlugBox.BoxPath)>
		<CFSET CFG.TopLevel        = pb_webRoot(PlugBox.BoxPath) & "\" 
			& ListLast(CGI.SCRIPT_NAME, "/")>
		<CFIF ListFindNoCase('on,true,1,yes', CGI.HTTPS)>
			<!--- Secure connection --->
			<CFSET CFG.TopURL = "https://">
		<CFELSE>
			<CFSET CFG.TopURL = "http://">
		</CFIF>
		<CFSET CFG.TopURL = CFG.TopURL & "#CGI.SERVER_NAME#:#SERVER_PORT##Replace(CGI.SCRIPT_NAME, "//", "/", "ALL")#">
		<CFSET CFG.CustomTags      = pb_relExpandPath(PlugBox.BoxPath, "_Tags")>
	</CFIF>
	
</CFSILENT>