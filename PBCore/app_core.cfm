<CFSILENT>
	<!--------------------------------------------------------------------------
		-	Run Core
		------------------------------------------------------------------------
		- This file should not need to be modified.
		-
		- The file performs several duties, basically it ties the whole
		- system togethor...
		- 
		- 01) Loads the global configuration settings 
		- 02) Loads the Provides 
		- 03) Exposes our services
		- 04) Loads the branch configuration settings
		- 05) Loads the local configuration settings 
		- 05) Runs the input filter
		- 06) Runs the handler to process fuseactions
		- 07) Inserts handler results into husk file
		- 08) Runs the output filter
		- 09) Saves return data
		- 10) Output final results
		----------------------------------------------------------------------->
	<CFIF IsDefined("ThisTag.ExecutionMode")>
		<CFIF ThisTag.ExecutionMode eq "end">
			<CFEXIT>
		</CFIF>
	</CFIF>
	<!--- *********************SEARCH THE PAGE CACHE*********************** --->
	<CFINCLUDE TEMPLATE="app_searchCache.cfm">
	<CFIF NOT IsDefined("CacheItem")> <!--- Start Not Cached --->
	
	<!--- **********************LOAD GLOBAL SETTINGS*********************** --->
	<CFINCLUDE TEMPLATE="app_loadGlobalSettings.cfm">
	<CFSET PlugBox.CFG = CFG>
	
	<!--- ********************** FIND RELATIVE PATH *********************** --->
	<CFSET CallingPath = 
	pb_relPath(GetDirectoryFromPath(GetCurrentTemplatePath()), PlugBox.BoxPath)>

	<!--- *************************LOAD PROVIDES*************************** --->
	<CFSET   PlugBox.Provides = StructNew() >
	<CFSET   Provides         = PlugBox.Provides>
	<CFIF FileExists(PlugBox.BoxPath & "pb_provides.cfm")>
		<CFINCLUDE TEMPLATE="#CallingPath#/pb_provides.cfm">
	</CFIF>
	
	<!--- ***********************EXPOSE SERVICES*************************** --->
	<CFINCLUDE TEMPLATE="app_exposeServices.cfm">
	
	<!--- *********************LOAD BRANCH SETTINGS************************ --->
	<CFIF IsDefined("ATTRIBUTES.PlugBoxBranch") AND
		  Len(ATTRIBUTES.PlugBoxBranch)>
		<CFWDDX INPUT="#ATTRIBUTES.PlugBoxBranch#" OUTPUT="Branch" 
			ACTION="WDDX2CFML">
	<CFELSE>
		<CFSET Branch     = StructNew()>
		<CFSET Branch.CFG = StructNew()>
	</CFIF>

	<CFIF FileExists(PlugBox.BoxPath & "pb_branchSettings.cfm")>
		<CFINCLUDE TEMPLATE="#CallingPath#/pb_branchSettings.cfm">
	</CFIF>
	<CFSET returnVal = StructAppend(CFG, Branch.CFG, "Yes")>
	
	<CFIF ListLen(StructKeyList(Branch.CFG))>
		<CFWDDX INPUT=#Branch# 
			OUTPUT="ATTRIBUTES.PlugBoxBranch" ACTION="CFML2WDDX">
	</CFIF>
	<CFSET PlugBox.Branch = Duplicate(Branch)>
	
	<!--- *********************LOAD LOCAL SETTINGS************************* --->
	<CFSET Local = StructNew()>
	<CFSET Local.CFG = StructNew()>
	
	<CFIF FileExists(PlugBox.BoxPath & "pb_localSettings.cfm")>
		<CFINCLUDE TEMPLATE="#CallingPath#/pb_localSettings.cfm">
	</CFIF>
	<CFSET returnVal = StructAppend(CFG, Local.CFG, "Yes")>
	<CFSET PlugBox.Local = Duplicate(Local)>

	<!--- ********************** RUN INPUT FILTER ************************* --->
	<CFIF FileExists(PlugBox.BoxPath & "pb_inputFilter.cfm")>
		<CFINCLUDE TEMPLATE="#CallingPath#/pb_inputFilter.cfm">
	</CFIF>
	
	<!---  ******************** HANDLE FUSEACTION  ************************ --->
		<!--- This gives us BodyData variable --->
	<CFINCLUDE TEMPLATE="app_handler.cfm">
		
	<!--- ********************* INSERT INTO HUSK ************************** --->
	<CFIF FileExists(PlugBox.BoxPath & "pb_layoutHandler.cfm")>
		<CFSAVECONTENT VARIABLE="BodyData">
			<CFINCLUDE TEMPLATE="#CallingPath#/pb_layoutHandler.cfm">
		</CFSAVECONTENT>
	</CFIF>
	
	<!--- ********************** RUN OUTPUT FILTER ************************ --->
	<CFIF FileExists(PlugBox.BoxPath & "pb_outputFilter.cfm")>
		<CFINCLUDE TEMPLATE="#CallingPath#/pb_outputFilter.cfm">
	</CFIF>
	
	<!--- ********************** STORE INTO PAGE CACHE ******************** --->
	<CFINCLUDE TEMPLATE="app_storeCache.cfm">
	<CFELSE>
	
	</CFIF> <!--- End Not Cached Cache --->
	<!--- ********************** SAVE RETURN DATA ************************* --->
	<CFIF IsDefined("ThisTag.ExecutionMode")>
		<CFSCRIPT>
			CALLER.CFMODULE = StructNew();
			CALLER.CFMODULE.Attributes = ATTRIBUTES;
			CALLER.CFMODULE.PlugBox    = PlugBox;
			CALLER.CFMODULE.CFG        = CFG;
			CALLER.CFMODULE.Local      = Local;
			CALLER.CFMODULE.Branch     = Branch;
		</CFSCRIPT>
	</CFIF>
	
	<!--- ******************** OUTPUT FINAL RESULTS *********************** --->
</CFSILENT>
<CFOUTPUT>#Trim(BodyData)#</CFOUTPUT>
