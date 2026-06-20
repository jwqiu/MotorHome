<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Key" >
	<!--- first make sure the field exists --->
	<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_ConfigFields">
		SELECT * FROM Configuration
		WHERE CoID = 1;
	</CFQUERY>
	
	<CFIF ListFindNoCase(Q_ConfigFields.ColumnList, "Co" & ListFirst(ATTRIBUTES.Key, '.') & "WDDX")>
		<!--- The column exists --->
		<CFIF ListLen(ATTRIBUTES.Key, ".") eq 1>
			<!--- We have been asked to remove this column from the database ---->
			<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" 
				CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_DelFromConfig">
				ALTER TABLE Configuration
				DROP COLUMN Co#ListFirst(ATTRIBUTES.Key, '.')#WDDX
			</CFQUERY>
		<CFELSE>
			<CFIF IsWDDX(Q_ConfigFields["Co" & ListFirst(ATTRIBUTES.Key, '.') & "WDDX"][1])>
				<!--- Extract the WDDX from the field --->
				<CFWDDX ACTION="WDDX2CFML" 
					INPUT="#Q_ConfigFields['Co' & ListFirst(ATTRIBUTES.Key, '.') & 'WDDX'][1]#" OUTPUT="TopStruct">
				
				<!--- build up a dot-sep'd list not including the last item --->
				<CFSET  ParentStructPath = "">
				<CFLOOP FROM="2" TO="#Evaluate(ListLen(ATTRIBUTES.Key, '.') - 2)#" INDEX="listID">
					<CFSET ParentStructPath = ParentStructPath & '.' & ListGetAt(ATTRIBUTES.Key, listID, '.')>
				</CFLOOP>
				
				<CFIF IsDefined("TopStruct#ParentStructPath#") AND 
					  IsStruct(Evaluate("TopStruct#ParentStructPath#"))>
					
					<!--- Ok, the parent is a structure, so we can delete the key --->
					<CFSET retVal = 
						StructDelete(Evaluate("TopStruct#ParentStructPath#"), ListLast(ATTRIBUTES.Key, '.'), "No")>
					
					<!--- WDDX the result back up --->
					<CFWDDX INPUT=#TopStruct# OUTPUT="TopStructWDDX" ACTION="CFML2WDDX">
					
					<!--- Update in DB --->
					<CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" 
						CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="Q_SaveBackToConfig">
						UPDATE TABLE Configuration
						SET Co#ListFirst(ATTRIBUTES.Key, '.')#WDDX = '#TopStructWDDX#'
					</CFQUERY>
				</CFIF>
			</CFIF>
		</CFIF>	
	</CFIF>
	
	<!--- Done, remember to do a force CFG reload ! --->
	
</CFSILENT>