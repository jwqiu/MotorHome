<CFSILENT>
	<CFIF thisTag.executionMode eq "end">
		<CFPARAM NAME="ATTRIBUTES.Title">
		<CFPARAM NAME="ATTRIBUTES.Selected" DEFAULT="0">
		<CFPARAM NAME="ATTRIBUTES.AddRadio" DEFAULT="0">
		<CFPARAM NAME="ATTRIBUTES.RadioValue" DEFAULT="#ATTRIBUTES.Title#">
		<CFSET noteBook = GetBaseTagData("CF_NOTEBOOK")>
		
		<CFIF ATTRIBUTES.AddRadio>
			<CFSET ATTRIBUTES.Title = 
				"<INPUT TYPE=""RADIO"" NAME=""#noteBook.attributes.selector#"" VALUE=""#HTMLEditFormat(ATTRIBUTES.RadioValue)#"" #IIF(ATTRIBUTES.Selected, DE('CHECKED'), DE(''))#> " & ATTRIBUTES.Title>
		</CFIF>
		<CFSET ATTRIBUTES.Content = thisTag.generatedContent>
		<CFSET thisTag.generatedContent = "">
		<CFASSOCIATE BASETAG="CF_NOTEBOOK" DATACOLLECTION="TABS">
	</CFIF>
</CFSILENT>