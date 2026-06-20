<CFSILENT>
	<!--- Include the given page's information (main) file, <pagename>.cfm 
		- to setup the information variables about it.  Then include the 
		- given page's content, inc_<pagename>.cfm and put that in a variable --->

	<CFPARAM NAME="ATTRIBUTES.PageName">
	<CFSET ATTRIBUTES.PageName =  Replace(ATTRIBUTES.PageName, ".cfm", "")>
	 
	<CFSET TheFile = "#ExpandPath('Content/inc_#ATTRIBUTES.PageName#.cfm')#">
	
	<CFIF FileExists(TheFile)>
		<CFINCLUDE TEMPLATE="#pb_relExpandPath('Content/#ATTRIBUTES.PageName#.cfm')#">
	
		<CFFILE ACTION="READ" FILE="#TheFile#" VARIABLE="FileContent">
	<CFELSE>
		<CFSET Title       = "Untitled Document">
	</CFIF>
	
	<CFPARAM NAME="Title"       DEFAULT="">
	<CFPARAM NAME="FileContent" DEFAULT="">
	<CFPARAM NAME="Layout"      DEFAULT="">
	<CFPARAM NAME="TitleImage"  DEFAULT="">
	<CFPARAM NAME="MemberOnly"  DEFAULT="0">
	<CFPARAM NAME="PermittedGroups"     DEFAULT="">
	
<!---	<CFDIRECTORY NAME="Q_Heads" ACTION="LIST" DIRECTORY="#ExpandPath('images/headers/')#">--->

	<CFIF pb_ServiceAvailable("MemberGroupsList")>
		<!--- WebMember only --->
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="memberGroupsQuery" />
		<CFSET Q_MemberGroups = CFMODULE.ATTRIBUTES.Q_ListQuery>
	</CFIF>
	
	<CFIF pb_ServiceAvailable("EditableLayoutQuery")>
		<!--- WebPay only? --->
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="editableLayoutQuery" />
		<CFSET Q_EditableLayouts = CFMODULE.ATTRIBUTES.Q_ListQuery>
	</CFIF>
	
</CFSILENT>