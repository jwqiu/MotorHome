<!---
	- To cause the java plugin to be used when available we need to write
	- either an applet, object or embed tag depending on the browser that will
	- be running the applet.  IE requires the Object tag, early netscapes (4.x 
	- and below) require the embed tag and everything else uses the applet tag.
	--->
<CFIF ThisTag.ExecutionMode eq "end">
<CF_whodat>
<CFSET   PARAMS = ThisTag.GeneratedContent>
<CFSET   ThisTag.GeneratedContent = "">
<CFPARAM NAME="ATTRIBUTES.ARCHIVE" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.CODE"    DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.CLASS"   DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.WIDTH"   DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.HEIGHT"  DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.ApName"  DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.CODEBASE" DEFAULT="">
<CFOUTPUT>
<CFIF Platform eq "Windows">
	<CFIF BrowserName eq "Microsoft">
		<!--- Use OBJECT --->
		<OBJECT classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" WIDTH="#ATTRIBUTES.WIDTH#" 
				HEIGHT="#ATTRIBUTES.HEIGHT#"  #IIF(Len(ATTRIBUTES.ApName), DE('NAME="#ATTRIBUTES.ApName#"'), DE(''))#
				codebase="http://java.sun.com/products/plugin/1.3.1/jinstall-131-win32.cab##Version=1,3,1,0">
				<CFIF Len(ATTRIBUTES.ARCHIVE)><PARAM NAME="ARCHIVE"  VALUE="#ATTRIBUTES.ARCHIVE#"></CFIF>
				<CFIF Len(ATTRIBUTES.CODE)><PARAM NAME="CODE"     VALUE="#ATTRIBUTES.CODE#"></CFIF>
				<CFIF Len(ATTRIBUTES.CLASS)><PARAM NAME="CLASS"    VALUE="#ATTRIBUTES.CLASS#"></CFIF>
				<CFIF Len(ATTRIBUTES.CODEBASE)><PARAM NAME="CODEBASE" VALUE="#ATTRIBUTES.CODEBASE#"></CFIF>
				#PARAMS#
		</OBJECT>
	<CFELSEIF BrowserName eq "Netscape" AND MozillaVersion LT 5>
		<!--- Use EMBED --->
		<CFSET Start = 0>
		<CFSET PARAMETERS = "">
		<CFLOOP CONDITION="Start LT Len(PARAMS)">
			<CFSET  Ps = ReFindNoCase("\<PARAM [^<>]*\>", PARAMS, Start, "Yes")>
			<CFIF Ps.Pos[1]>
				<CFSET PARAM = Mid(PARAMS, Ps.Pos[1], Ps.Len[1])>
				<CFSET Nm = ReFindNoCase('NAME\="[^"]*"', PARAM, 1, Yes)>
				<CFSET Name = Mid(PARAM, Nm.Pos[1], Nm.Len[1])>
				<CFSET Name = ReReplaceNoCase(Name, 'NAME="(.*)"', "\1")>
				
				<CFSET Vl = ReFindNoCase('VALUE\="[^"]*"', PARAM, 1, Yes)>
				<CFSET Val = Mid(PARAM, Vl.Pos[1], Vl.Len[1])>
				<CFSET Val = ReReplaceNoCase(Val, 'VALUE="(.*)"', "\1")>
				<CFSET PARAMETERS = PARAMETERS & " #Name#=""#Val#""">
				<CFSET Start = Ps.Pos[1] + Ps.Len[1]>
			<CFELSE>
				<CFSET Start = Len(PARAMS)>
			</CFIF>
		</CFLOOP>
		<EMBED TYPE="application/x-java-applet;version=1.3" WIDTH="#ATTRIBUTES.WIDTH#
			HEIGHT="#ATTRIBUTES.HEIGHT#"
			#IIF(Len(ATTRIBUTES.Code), DE('CODE="#ATTRIBUTES.Code#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.CodeBase), DE('CodeBase="#ATTRIBUTES.CodeBase#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Class), DE('Class="#ATTRIBUTES.Class#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Archive), DE('Archive="#ATTRIBUTES.Archive#"'), DE(''))#
			#PARAMETERS#>
			<NOEMBED>
				Your web browser does not support java applets.
			</NOEMBED>
		</EMBED>
	<CFELSE>
		<!--- Use Applet --->
		<APPLET 
			#IIF(Len(ATTRIBUTES.Code), DE('CODE="#ATTRIBUTES.Code#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.CodeBase), DE('CodeBase="#ATTRIBUTES.CodeBase#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Class), DE('Class="#ATTRIBUTES.Class#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Archive), DE('Archive="#ATTRIBUTES.Archive#"'), DE(''))# 
			NAME="#ATTRIBUTES.ApName#" WIDTH="#ATTRIBUTES.WIDTH#"
				HEIGHT="#ATTRIBUTES.HEIGHT#">	
			#PARAMS#
		</APPLET>
	</CFIF>
<CFELSEIF Platform eq "Macintosh">
	<!--- Use applet --->
	Applet only for OS X and better.
	<APPLET 
			#IIF(Len(ATTRIBUTES.Code), DE('CODE="#ATTRIBUTES.Code#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.CodeBase), DE('CodeBase="#ATTRIBUTES.CodeBase#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Class), DE('Class="#ATTRIBUTES.Class#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Archive), DE('Archive="#ATTRIBUTES.Archive#"'), DE(''))# 
			NAME="#ATTRIBUTES.ApName#" WIDTH="#ATTRIBUTES.WIDTH#"
				HEIGHT="#ATTRIBUTES.HEIGHT#">	
			#PARAMS#
		</APPLET>
<CFELSE>
	<!--- Use Applet --->
	<APPLET 
			#IIF(Len(ATTRIBUTES.Code), DE('CODE="#ATTRIBUTES.Code#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.CodeBase), DE('CodeBase="#ATTRIBUTES.CodeBase#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Class), DE('Class="#ATTRIBUTES.Class#"'), DE(''))#
			#IIF(Len(ATTRIBUTES.Archive), DE('Archive="#ATTRIBUTES.Archive#"'), DE(''))# 
			NAME="#ATTRIBUTES.ApName#" WIDTH="#ATTRIBUTES.WIDTH#"
				HEIGHT="#ATTRIBUTES.HEIGHT#">	
			#PARAMS#
		</APPLET>
</CFIF>
</CFOUTPUT>
</CFIF>
