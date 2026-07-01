<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.#CFG.PlTablePrimaryKey#"> <!--- List of IDs --->
		
	<CFIF NOT ListFind(getbaseTagList(), "CFTRANSACTION") >
		<CFTRANSACTION>
			<!--- Call ourselves again, recursively 
				- 	this is done because nesting of transactions is not permitted
				-   this way we can be called by another service who already has
				-   started a transaction
				--->
			<CFINCLUDE TEMPLATE="act_delete.cfm">			
		</CFTRANSACTION>
		<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=return" ADDTOKEN="Yes">
	<CFELSE>	
		<CFLOOP LIST="#ATTRIBUTES[CFG.PlTablePrimaryKey]#" INDEX="PageName">
			<CFIF NOT Find(".cfm", PageName)>
				<CFSET PageName = PageName & ".cfm">
			</CFIF>
			<CFIF FileExists(ExpandPath('Content/' & PageName)) AND FileExists(ExpandPath("Content/inc_#PageName#"))>
				<CFFILE ACTION="DELETE" FILE="#ExpandPath('Content/' & PageName)#">
				<CFFILE ACTION="DELETE" FILE="#ExpandPath('Content/inc_#PageName#')#">
			</CFIF>
		</CFLOOP>
	</CFIF>
	
	<CFSET ATTRIBUTES.Layout = "None">
</CFSILENT>