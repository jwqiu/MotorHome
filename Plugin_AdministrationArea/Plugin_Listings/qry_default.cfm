<CFSILENT>
	
		<CFPARAM NAME="ATTRIBUTES.#CFG.PlTablePrimaryKey#">

		<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" 
			DBTYPE="#CFG.DBTYPE#" NAME="Q_Details">
	    	SELECT * FROM #CFG.PlTableName#
			WHERE #CFG.PlTablePrimaryKey# = #Evaluate("ATTRIBUTES." & CFG.PlTablePrimaryKey)#
	    </CFQUERY>
		
		<CFSET ATTRIBUTES.DefaultValues = StructNew()>
		<CFLOOP LIST="#Q_Details.ColumnList#" INDEX="Col">
			<CFSET ATTRIBUTES.DefaultValues[Col] = Evaluate("Q_Details." & Col)>
			<CFSET ATTRIBUTES.DefaultValues["#Col#_V"] = Evaluate("Q_Details." & Col)>
		</CFLOOP>

		<!--- Any multilookups need to have thie list of existing selections
			- made up. --->
		<CFLOOP QUERY="CFG.Fields">
			<CFIF Type eq "multilookup">
				<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_Existing">
               	SELECT #LinkTableTheirKey# AS SelID FROM #LinkTableName#
				WHERE #LinkTableOurKey# = #ATTRIBUTES[CFG.PlTablePrimaryKey]#
                </CFQUERY>
				<CFSET ATTRIBUTES.DefaultValues[FieldName] = ValueList(Q_Existing.SelID)>
			</CFIF>
		</CFLOOP>

</CFSILENT>