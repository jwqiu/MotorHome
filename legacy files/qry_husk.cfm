<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Husk Query File
    	------------------------------------------------------------------------
    	-	this file is run just before the husk is used to wrap any generated
    	- content.  Use this for running any queries, setting variables etc
		- that you might require in the dsp_husk.cfm file.  
		-
		- The PlugBox standard defines that queries should be written as
		- <CFQUERY DATASOURCE="#CFG.DS#" DBTYPE="#CFG.DBTYPE#" 
		-		   CONNECTSTRING="#CFG.CONNECTSTRING#" NAME="QueryName">
		-	
		- </CFQUERY>
		----------------------------------------------------------------------->
		
		<CFPARAM NAME="REQUEST.Title" DEFAULT="Untitled PlugBox Results">
		<CFPARAM NAME="REQUEST.TitleImage" DEFAULT="">
		<!---
		<CFWDDX ACTION="WDDX2CFML" INPUT="#CFG.LayoutWDDX#"           OUTPUT="Layout">
		<CFIF NOT Len(Layout.Layout)>
			<CFSET Layout.Layout = "{{TitleImage}}<P>{{PageContent}}</P>">
		</CFIF>
		
		<CFIF Len(REQUEST.TitleImage)>
			<CFSET Layout.Layout = Replace(Layout.Layout, "{{TitleImage}}", "<IMG SRC=""#REQUEST.TitleImage#"" BORDER=""0"" ALT=""#REQUEST.Title#"">", "ALL")>
		<CFELSE>
			<CFSET Layout.Layout = Replace(Layout.Layout, "{{TitleImage}}", "<STRONG>#REQUEST.Title#</STRONG>", "ALL")>
		</CFIF>
		
		<CFSET Layout.Layout = Replace(Layout.Layout, "{{PageContent}}", BodyData, "ALL")>
		--->
		
		<!--- As this is a top level directory is actually depends totally
			- on plugins to provide services.  Because of this, we can say
			- that if the plugin that was used for this request says it is
			- cacheable, then we too are cacheable.  That's good isn't it :-)
			--->
		<CFIF IsDefined("CFMODULE.CFG.CacheThis") AND CFMODULE.CFG.CacheThis>
			<CFSET CFG.CacheThis = CFMODULE.CFG.CacheThis>
		</CFIF>
</CFSILENT>