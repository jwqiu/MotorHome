<CFSILENT>
	<!--------------------------------------------------------------------------
		-	Run Core
		------------------------------------------------------------------------
		- This file should not need to be modified.
		- First we collect some basic info about the current directory
		- The we run the core from the application's PBCore directory
		----------------------------------------------------------------------->
	
	<!--- *************************** BOOTSTRAP *************************** --->
	<CFIF IsDefined("ThisTag.ExecutionMode")>
		<CFIF ThisTag.ExecutionMode eq "end">
			<CFEXIT>
		</CFIF>
	</CFIF>
	
	<CFSET   PlugBox = StructNew()>
	<!--- Create a "BoxKey" for this directory, which is simply
		- a unique identifier which gets used as a key in an array --->
	<CFSET PlugBox.BoxKey = Hash(GetCurrentTemplatePath())>

	<!--- Work out what the path to this directory is --->
	<CFSET PlugBox.BoxPath = GetDirectoryFromPath(GetCurrentTemplatePath())>
	
	<!--- Go up to find a relative path to the application.cfm so we can 
		- find the PBCore directory --->
	<CFSET PlugBox.RelativeApp = 
		REQUEST.pb_relPath(PlugBox.BoxPath, REQUEST.AppRoot)>
	
	<!--- ************************* RUN THE CORE ************************** --->
</CFSILENT>
<CFINCLUDE TEMPLATE="#PlugBox.RelativeApp#/PBCore/app_core.cfm">
