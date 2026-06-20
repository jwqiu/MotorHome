<CFSILENT>
	<!---
		- This file is used by both act_insert.cfm and act_update.cfm,
		- it's split off because it's identical no matter which is being used.
		--->
		
		
	<CFLOOP QUERY="CFG.Fields">
		<!--- First check for the basics --->
		<CFPARAM NAME="ATTRIBUTES.#FieldName#" DEFAULT="#CFG.pb_null#">
		<CFSET Value = Attributes[FieldName]>
		<CFIF NOT Len(Value)>
			<CFSET Value = CFG.pb_null>
		</CFIF>
		<!--- Field Is Required --->
		<CFIF Required>
			<CFIF (NOT Len(Value)) OR Value eq CFG.pb_null>
				<CFSET ATTRIBUTES.entryErrors = ATTRIBUTES.entryErrors &
					";#DisplayName# is a required field.">
				<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, FieldName)>
			</CFIF> 
		</CFIF>
		
		<!--- Field must be verified --->
		<CFIF Verify>
			<CFPARAM NAME="ATTRIBUTES.#FieldName#_V" DEFAULT="#CFG.pb_null#">
			<CFSET   Value_V = Evaluate("ATTRIBUTES.#FieldName#_V")>
			<CFIF NOT Len(Value_V)>
				<CFSET Value_V = CFG.pb_null>
			</CFIF>
			<CFIF Value_V neq Value>
				<CFSET ATTRIBUTES.entryErrors = 
					ATTRIBUTES.entryErrors & ";Please verify " & 
					DisplayName &	" by entering the same value in to the Verify " &
					DisplayName & " field.">
				<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, "#FieldName#_V")>
			</CFIF>
		</CFIF>
				
		<!--- Specifics for different data types --->
		<CFSWITCH EXPRESSION="#Type#">
			<CFCASE VALUE="date">
				<CFIF LSIsDate(Value)>
					<CFSET Value = LSParseDateTime(Value)>
				<CFELSEIF Value neq CFG.pb_null>
					<CFSET ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";The date entered into " & 
						DisplayName &	" (#Value#) is not a valid date.">
					<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, FieldName)>
					<CFSET Value = CFG.pb_null>
				</CFIF>
			</CFCASE>
		
			<CFCASE VALUE="boolean,checkbox">
				<CFIF ReFind("[^01]", Value) AND Value neq CFG.pb_null>
					<CFSET ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";A coding error has been encountered in field named "
						& FieldName & ", please contact your developer.">
					<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, FieldName)>
					<CFSET Value = CFG.pb_null>
				</CFIF>
			</CFCASE>
			
			<CFCASE VALUE="lookup,integer">
				<CFIF ReFind("[^0-9]", Value) AND Value neq CFG.pb_null>
					<CFSET ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";You may only enter integers in the " &
						DisplayName & " field.">
					<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, FieldName)>
				</CFIF>
			</CFCASE>
			
			<CFCASE VALUE="multilookup">
				<CFIF ReFind("[^0-9,]", Value) AND Value neq CFG.pb_null>
					<CFSET ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";A coding error has been encountered in field names " & FieldName & ", please contact your developer.">
					<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, Fieldname)>
				</CFIF>
			</CFCASE>
			<CFCASE VALUE="float,dollars,percent">
				<CFIF ReFind("[^0-9.]", Value) AND Value neq CFG.pb_null>
					<CFSET ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";You may only enter a decimal number in the " &
						DisplayName & " field.">
					<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, FieldName)>
				</CFIF>
			</CFCASE>
		</CFSWITCH>
		
		<!--- Uniqueness --->
		<CFIF Verify>
			<CFQUERY DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" 
					 DBTYPE="#CFG.DBTYPE#" NAME="Q_ChkUnique">
	        	SELECT Count(*) AS NonUnique
					FROM #CFG.PlTableName#
					WHERE
						#FieldName# 
						<CFIF Value eq CFG.pb_null>
						IS NULL
						<CFELSE>
							<CFSWITCH EXPRESSION="#Type#">
								<CFCASE VALUE="date">
									= #CreateODBCDateTime(Value)#
								</CFCASE>
								<CFCASE VALUE="boolean,checkbox,lookup,integer,float,dollars,percent">
									= #Value#
								</CFCASE>
								<CFDEFAULTCASE>
									= '#Value#'
								</CFDEFAULTCASE>
							</CFSWITCH>
						</CFIF>
					<CFIF IsDefined("ATTRIBUTES.#CFG.PlTablePrimaryKey#") AND 
						  Len(ATTRIBUTES[CFG.PlTablePrimaryKey])>
						AND  NOT (#CFG.PlTablePrimaryKey# = #ATTRIBUTES[CFG.PlTablePrimaryKey]#) 
					</CFIF>
	        </CFQUERY>
			<CFIF Q_ChkUnique.NonUnique>
				<CFSET ATTRIBUTES.entryErrors = 
						ATTRIBUTES.entryErrors & ";The value entered in the " &
						DisplayName & " field is already in use by another record.">
				<CFSET ATTRIBUTES.errorFields = ListAppend(ATTRIBUTES.errorFields, FieldName)>
			</CFIF>
		</CFIF>
		
		<!--- If you want to do special stuff per field you may do so here --->
		<CFSWITCH EXPRESSION="#FieldName#">


			<CFDEFAULTCASE >
				
			</CFDEFAULTCASE>	
		</CFSWITCH>
		
		<!--- Copy our validated value back into the field --->
		<CFSET ATTRIBUTES[FieldName] = Value>
	</CFLOOP>
	


</CFSILENT>