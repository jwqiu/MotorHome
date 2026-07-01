<CFSILENT>
	<!--------------------------------------------------------------------------
		- Input Filter
		------------------------------------------------------------------------
		- This file is run after all configuration has been completed 
		- but right before the handlers are run.  You have the full compliment
		- of CFG and ATTRIBUTES variables at your disposal.
		-
		- This is a good place to put things like
		-   security logic
		-		you could check the user is permitted to use this plugin 
		-		(or perhaps the fuseaction they requested
		-		(query a database, hard code it, whatever) and if they are not
		-		then <CFLOCATION> them away to a "login" fuseaction
		-	modifying request attributes
		-		if you want to change an attribute before the fuseaction gets
		-		handled (for whatever reason) now is the time to modify
		-		the ATTRIBUTES scope
		-
		-	and lots more applications I'm sure :-)
		----------------------------------------------------------------------->
		
		<!--- I like to have a variable called ATTRIBUTES.entryErrors into
			- which I put a list of data-entry errors (eg "You did not enter
			- your username.") for later display to the user.  So, the 
			- inputFilter is the place to make sure we have it ready.
			--->
			
		<CFPARAM NAME="ATTRIBUTES.entryErrors" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.errorFields" DEFAULT="">
		<CFPARAM NAME="ATTRIBUTES.BreadCrumbs" DEFAULT="Administration">
		
		<CFIF NOT 
			ListFindNoCase("Services,ResetServices,DumpServices,Return", ATTRIBUTES.FuseAction)>
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="authenticate" Processor="admin" />
		</CFIF>
</CFSILENT>
