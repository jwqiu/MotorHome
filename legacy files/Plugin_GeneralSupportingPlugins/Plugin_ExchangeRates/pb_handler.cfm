<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Handler
    	------------------------------------------------------------------------
    	- This file is one big switch statement, it is used to handle
		- all the fuseactions that we save we can handle in pb_provides.cfm
    	----------------------------------------------------------------------->
</CFSILENT>
<CFSWITCH EXPRESSION="#ATTRIBUTES.FuseAction#">
	<CFCASE VALUE="exchangeRate">
		<CFINCLUDE TEMPLATE="qry_exchangeRate.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
		<CFSET CFG.CacheThis = "Yes">
	</CFCASE>
	
	<CFCASE VALUE="currencyQuery">
		<CFINCLUDE TEMPLATE="qry_currencyQuery.cfm">
		<CFSET ATTRIBUTES.Layout = "None">
		<CFSET CFG.CacheThis     = "Yes">
	</CFCASE>
	
	<CFDEFAULTCASE>
		
	</CFDEFAULTCASE>
</CFSWITCH>