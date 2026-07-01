<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.FormName" DEFAULT="theForm">
	
	<!--- 
		- Accept attributes for each of the fields this plugin handles
		- provide defaults if not supplied
		- display a form containing the appropriate values otherwise
		- used internally by edit and new services --->

	<CFLOOP QUERY="CFG.Fields">
		<!--- These are "switched" so that special logic may be used per
			- field/type if necessary --->
		<CFSWITCH EXPRESSION="#FieldName#">
			<CFCASE VALUE="MeMailingList">
				<CFPARAM NAME="ATTRIBUTES.#FieldName#_V" DEFAULT="1">
				<CFPARAM NAME="ATTRIBUTES.#FieldName#" DEFAULT="1">
			</CFCASE>
			<CFDEFAULTCASE>
				<CFSWITCH EXPRESSION="#Type#">
					<CFCASE VALUE="lookup,multilookup,multilookupcheckbox">
						<!--- Lookup's need to get a query --->
						<CFPARAM NAME="ATTRIBUTES.#FieldName#" DEFAULT="#CFG.pb_null#">
						<CFPARAM NAME="ATTRIBUTES.#FieldName#_V" DEFAULT="#CFG.pb_null#">
						<CFIF isDefined("ATTRIBUTES.RestrictGroups") and ATTRIBUTES.RestrictGroups eq "Yes">
							<CFMODULE TEMPLATE="#CFG.TopLevel#" 
								FuseAction="#LinkQueryFuseaction#" RestrictGroups="Yes" />
						<CFELSE>
							<CFMODULE TEMPLATE="#CFG.TopLevel#" 
								FuseAction="#LinkQueryFuseaction#"  />
						</CFIF>
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