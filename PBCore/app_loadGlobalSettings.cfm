<CFSILENT>

	<!---
		- bring in the base configuration information
		--->
	<CFINCLUDE TEMPLATE="app_loadConfig.cfm">		
	
	<!---
		- Bring in the function library if it is not already
		--->
	<CFIF NOT IsDefined("pb_functions")>
		<CFINCLUDE TEMPLATE="lib_pb_functions.cfm">
	</CFIF>
	
</CFSILENT>