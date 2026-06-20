<CFIF len(ATTRIBUTES.Email)>

	<CFQUERY NAME="Q_Lookup" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Members
		WHERE Meemail like '#ATTRIBUTES.email#'
	</CFQUERY>
	
	<CFIF Q_Lookup.RecordCount EQ 1>
		<CFMAIL FROM="#CFG.EmailAddress#" TO="#Q_Lookup.MeEmail#" SUBJECT="Your MotorhomeExchange-Sell.com password">
A user, possibly you has requested a password reminder.

Your password is : #Q_Lookup.MePassword#

If you did not request this reminder, do not worry only this e-mail 
address has received the password.		
		</CFMAIL>
		<CFOUTPUT>
		An e-mail has been sent to #Q_Lookup.Meemail# containing your password.
		</CFOUTPUT>
		<CFSET Sent=1>
	<CFELSE>
		The e-mail address you entered was not found in the database.
	</CFIF>
</CFIF>