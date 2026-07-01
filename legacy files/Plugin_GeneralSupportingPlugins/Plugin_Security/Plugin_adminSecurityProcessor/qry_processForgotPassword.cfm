<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Username">
	
	<!--- Default password mailer, requires username, password and email in 
		- CFG --->
	
	<CFIF CFG.AdminUsername eq ATTRIBUTES.Username>
<CFMAIL FROM="#CFG.EmailAddress#" TO="#CFG.EmailAddress#" SUBJECT="Your Password">
A user, possibly you has requested a password reminder.

Your password is : #CFG.AdminPassword#

If you did not request this reminder, do not worry only this email 
address has received the password.
</CFMAIL>
		<CFSET ATTRIBUTES.PasswordSent = "Yes">
	<CFELSE>
		<CFSET ATTRIBUTES.PasswordSent = "No">
	</CFIF>
	
</CFSILENT>