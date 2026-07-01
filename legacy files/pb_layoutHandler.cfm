<!--------------------------------------------------------------------------
	- Layout Handler
	------------------------------------------------------------------------
	- This file is used to take the "BodyData" variable which contains the
	- output from the pb_handler.cfm or a child plugin of this directory 
	- and insert it into a "husk".  Think of a husk like a coconut husk
	- and the BodyData as the contents of the coconut - the husk is wrapped
	- around the content.
	-
	- Typically you will want to include a dsp_husk.cfm file here, and maybe
	- a qry_husk.cfm file.  Somewhere in the dsp_husk.cfm you will have 
	- a <CFOUTPUT>#Trim(BodyData)#</CFOUTPUT> (it's always good to 
	- trim body data).
	-
	- In some situations you may not want to wrap the bodydata in a husk at
	- all.  For example, if you are callilg a service in the context of a 
	- popup window you might want to cause the top most husk (eg your main
	- site layout) not to display.  The implementation for that is left to 
	- you, but I'd suggest something like
	-
	-	<CFIF NOT (IsDefined("ATTRIBUTES.NoHusk") AND ATTRIBUTES.NoHusk)>
	-		<CFINCLUDE TEMPLATE="dsp_husk.cfm">	
	-	</CFIF>
	-
	- if you want to pass a "nohusk" directive up from a child plugin to a
	- parent plugin (this kind of breaks some modularity I think, but 
	- could be useful in certain situations) then you could set 
	- ATTRIBUTES.NoHusk within the child plugin as the ATTRIBUTES scope
	- of the child plugin will filter up to our attributes scope when it 
	- returns.
	----------------------------------------------------------------------->
<CFPARAM NAME="ATTRIBUTES.Layout" DEFAULT="defaultLayout">
<CFSWITCH EXPRESSION="#ATTRIBUTES.Layout#">
	
	<CFCASE VALUE="defaultLayout,contentLayout">
		<!--- If the editable layout plugin is present and an editable layout has 
			- been set as the active layout, use it, otherwise use our own default --->
		<CFIF pb_serviceAvailable("EditableLayoutUseActive") AND IsDefined("CFG.Layout.Name")>
			<CFPARAM NAME="REQUEST.Title" 		DEFAULT="#CFG.WebSiteName#">
			<CFPARAM NAME="REQUEST.TitleImage" 	DEFAULT="">
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="EditableLayoutUseActive" 
					  CONTENT="#BodyData#"      TITLE="#REQUEST.Title#"   
					  TITLEIMAGE="#REQUEST.TitleImage#" />
		<CFELSE>
			<CFINCLUDE TEMPLATE="qry_husk.cfm">
			<CFINCLUDE TEMPLATE="dsp_husk.cfm">
		</CFIF>
	</CFCASE>
	
	<CFCASE VALUE="Administration">
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="administrationLayout" 
			BODYDATA="#BodyData#" ATTRIBUTECOLLECTION=#ATTRIBUTES#/>
	</CFCASE>
	
	<CFCASE VALUE="None">
		<CFOUTPUT>#BodyData#</CFOUTPUT>
	</CFCASE>
	
	<CFDEFAULTCASE>	
		<!--- If the editable layout plugin is present, see if the requested 
			- layout is available
			--->
		<CFIF pb_serviceAvailable("EditableLayoutUse")>
			<!--- Grab a query of the layouts --->
			<CFSILENT><CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="editableLayoutQuery" /></CFSILENT>
			<CFIF ListFindNoCase(ValueList(CFMODULE.ATTRIBUTES.Q_ListQuery.Name), ATTRIBUTES.Layout, '.,')>
				<CFPARAM NAME="REQUEST.Title" 		DEFAULT="#CFG.WebSiteName#">
				<CFPARAM NAME="REQUEST.TitleImage" 	DEFAULT="">
				<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="editableLayoutUse" CONTENT="#BodyData#" 
					TITLE="#REQUEST.Title#" 	TITLEIMAGE="#REQUEST.TitleImage#"  LAYOUT="#ATTRIBUTES.Layout#"/>
			<CFELSE>
				<!--- No editable layout by that name exists, give to admin instead --->
				<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="administrationLayout" 
					BODYDATA="#BodyData#" ATTRIBUTECOLLECTION=#ATTRIBUTES#/>
			</CFIF>
		<CFELSE>
			<!--- Can't be an editable layout, because they don't exist in this system,
				- send to admin layout instead. --->
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="administrationLayout" 
					BODYDATA="#BodyData#" ATTRIBUTECOLLECTION=#ATTRIBUTES#/>
		</CFIF>
	</CFDEFAULTCASE>
</CFSWITCH>