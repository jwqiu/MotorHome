<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Provides
    	------------------------------------------------------------------------
    	- This is where you specify what services (fuseactions) this
		- directory can provide.  The format is simple....
		-
		-  Provides.ServiceName = pb_serviceNew("Comments"[, Level])
		- 
		- to make a service override a service of the same name offered
		- by another directory you should supply the Level argument
		- as a level higher than the overridden service's level
		- (level's default to 1)
		-
		- Example :
		- <CFSET Provides.helloWorld = pb_serviceNew("Say hello.")>
    	----------------------------------------------------------------------->
	
		<CFSET Provides.memberSignUp = pb_serviceNew("Display member application form.")>
		<CFSET Provides.memberLogin = pb_serviceNew("Display login for members.")>
		<CFSET Provides.freeNewsletter = pb_serviceNew("Free newsletter subscribe/unsubscribe.")>
		<CFSET Provides.memberHome = pb_serviceNew("Display member home page.")>
		<CFSET Provides.AddListing = pb_serviceNew("Add new vehicle listing.")>
		<CFSET Provides.Verify = pb_serviceNew("Verify search.")> <!--- Activates member account, marks listings as paid --->
		<CFSET Provides.ListingForm = pb_serviceNew("Enter details of new listings.")>
		<CFSET Provides.EditRenewListing = pb_serviceNew("Select listing and then edit or renew it.")>
		<CFSET Provides.memberLogout = pb_serviceNew("Logout from member area.")>
		<CFSET Provides.memberForgotPassword = pb_serviceNew("Email password to member.")>
		<CFSET Provides.contactUs = pb_serviceNew("Send email to admin.")>
		<CFSET Provides.renewThankyou = pb_serviceNew("Thank user for renewing subscription.")>
		<CFSET Provides.sendReminders = pb_serviceNew("Check for listings that need renewing. Run daily.")>
		<CFSET Provides.parseCountries = pb_serviceNew("Parse countries file.")>
	
</CFSILENT>