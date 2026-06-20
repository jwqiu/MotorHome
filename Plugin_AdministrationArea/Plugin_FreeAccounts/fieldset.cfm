<CFSILENT>
	
	<!--- 
		- Create aquery in the caller's scope and populate it with data
		- given by <CF_FIELD /> tags.
		--->
	<CFSET QueryCols = "FieldName,DisplayName,Type,Note,Message,Required,AllowHTML,Verify,Unique,Size,MaxLength,Rows,Cols,LinkQueryFuseaction,LinkQueryValue,LinkQueryDisplay,LinkTableName,LinkTableOurKey,LinkTableTheirKey,Directory,Url">

	<CFIF thisTag.executionMode eq "start">
		<CFPARAM NAME="ATTRIBUTES.FIELDSET" DEFAULT="CALLER.CFG.Fields">
		<CFSET SetVariable(ATTRIBUTES.FIELDSET, QueryNew("ID,#QueryCols#"))>
	<CFELSEIF thisTag.executionMode eq "end">
		<CFLOOP index=i from=1 to=#arrayLen(thisTag.fields)#>
    		<!--- Get the attributes structure --->
			<CFSET field = thisTag.fields[i]>
			
			<!--- Add a row to the query --->
			<CFSET x = QueryAddRow(Evaluate(ATTRIBUTES.FieldSet))>
			<CFSET x = QuerySetCell(Evaluate(ATTRIBUTES.FieldSet), "ID", i)>
			<CFLOOP LIST="#QueryCols#" INDEX="Col">
				<CFPARAM NAME="field.#Col#" DEFAULT="">
				<CFSET x = QuerySetCell(Evaluate(ATTRIBUTES.FieldSet), Col, field[Col])>	
			</CFLOOP>
   		</CFLOOP>
	</CFIF>
</CFSILENT>
