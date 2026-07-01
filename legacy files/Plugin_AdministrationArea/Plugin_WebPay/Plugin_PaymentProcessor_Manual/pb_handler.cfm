<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	
	<CFCASE VALUE="Manual_configForm">
		<CFINCLUDE TEMPLATE="qry_configForm.cfm">
		<CFINCLUDE TEMPLATE="act_configForm.cfm">
		<CFINCLUDE TEMPLATE="dsp_configForm.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Manual_paymentForm">
		<CFINCLUDE TEMPLATE="qry_paymentForm.cfm">
		<CFINCLUDE TEMPLATE="dsp_paymentForm.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Manual_charge">
		<CFINCLUDE TEMPLATE="act_charge.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFCASE VALUE="Manual_presentDetails">
		<CFINCLUDE TEMPLATE="qry_presentDetails.cfm">
		<CFINCLUDE TEMPLATE="dsp_presentDetails.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>