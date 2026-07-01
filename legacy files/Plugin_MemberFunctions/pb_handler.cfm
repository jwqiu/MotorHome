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
		
	<CFCASE VALUE="memberSignUp">
		<CFSET REQUEST.Title = "Online Application">
		<CFSET REQUEST.TitleImage = "Images/headers/online_application.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="memberLogin">
		<CFSET REQUEST.Title = "Members">
		<CFSET REQUEST.TitleImage = "Images/headers/members.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="freeNewsletter">
		<CFSET REQUEST.Title = "Free Newsletter">
		<CFSET REQUEST.TitleImage = "Images/headers/free_newsletter.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="memberHome">
		<CFSET REQUEST.Title = "Members">
		<CFSET REQUEST.TitleImage = "Images/headers/members.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="AddListing">
		<CFSET REQUEST.Title = "Add Listing">
		<CFSET REQUEST.TitleImage = "Images/headers/add-listing.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>
	
	<CFCASE VALUE="Verify">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>
	
	<CFCASE VALUE="ListingForm">
		<CFSET REQUEST.Title = "Listing Details">
		<CFSET REQUEST.TitleImage = "Images/headers/details.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="MemberLogout">
		<CFSET REQUEST.Title = "Logout">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>
	
	
	<CFCASE VALUE="EditRenewListing">
		<CFSET REQUEST.Title = "Edit/Renew Listing">
		<CFSET REQUEST.TitleImage = "Images/headers/but-edit_renewlisting.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="memberForgotPassword">
		<CFSET REQUEST.Title = "Forgot Password">
		<CFSET REQUEST.TitleImage = "Images/headers/forgot_password.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="contactUs">
		<CFSET REQUEST.Title = "Contact Us">
		<CFSET REQUEST.TitleImage = "Images/headers/contact_us.gif">
		<CFINCLUDE TEMPLATE="qry_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="renewThankYou">
		<CFSET REQUEST.Title = "Thank you">
		<CFSET REQUEST.TitleImage = "">
		<CFINCLUDE TEMPLATE="dsp_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>

	<CFCASE VALUE="sendReminders">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>
	
	<CFCASE VALUE="parseCountries">
		<CFINCLUDE TEMPLATE="act_#ATTRIBUTES.FuseAction#.cfm">
	</CFCASE>
		
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>