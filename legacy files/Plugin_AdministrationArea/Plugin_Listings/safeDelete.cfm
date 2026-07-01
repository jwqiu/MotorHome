<CFPARAM NAME="ATTRIBUTES.FILE" DEFAULT="">
<CFIF "#ATTRIBUTES.FILE#" neq "">
	<CFIF FileExists(ATTRIBUTES.FILE)>
		<cffile action="delete" file="#ATTRIBUTES.FILE#">
	</CFIF>
</CFIF>



















































