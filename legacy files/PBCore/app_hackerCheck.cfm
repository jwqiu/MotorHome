<CFSILENT>
	<!--------------------------------------------------------------------------
		- Check for possible hackers
		------------------------------------------------------------------------
		- We want to make sure that users are not permitted to request files 
		- other than fuseboxes and the error reporting stuff.
		-----------------------------------------------------------------------> 

	<CFIF Not ReFindNoCase("(fusebox.cfm)|(index.cfm)|(app_error_mail.cfm)$", CGI.SCRIPT_NAME)>
		<!--- Hacker alert! --->
		<CFIF Len(CFG.hackerMail)>
		<CFMAIL FROM="website@#ListRest(CGI.SERVER_NAME, '.')#" 
				TO="#CFG.hackerMail#" SUBJECT="Hacking Attempt Detected" TYPE="HTML">
			A possible attempt at hacking has been detected on #CFG.webSiteName# 
			at #TimeFormat(Now(), "HH:mm:ss")# on #DateFormat(Now(), "dddd d mmmm yyyy")#,
			the following information is known...<BR>
			<CFDUMP VAR=#CGI#><BR>
			The suspected hacker was redirected to #CFG.hackerURL#.
			<HR>
			PlugBox		
		</CFMAIL>
		</CFIF>
		<CFLOCATION URL="#CFG.hackerURL#" ADDTOKEN="No">
	</CFIF>

</CFSILENT>