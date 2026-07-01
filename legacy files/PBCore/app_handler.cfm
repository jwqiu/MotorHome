<CFSILENT>
	<!----------------------------------------------------------------
		- PlugBox Core : Handler
		--------------------------------------------------------------
		- This file contains the routines that plugbox applications
		- use for handling fuseactions.	
		-
		- Fuseactions can either be handled :
		- A) By this file directly
		-		this method is reserved for special PlugBox fuseactions
		- B) By the pb_handlers.cfm file in the directory from whence
		-		this file was called
		- C) By a plugin residing in the directory from whence this 
		-		file was called
		- --->

	<!--- Default to a fuseaction called "PlugBoxDefaultFuseAction"
		- --->
	<CFPARAM NAME="ATTRIBUTES.FuseAction" DEFAULT="#CFG.defaultFuseAction#">

	<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
		<CFCASE VALUE="Services">
			<CFSET CFG.CacheThis = "No"> 
			<CFSAVECONTENT VARIABLE="BodyData">
				<CFWDDX INPUT=#PlugBox.Provides# ACTION="CFML2WDDX">
			</CFSAVECONTENT>
		</CFCASE>
	
		<CFCASE VALUE="ResetServices">
			<CFSET CFG.CacheThis = "No"> 
			<CFSAVECONTENT VARIABLE="BodyData">
				<CFLOCK NAME="#REQUEST.PLUGBOX.SERVICESLOCK#" TYPE="EXCLUSIVE" 
				  TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#" THROWONTIMEOUT="Yes">
					<CFSET x = StructClear(APPLICATION.PLUGBOX.Services)>
				</CFLOCK>
			</CFSAVECONTENT>
		</CFCASE>
	
		<CFCASE VALUE="DumpServices">
			<CFSET CFG.CacheThis = "No"> 
			<CFSAVECONTENT VARIABLE="BodyData">
				<CFDUMP VAR=#PlugBox.Provides#>
				<CFDUMP VAR=#CFG#>
			</CFSAVECONTENT>
		</CFCASE>
		
		<CFCASE VALUE="Return">
			<CFSET CFG.CacheThis = "No"> 
			<CFLOCK NAME="#REQUEST.PLUGBOX.SESSIONLOCK#" TYPE="EXCLUSIVE" THROWONTIMEOUT="Yes" TIMEOUT="#REQUEST.PLUGBOX.RLockTimeout#">
				<CFIF ArrayLen(SESSION.PLUGBOX.RFAStack)>
					<CFSET TargetURL = SESSION.PLUGBOX.RFAStack[ArrayLen(SESSION.PLUGBOX.RFAStack)]>
					<CFSET x = ArrayDeleteAt(SESSION.PLUGBOX.RFAStack, ArrayLen(SESSION.PLUGBOX.RFAStack))>
				<CFELSE>
					<CFSET TargetURL = "#CGI.SCRIPT_NAME#">
				</CFIF>
			</CFLOCK>
			<CFLOCATION URL="#TargetURL#" ADDTOKEN="Yes">
		</CFCASE>
	
		<CFDEFAULTCASE>
			<!--- See if we are able to handle the given fuseaction, if we
				- can it will be in the PlugBox.Provides structure,
				-
				- if we can handle it find out if we personally do or if a 
				- plugin handles it
				-
				- if we can't, reset the services and try once more
			    - --->
				
			<!--- We need a relative path back to the calling directory --->
			<CFSET RelPath = pb_relPath(GetDirectoryFromPath(GetCurrentTemplatePath()), PlugBox.BoxPath)> 
		
			<CFIF StructKeyExists(PlugBox.Provides, UCase(ATTRIBUTES.FuseAction))>
				<!--- We definately can handle it --->
				<CFIF Len(PlugBox.Provides[ATTRIBUTES.FuseAction].SubPath)>
					
					<!--- by using a plugin --->
					<CFSET SubBox = PlugBox.Provides[ATTRIBUTES.FuseAction].SubPath>
					
					<CFSAVECONTENT VARIABLE="BodyData"><CFMODULE TEMPLATE="#RelPath#/#SubBox#/app_runCore.cfm" ATTRIBUTECOLLECTION=#ATTRIBUTES#/></CFSAVECONTENT>
					<CFIF IsDefined("CFMODULE.CFG.CacheThis")>
						<CFSET CFG.CacheThis = CFMODULE.CFG.CacheThis>
						<!--- <CFIF CFG.CacheThis eq "Request">
						<CFLOG TEXT="Preserve Cache #CFG.CacheThis# For #RelPath#/#SubBox#/#ATTRIBUTES.Fuseaction#">
						</CFIF>
						--->												
					</CFIF>
					
					
					<!--- And save thier attributes into our attributes so we return
						- the interesting stuff --->
					<CFSET StructAppend(ATTRIBUTES, CFMODULE.Attributes, "Yes")>
				<CFELSE>
					<!--- And this very directory is supposed to handle it,
						- so we will use the handler functions to handle it.
						- --->
					<CFSAVECONTENT VARIABLE="BodyData"><CFINCLUDE TEMPLATE="#RelPath#/pb_handler.cfm"></CFSAVECONTENT>
				</CFIF>
			<CFELSE>
				<!---
					- We can't handle the requested fuseaction,
					- we'll reset services and try it again, but only once
					- if it's still not available after resetting services
					- then it will never appear 
					- --->
				<CFPARAM NAME="ATTRIBUTES.PlugBoxFailedService" DEFAULT="0">
				<CFIF NOT ATTRIBUTES.PlugBoxFailedService>
					<!--- Reset services --->
					<CFMODULE TEMPLATE="#RelPath#/app_runCore.cfm" FUSEACTION="resetServices">
					<!--- Reexamine the services --->
					<CFMODULE TEMPLATE="#RelPath#/app_runCore.cfm" FUSEACTION="services">
					<CFSET    PlugBox.Provides = Duplicate(CFMODULE.PlugBox.Provides)>
					<CFSET ATTRIBUTES.PlugBoxFailedService = 1>
					<!--- Run ourself again to try to handle again. --->
					<CFINCLUDE TEMPLATE="app_handler.cfm">
				<CFELSE>
					<CFSAVECONTENT VARIABLE="BodyData">
						Unknown FuseAction <CFOUTPUT>#ATTRIBUTES.FuseAction#</CFOUTPUT>, please 
						<CFOUTPUT><A HREF="#CGI.SCRIPT_NAME#">return to the website</A></CFOUTPUT>.
					</CFSAVECONTENT>
				</CFIF>
			</CFIF>
		</CFDEFAULTCASE>
	</CFSWITCH>
</CFSILENT>