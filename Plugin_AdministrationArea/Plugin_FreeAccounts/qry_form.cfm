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
			<CFDEFAULTCASE>
				<CFSWITCH EXPRESSION="#Type#">
					<CFCASE VALUE="lookup,multilookup">
						<!--- Lookup's need to get a query --->
						<CFPARAM NAME="ATTRIBUTES.#FieldName#" DEFAULT="#CFG.pb_null#">
						<CFPARAM NAME="ATTRIBUTES.#FieldName#_V" DEFAULT="#CFG.pb_null#">
						<CFMODULE TEMPLATE="#CFG.TopLevel#" 
							FuseAction="#LinkQueryFuseaction#" />
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