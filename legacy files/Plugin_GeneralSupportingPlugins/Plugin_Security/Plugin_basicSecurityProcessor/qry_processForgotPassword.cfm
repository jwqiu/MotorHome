<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Username">
	
	<!--- Default password mailer, requires username, password and email in 
		- CFG --->
	
	<CFIF CFG["#CFG.SMPrefix#_Username"] eq ATTRIBUTES.Username>
		<CFSET Email = CFG["#CFG.SMPrefix#_Email"]>
		<CFSET Password = CFG["#CFG.SMPrefix#_Password"]>
<CFMAIL FROM="#Email#" TO="#Email#" SUBJECT="Your Password">
A user, possibly you has requested a password reminder.

Your password is : #Password#

If you did not request this reminder, do not worry only this email 
address has received the password.
</CFMAIL>
		<CFSET ATTRIBUTES.PasswordSent = "Yes">
	<CFELSE>
		<CFSET ATTRIBUTES.PasswordSent = "No">
	</CFIF>
	
</CFSILENT>