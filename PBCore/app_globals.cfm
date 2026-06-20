<CFSILENT>
	<!---
		- Fuseboxes may be called as modules, but there is no sense to a 
		- fusebox to run in the ending execution mode.
	  --->
	<CFSET Exiting = 0>
	<CFIF IsDefined("ThisTag.ExecutionMode")>
		<CFIF ThisTag.ExecutionMode eq "end">
			<CFSET Exiting = 1>
			<CFEXIT>
		</CFIF>
	</CFIF>
	
	<!---
		- bring in the base configuration information
		--->
	<CFINCLUDE TEMPLATE="app_loadConfig.cfm">		
	
	<!---
		- Bring in the function library if it is not already
		--->
	<CFIF NOT IsDefined("wf_functions")>
		<CFINCLUDE TEMPLATE="lib_wf_functions.cfm">
	</CFIF>
</CFSILENT>