<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	<CFCASE VALUE="checkout">
		<CFINCLUDE TEMPLATE="qry_checkout.cfm">
		<CFINCLUDE TEMPLATE="act_checkout.cfm">
		<CFINCLUDE TEMPLATE="dsp_checkout.cfm">
		<CFSET REQUEST.Title = "Submit Payment">
	</CFCASE>
	
	<CFCASE VALUE="accepted">
		<CFINCLUDE TEMPLATE="qry_accepted.cfm">
		<CFINCLUDE TEMPLATE="dsp_accepted.cfm">
		<CFSET REQUEST.Title = "Submit Payment">
	</CFCASE>
	
	<CFCASE VALUE="cvc2">
		<CFINCLUDE TEMPLATE="dsp_cvc2.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
	</CFCASE>
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>