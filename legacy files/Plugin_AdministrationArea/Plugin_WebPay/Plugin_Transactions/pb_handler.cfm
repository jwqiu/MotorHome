<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ReplaceNoCase(ATTRIBUTES.FuseAction, CFG.PlName, "")#">
	
	<CFCASE VALUE="List">
		<CFSET REQUEST.Title = ATTRIBUTES.BreadCrumbs & " : " & CFG.PlPlural>
		<CFINCLUDE TEMPLATE="qry_list.cfm">
		<CFINCLUDE TEMPLATE="dsp_list.cfm">
		<CFSET RC = StructDelete(ATTRIBUTES, "Layout", "No")>
	</CFCASE>
	
	<CFCASE VALUE="Edit">
		<CFSET REQUEST.Title = ATTRIBUTES.BreadCrumbs & " : View/Edit " & CFG.PlSingular>
		<CFINCLUDE TEMPLATE="act_edit.cfm">
		<CFINCLUDE TEMPLATE="dsp_edit.cfm">
		<CFSET RC = StructDelete(ATTRIBUTES, "Layout", "No")>
	</CFCASE>
	
	<CFCASE VALUE="New">
		<CFSET REQUEST.Title = ATTRIBUTES.BreadCrumbs & " : New " & CFG.PlSingular>
		<CFINCLUDE TEMPLATE="act_new.cfm">
		<CFINCLUDE TEMPLATE="dsp_new.cfm">
		<CFSET RC = StructDelete(ATTRIBUTES, "Layout", "No")>
	</CFCASE>
	
	<CFCASE VALUE="Delete">
		<CFINCLUDE TEMPLATE="act_delete.cfm">
	</CFCASE>
	
	<!--- The following are supporting services, not intended to be called 
		- by the browser directly.
		--->
	<CFCASE VALUE="Tree">
		<CFINCLUDE TEMPLATE="qry_tree.cfm">
		<CFINCLUDE TEMPLATE="dsp_tree.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Query">
		<CFINCLUDE TEMPLATE="qry_query.cfm">
		<CFINCLUDE TEMPLATE="dsp_query.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Update">
		<CFINCLUDE TEMPLATE="act_update.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Insert">
		<CFINCLUDE TEMPLATE="act_insert.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Form">
		<CFINCLUDE TEMPLATE="qry_form.cfm">
		<CFINCLUDE TEMPLATE="dsp_form.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>