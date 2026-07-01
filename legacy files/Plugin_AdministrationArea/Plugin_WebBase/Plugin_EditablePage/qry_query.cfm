<CFSILENT>
	<!---
		- This service is used by the list and tree to either 
		- output a plain old list view or a tree view as necessary --->

	<CFIF Len(CFG.ParentTable.Name)>
		<CFPARAM NAME="ATTRIBUTES.#CFG.ParentTable.LinkField#" DEFAULT="#CFG.pb_null#">
		<CFSET   ParentLink = Evaluate("ATTRIBUTES.#CFG.ParentTable.LinkField#")>
	</CFIF>
	
	<CFPARAM NAME="ATTRIBUTES.SearchKeyword"             DEFAULT="">
	
	<CFDIRECTORY DIRECTORY="#ExpandPath('Content/')#" NAME="Q_listQuery">
	W
	<CFSET PairedFiles = "">
	<CFLOOP QUERY="Q_listQuery">
		<CFIF ListFindNoCase(ValueList(Q_listQuery.name), "inc_#name#")>
			<CFSET PairedFiles = ListAppend(PairedFiles, "'#name#'")>
		</CFIF>
	</CFLOOP>
	
	
		<CFQUERY DBTYPE="query" NAME="Q_listQuery">
			SELECT Name
			FROM Q_listQuery
			<CFIF ListLen(PairedFiles)>
			WHERE name in (#PreserveSingleQuotes(PairedFiles)#)
			<CFELSE>
			WHERE 0 = 1
			</CFIF>
		</CFQUERY>
		
	<CFSET x = QueryAddColumn(Q_listQuery, "PageName", ListToArray(ValueList(Q_listQuery.Name)))>
	
	<!--- A standard query, return "nodes" for each record --->
	<CFQUERY DBTYPE="query" NAME="Q_ListQuery">
       	SELECT * FROM Q_listQuery
		WHERE 1 = 1
		<CFIF  Len(CFG.ParentTable.Name)>
			AND #CFG.ParentTable.LinkField#
			<CFIF NOT ParentLink eq CFG.pb_null>
			= #ParentLink#
			<CFELSE>
			IS NULL
			</CFIF>
		</CFIF>
		<CFIF Len(ATTRIBUTES.SearchKeyword)>
		AND 
			(
				0 = 1
				<CFLOOP LIST="#CFG.PlDisplayFields#" INDEX="Field">
				OR	#Field# LIKE '%#ATTRIBUTES.SearchKeyword#%'
				</CFLOOP>
			)
		</CFIF>
		ORDER BY
			Name
    </CFQUERY>
	
	<CFSET ATTRIBUTES.Q_ListQuery = Q_ListQuery>
	<CFSET ATTRIBUTES.Layout      = "None">
	<CFSETTING SHOWDEBUGOUTPUT    = "No">
</CFSILENT>