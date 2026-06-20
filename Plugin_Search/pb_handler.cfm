<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	<!--- Example :
		- <CFCASE VALUE="helloWorld">
		-	<CFINCLUDE TEMPLATE="dsp_helloWorld.cfm">
		- </CFCASE>
		--->
		
	<CFCASE VALUE="Search">
		<CFSET REQUEST.Title = "Search">
		<CFSET REQUEST.TitleImage = "Images\headers\search.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
<!---		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">--->
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>


	<CFCASE VALUE="Listing">
		<CFSET REQUEST.Title = "Listing">
		<CFSET REQUEST.TitleImage = "Images\headers\search.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="ListingDetails">
		<CFSET REQUEST.Title = "ListingDetails">
		<CFSET REQUEST.TitleImage = "Images\headers\details.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="SendEnquiry">
		<CFSET REQUEST.Title = "Enquiry">
		<CFSET REQUEST.TitleImage = "">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

		
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>