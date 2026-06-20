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
		<CFLOOP Query="CFG.ChildPlugins">
			<CFLOOP LIST="#Evaluate("ATTRIBUTES.#CFG.PlTablePrimaryKey#")#" INDEX="ParentLink">
				<!--- Get a list of child records that need to be deleted --->
				<CFSET AttCol = StructNew()>
				<CFSET AttCol.FuseAction = "#ChildName#Query">
				<CFSET AttCol[LinkField] = ParentLink>
				<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#AttCol#/>
				<CFSET Q_ToDelete = CFMODULE.Attributes.Q_ListQuery>
				<CFIF Q_ToDelete.RecordCount>
					<CFSET PKCol = PkField>
					<CFSET AttCol[PkField] = "">
					<CFLOOP QUERY="Q_ToDelete">
						<CFSET AttCol[PkCol] = listAppend(AttCol[PkCol], Evaluate(PkCol))>
					</CFLOOP>
					<!--- Delete the child records --->
					<CFSET AttCol.FuseAction = "#ChildName#Delete">
					<CFSET AttCol.AsService     = "Yes">
					<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#AttCol#/>
				</CFIF>
			</CFLOOP>
		</CFLOOP>
		
		<!--- We must also delete from any multilookup fields --->
		<CFLOOP QUERY="CFG.Fields">
			<CFIF Type eq "multilookup">
				<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_DelLookups">
                	DELETE from #LinkTableName# 
						WHERE #LinkTableOurKey#  IN (#ATTRIBUTES[CFG.PlTablePrimaryKey]#)
                </CFQUERY>
			</CFIF>
		</CFLOOP>
		
		<!--- Now delete ourself --->
		<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_DELETE">
			DELETE FROM #CFG.PlTableName#
				WHERE #CFG.PlTablePrimaryKey# IN (#ATTRIBUTES[CFG.PlTablePrimaryKey]#);
		</CFQUERY>
	</CFIF>
	
	<CFSET ATTRIBUTES.Layout = "None">
</CFSILENT>