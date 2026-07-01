<CFSETTING EnableCFOutputOnly = Yes>
<CFPARAM NAME="Attributes.DateTime" DEFAULT="">

<CFSET Parsed="">
<CFSWITCH EXPRESSION="#Attributes.DateTime#">
    <CFCASE VALUE="">   <!--- pull it from the file --->
        <CFSET Dir = GetDirectoryFromPath( CGI.CF_TEMPLATE_PATH )>
        <CFSET File = GetFileFromPath( CGI.CF_TEMPLATE_PATH )>
        <CFDIRECTORY NAME=TempQuery DIRECTORY=#Dir# FILTER=#File#>
        <CFSET Parsed = ParseDateTime( TempQuery.DateLastModified )>
    </CFCASE>   <!--- File --->
    <CFDEFAULTCASE>
	<CFTRY>
        <CFSET Parsed = ParseDateTime( Attributes.DateTime )>
		<CFCATCH>
        <CFSET Parsed = "">
		</CFCATCH>
	</CFTRY>
    </CFDEFAULTCASE>
</CFSWITCH>

<CFIF Parsed NEQ "">
    <CFSET GMT = DateAdd( "h", 6, Parsed )>
    <CFSET FormattedDate = DateFormat( GMT, "ddd, dd mmm yyyy" )>
    <CFSET FormattedTime = TimeFormat( GMT, "HH:mm:ss" )>
    <CFHEADER NAME="Last-Modified" VALUE="#FormattedDate# #FormattedTime# GMT">
</CFIF>
<CFSETTING EnableCFOutputOnly = No>
