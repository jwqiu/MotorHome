<CFSILENT>

	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
		<CFPARAM NAME="ATTRIBUTES.PageName">
		
		<!--- First write the include file --->
		<CFSET TheFile = "#ExpandPath('Content/inc_#ATTRIBUTES.PageName#.cfm')#">
		<CFPARAM NAME="ATTRIBUTES.FileContent">
		<CFFILE ACTION="WRITE" FILE="#TheFile#" Output="#ATTRIBUTES.FileContent#">
		
		<!--- Then we make a header file --->
		<CFPARAM NAME="ATTRIBUTES.Title"      DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.Layout"     DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.TitleImage"  DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.MemberOnly" DEFAULT="N">
		<CFPARAM NAME="ATTRIBUTES.PermittedGroups" DEFAULT="">
		
		<CFSET   TheFile = ExpandPath("Content/#ATTRIBUTES.PageName#.cfm")>
		
		<CFIF pb_serviceAvailable("MemberGroupsList")>
			<!--- WebMember --->
			<CFFILE ACTION="WRITE" FILE="#TheFile#" OUTPUT="
				<CFSET Title  = ""#ATTRIBUTES.Title#"">
				<CFSET Layout = ""#ATTRIBUTES.Layout#"">
				<CFSET TitleImage = ""#ATTRIBUTES.TitleImage#"">
				<CFSET MemberOnly = ""#ATTRIBUTES.MemberOnly#"">
				<CFSET PermittedGroups = ""#ATTRIBUTES.PermittedGroups#"">
				<CFIF NOT IsDefined(""PlugBox"")>
					<CFLOCATION URL=""#CGI.SCRIPT_NAME#?FuseAction=#CFG.PlName#Include&PageName=#URLEncodedFormat(ATTRIBUTES.PageName)#"" ADDTOKEN=""Yes"">
				</CFIF>
			">	
			<!--- &Title=#URlEncodedFormat(ATTRIBUTES.Title)#&Layout=#URLEncodedFormat(ATTRIBUTES.Layout)#&PageName=#URLEncodedFormat(ATTRIBUTES.PageName)#&TitleImage=#URLEncodedFormat(ATTRIBUTES.TitleImage)# --->
		<CFELSE>
			<!--- WebBase --->
			<CFFILE ACTION="WRITE" FILE="#TheFile#" OUTPUT="
				<CFSET Title  = ""#ATTRIBUTES.Title#"">
				<CFSET Layout = ""#ATTRIBUTES.Layout#"">
				<CFSET TitleImage = ""#ATTRIBUTES.TitleImage#"">
				<CFIF NOT IsDefined(""PlugBox"")>
					<CFLOCATION URL=""#CGI.SCRIPT_NAME#?FuseAction=#CFG.PlName#Include&PageName=#URLEncodedFormat(ATTRIBUTES.PageName)#"" ADDTOKEN=""Yes"">
				</CFIF>
			">	
			<!--- &Title=#URlEncodedFormat(ATTRIBUTES.Title)#&Layout=#URLEncodedFormat(ATTRIBUTES.Layout)#&PageName=#URLEncodedFormat(ATTRIBUTES.PageName)#&TitleImage=#URLEncodedFormat(ATTRIBUTES.TitleImage)# --->
		</CFIF>				
				
		<CFMODULE TEMPLATE="#CFG.TOPLevel#" FuseAction="return" />
	</CFIF>
	
</CFSILENT>
