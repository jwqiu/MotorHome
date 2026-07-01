<CFSILENT>
	
	<!--- 
		- Create aquery in the caller's scope and populate it with data
		- given by <CF_CHILD /> tags.
		--->
	<CFSET QueryCols = "ChildName,Plural,Singular,TableName,PKField,LinkField">

	<CFIF thisTag.executionMode eq "start">
		<CFPARAM NAME="ATTRIBUTES.CHILDREN" DEFAULT="CALLER.CFG.ChildPlugins">
		<CFSET SetVariable(ATTRIBUTES.CHILDREN, QueryNew("ID,#QueryCols#"))>
	<CFELSEIF thisTag.executionMode eq "end" AND IsDefined("thisTag.children")>
		<CFLOOP index=i from=1 to=#arrayLen(thisTag.children)#>
    		<!--- Get the attributes structure --->
			<CFSET child = thisTag.children[i]>
			
			<!--- Add a row to the query --->
			<CFSET x = QueryAddRow(Evaluate(ATTRIBUTES.Children))>
			<CFSET x = QuerySetCell(Evaluate(ATTRIBUTES.Children), "ID", i)>
			<CFLOOP LIST="#QueryCols#" INDEX="Col">
				<CFPARAM NAME="child.#Col#" DEFAULT="">
				<CFSET x = QuerySetCell(Evaluate(ATTRIBUTES.Children), Col, child[Col])>	
			</CFLOOP>
   		</CFLOOP>
	</CFIF>
</CFSILENT>
	