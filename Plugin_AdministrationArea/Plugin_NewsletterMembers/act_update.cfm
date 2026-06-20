<CFSILENT>
	<!---
		- Take a set of attributes containing values to update a record with
		- and then update the record --->
	
	<CFIF NOT ListFind(getbaseTagList(), "CFTRANSACTION")>
		<CFTRANSACTION>
			<!--- Call ourselves again, recursively 
				- 	this is done because nesting of transactions is not permitted
				-   this way we can be called by another service who already has
				-   started a transaction 
				--->
			<CFINCLUDE TEMPLATE="act_update.cfm">
		</CFTRANSACTION>
	<CFELSE>
		
		<!--- Validate the fields --->
		<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES#
			FuseAction="#CFG.PlName#Validate"/>
		
		<!--- Set validated attributes to our attributes (inlcudes entryErrors and errorFields)--->
		<CFSET RC = StructAppend(ATTRIBUTES, CFMODULE.ATTRIBUTES.VALIDATED, "Yes")>	
	
		<CFIF NOT Len(ATTRIBUTES.entryErrors)>
			<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" 
				DBTYPE="#CFG.DBTYPE#" NAME="Q_Update#CFG.PlName#">
	        	UPDATE #CFG.PlTableName#
				SET
					#CFG.PlTablePrimaryKey# = #CFG.PlTablePrimaryKey#
					<CFOUTPUT QUERY="CFG.Fields">
						<CFIF IsDefined("ATTRIBUTES.#FieldName#") AND type neq "multilookup">
							,#FieldName# = 
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
					WHERE 
						#CFG.PlTablePrimaryKey# = #ATTRIBUTES[CFG.PlTablePrimaryKey]#
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