<CFPARAM NAME="ATTRIBUTES.RootURL"     >
<CFPARAM NAME="ATTRIBUTES.RootDisplay" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.ExpandNodes" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.Width" DEFAULT="320">
<CFPARAM NAME="ATTRIBUTES.Height" DEFAULT="400">
<CFOUTPUT>
	<CFSET RelativeHere = ReplaceNoCase(CFG.OurDirectory, CFG.WebRoot, "")>
	<CFSET RelativeHere = Replace(RelativeHere, "\", "/", "ALL")>
	<CF_javaplugin 
	ARCHIVE="#RelativeHere#_Components/wddx.jar,#RelativeHere#_Components/wddxSupport.jar,#RelativeHere#_Components/wddxTreeApplet.jar" 
	CODE="wddxTreeApplet" 
	CODEBASE=""
	WIDTH="#ATTRIBUTES.Width#" HEIGHT="#ATTRIBUTES.HEIGHT#">
		<PARAM NAME="ROOTURL" VALUE="#ATTRIBUTES.ROOTURL#">
		<CFIF Len(ATTRIBUTES.RootDisplay)>
		<PARAM NAME="ROOTDISPLAY" VALUE="#ATTRIBUTES.ROOTDISPLAY#">
		</CFIF>
		<CFIF Len(ATTRIBUTES.ExpandNodes)>
		<PARAM NAME="EXPANDNODES" VALUE="#ATTRIBUTES.EXPANDNODES#">
		</CFIF>
	</CF_Javaplugin>
</CFOUTPUT>
