<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.FormName" DEFAULT="theForm">
	
	
	<!--- If this is being displayed for an edit, and it's not a reedit of the form after a failure
		- we need to default the values from the database (note that if primary key is given, we
		- determine this to be an edit, if it's not, then it's not an edit.
		--->
	<CFIF IsDefined("ATTRIBUTES.#CFG.PlTablePrimaryKey#") AND NOT IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" 
			DBTYPE="#CFG.DBTYPE#" NAME="Q_Details">
	    	SELECT * FROM #CFG.PlTableName#
			WHERE #CFG.PlTablePrimaryKey# = #Evaluate("ATTRIBUTES." & CFG.PlTablePrimaryKey)#
	    </CFQUERY>
		
		<CFSET DefaultValues = StructNew()>
		<CFLOOP LIST="#Q_Details.ColumnList#" INDEX="Col">
			<CFSET DefaultValues[Col] = Evaluate("Q_Details." & Col)>
			<CFSET DefaultValues["#Col#_V"] = Evaluate("Q_Details." & Col)>
		</CFLOOP>

		<!--- Any multilookups need to have thie list of existing selections
			- made up. --->
		<CFLOOP QUERY="CFG.Fields">
			<CFIF Type eq "multilookup">
				<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_Existing">
               	SELECT #LinkTableTheirKey# AS SelID FROM #LinkTableName#
				WHERE #LinkTableOurKey# = #ATTRIBUTES[CFG.PlTablePrimaryKey]#
                </CFQUERY>
				<CFSET DefaultValues[FieldName] = ValueList(Q_Existing.SelID)>
			</CFIF>
		</CFLOOP>
		
		<CFSET RC = StructAppend(ATTRIBUTES, DefaultValues, "No")>
	</CFIF>
	
	<!--- 
		- Accept attributes for each of the fields this plugin handles
		- provide defaults if not supplied
		- display a form containing the appropriate values otherwise
		- used internally by edit and new services --->

	<CFLOOP QUERY="CFG.Fields">
		<!--- These are "switched" so that special logic may be used per
			- field/type if necessary --->
		<CFSWITCH EXPRESSION="#FieldName#">
			<CFDEFAULTCASE>
				<CFSWITCH EXPRESSION="#Type#">
					<CFCASE VALUE="lookup,multilookup">
						<!--- Lookup's need to get a query --->
						<CFPARAM NAME="ATTRIBUTES.#FieldName#" DEFAULT="#CFG.pb_null#">
						<CFPARAM NAME="ATTRIBUTES.#FieldName#_V" DEFAULT="#CFG.pb_null#">
						<CFMODULE TEMPLATE="#CFG.TopLevel#" 
							FUSEACTION="#LinkQueryFuseaction#" />
						<CFPARAM NAME="Lookups" DEFAULT=#StructNew()#>
						<CFSET Lookups[FieldName] = CFMODULE.Attributes.Q_ListQuery>
					</CFCASE>
					
					<CFDEFAULTCASE>	
						<CFPARAM NAME="ATTRIBUTES.#FieldName#_V" DEFAULT="#CFG.pb_null#">
						<CFPARAM NAME="ATTRIBUTES.#FieldName#" DEFAULT="#CFG.pb_null#">
					</CFDEFAULTCASE>
				</CFSWITCH>
			</CFDEFAULTCASE>	
		</CFSWITCH>
	</CFLOOP>
</CFSILENT>