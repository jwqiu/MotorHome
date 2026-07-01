<CFSILENT>
	<!---
		- This service is used by the list and tree to either 
		- output a plain old list view or a tree view as necessary --->

	<CFIF Len(CFG.ParentTable.Name)>
		<CFPARAM NAME="ATTRIBUTES.#CFG.ParentTable.LinkField#" DEFAULT="#CFG.pb_null#">
		<CFSET   ParentLink = Evaluate("ATTRIBUTES.#CFG.ParentTable.LinkField#")>
	</CFIF>
	
	<CFPARAM NAME="ATTRIBUTES.SearchKeyword"             DEFAULT="">
	
	<!--- A standard query, return "nodes" for each record --->
	<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" 
		DBTYPE="#CFG.DBTYPE#" NAME="Q_ListQuery">
       	SELECT * FROM #CFG.PlTableName#
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
			<CFLOOP LIST="#CFG.PlTableOrderBy#" INDEX="Field">
			#Field#,
			</CFLOOP>
			#CFG.PlTablePrimaryKey#
    </CFQUERY>
	
	<CFSET ATTRIBUTES.Q_ListQuery = Q_ListQuery>
	<CFSET ATTRIBUTES.Layout      = "None">
	<CFSETTING SHOWDEBUGOUTPUT    = "No">
</CFSILENT>