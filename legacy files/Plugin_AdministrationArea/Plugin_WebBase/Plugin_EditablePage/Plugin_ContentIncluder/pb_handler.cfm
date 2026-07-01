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
	
	<CFCASE VALUE="editablePageInclude">

		<!--- Make sure that they security requirements are met appropriatly --->
		<CFINCLUDE TEMPLATE="#pb_relExpandPath('Content/#ATTRIBUTES.PageName#.cfm')#">

		<CFSET REQUEST.Title = Title>
		<CFSET REQUEST.TitleImage = TitleImage>
		<CFSET ATTRIBUTES.Layout = Layout>

		<CFPARAM NAME="MemberOnly" DEFAULT="N">

		<CFIF MemberOnly eq "Y">
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="authenticate" Processor="member" />
			<CFSET CFG.CacheThis = "No">
		<CFELSEIF MemberOnly eq "G">
			<CFPARAM NAME="PermittedGroups" DEFAULT="">
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="authenticate" Processor="member" Requiregroups="#PermittedGroups#" />
			<CFSET CFG.CacheThis = "No">
		<CFELSE>
			<!--- If no security, then it's OK to cache the page --->
			<CFSET CFG.CacheThis = "No">
		</CFIF>
		
		<CFINCLUDE TEMPLATE="#pb_relExpandPath('Content/inc_#ATTRIBUTES.PageName#.cfm')#">
		
	</CFCASE>
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>