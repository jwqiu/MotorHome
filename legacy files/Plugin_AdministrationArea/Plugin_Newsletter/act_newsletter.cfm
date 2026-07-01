<CFSILENT>
	
	<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseActioN#")>
		<CFSET MailingList = Q_Members>
		
		<CFIF IsDefined("ATTRIBUTES.Preview")>
			<CFSET MailingList = QueryNew("Name,Email")>
			<CFSET x = QueryAddRow(MailingList)>
			<CFSET x = QuerySetCell(MailingList, "Name", "Member's Formal Name")>
			<CFSET x = QuerySetCell(MailingList, "Email", "Member's E-mail")>
		</CFIF>
		
		<CFLOOP QUERY="MailingList">
			<CFSET Body = ATTRIBUTES.Body>
			<CFLOOP LIST="#MailingList.ColumnList#" INDEX="Col">
				<CFSET Body = ReplaceNoCase(Body, "{{#Col#}}", Evaluate("#Col#"), "ALL")>
			</CFLOOP>
			<CFSET Body = ReplaceNoCase(Body, "{{Unsubscribe}}", "<A HREF='#CFG.AbsoluteWebURL#/fusebox.cfm?FuseAction=FreeNewsletter'>Click here to unsubscribe</a>","ALL")>
			<CFIF NOT IsDefined("ATTRIBUTES.Preview")>
				<CFMAIL FROM="#CFG.EmailAddress#" TO="#Email#" SUBJECT="#ATTRIBUTES.Subject#" TYPE="HTML">#Body#</CFMAIL>
			<CFELSE>
				<CFMAIL FROM="#CFG.EmailAddress#" TO="#CFG.EmailAddress#" SUBJECT="#ATTRIBUTES.Subject#" TYPE="HTML">#Body#</CFMAIL>
			</CFIF>
			
		</CFLOOP>
	</CFIF>

</CFSILENT>