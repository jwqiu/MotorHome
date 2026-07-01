<CFIF Len(ATTRIBUTES.EntryErrors)>
	There was a problem with your enquiry submission. Please click the
	back button on your browser and fix the error:
	<CFOUTPUT>
		<UL>
			<LI>#ATTRIBUTES.EntryErrors#</LI>
		</UL>
	</CFOUTPUT>

<CFELSE>
	Thank you. Your enquiry has been e-mailed to the listing owner.
</CFIF>