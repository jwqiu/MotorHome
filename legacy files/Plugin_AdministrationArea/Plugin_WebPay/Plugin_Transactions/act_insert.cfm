<CFSILENT>
	<!---
		- Take a set of attributes containing values to update a record with
		- and then update the record --->
	
	<CFIF NOT ListFind(getbaseTagList(), "CFTRANSACTION") >
		<CFTRANSACTION>
			<!--- Call ourselves again, recursively 
				- 	this is done because nesting of transactions is not permitted
				-   this way we can be called by another service who already has
				-   started a transaction 
				--->
			<CFINCLUDE TEMPLATE="act_insert.cfm">
		</CFTRANSACTION>
	<CFELSE>
		<!--- Validate the fields first --->
		<CFINCLUDE TEMPLATE="inc_validate.cfm">
		
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_NxtID">
				SELECT Max(#CFG.PlTablePrimaryKey#) AS MaxID FROM #CFG.PlTableName#
			</CFQUERY>
			<CFIF Len(Q_NxtID.MaxID)>
				<CFSET ATTRIBUTES[CFG.PlTablePrimaryKey] = Q_NxtID.MaxID + 1>
			<CFELSE>
				<CFSET ATTRIBUTES[CFG.PlTablePrimaryKey] = 1>
			</CFIF>
		
			<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" 
				DBTYPE="#CFG.DBTYPE#" NAME="Q_Update#CFG.PlName#">
				INSERT INTO #CFG.PlTableName#
					(#CFG.PlTablePrimaryKey#
					<CFOUTPUT QUERY="CFG.Fields">
						<CFIF IsDefined("ATTRIBUTES.#FieldName#") AND Type neq "multilookup">
								, #FieldName#
						</CFIF>
					</CFOUTPUT>
					<CFIF Len(CFG.ParentTable.Name)>
						, #CFG.ParentTable.LinkField#
					</CFIF>
					)
				VALUES
				( #ATTRIBUTES[CFG.PlTablePrimaryKey]#
				  <CFOUTPUT QUERY="CFG.Fields">
						<CFIF IsDefined("ATTRIBUTES.#FieldName#") AND Type neq "multilookup">
								,
								<CFIF ATTRIBUTES[FieldName] eq CFG.pb_null>
									NULL
								<CFELSE>
									<CFSWITCH EXPRESSION="#Type#">
										<CFCASE VALUE="date">
											#CreateODBCDateTime(ATTRIBUTES[FieldName])#
										</CFCASE>
										<CFCASE VALUE="boolean,checkbox,lookup,integer,float,dollars,percent">
											#ATTRIBUTES[FieldName]#
										</CFCASE>
										<CFDEFAULTCASE>
											'#Replace(ATTRIBUTES[FieldName], "'", "''", "ALL")#'
										</CFDEFAULTCASE>
									</CFSWITCH>
								</CFIF>
						</CFIF>
				  </CFOUTPUT>
					<CFIF Len(CFG.ParentTable.Name)>
						, 
						<CFIF ATTRIBUTES[CFG.ParentTable.LinkField] eq CFG.pb_null>
							NULL
						<CFELSE>
							#ATTRIBUTES[CFG.ParentTable.LinkField]#
						</CFIF>
					</CFIF>
				)
			</CFQUERY>	
			<!--- Any multilookup fields need to added into the appropriate table --->
			<CFLOOP QUERY="CFG.Fields">
				<CFIF Type eq "multilookup" AND IsDefined("ATTRIBUTES.#FieldName#")>
					<!--- First delete any exitsing records --->
					<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_DelExist">
						DELETE FROM #LinkTableName# 
						WHERE #LinkTableOurKey# = #ATTRIBUTES[CFG.PlTablePrimaryKey]#
					</CFQUERY>
					<!--- Now insert from the field list --->
					<CFIF ATTRIBUTES[FieldName] neq CFG.pb_null>
					<CFLOOP LIST="#ATTRIBUTES[FieldName]#" INDEX="TheirKey">
						<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#" NAME="Q_InsNew">
							INSERT INTO #LinkTableName# (#LinkTableOurKey#, #LinkTableTheirKey#)
							VALUES (#ATTRIBUTES[CFG.PlTablePrimaryKey]#, #TheirKey#)
						</CFQUERY>
					</CFLOOP>
					</CFIF>
				</CFIF>
			</CFLOOP>
		</CFIF>
	</CFIF>
	
</CFSILENT>