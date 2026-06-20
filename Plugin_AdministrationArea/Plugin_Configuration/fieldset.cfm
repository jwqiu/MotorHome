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
		<CFSET TempRef = Evaluate(ATTRIBUTES.FieldSet)>
		<CFLOOP INDEX="i" FROM="1" TO=#arrayLen(thisTag.fields)#>
    		<!--- Get the attributes structure --->
			<CFSET field = thisTag.fields[i]>
			
			<!--- Add a row to the query --->
			<CFSET QueryAddRow(TempRef)>
			<CFSET QuerySetCell(TempRef, "ID", i)>
			<CFLOOP LIST="#QueryCols#" INDEX="Col">
				<CFPARAM NAME="field.#Col#" DEFAULT="">
				<CFSET QuerySetCell(TempRef, Col, field[Col])>	
			</CFLOOP>
   		</CFLOOP>
	</CFIF>
</CFSILENT>
