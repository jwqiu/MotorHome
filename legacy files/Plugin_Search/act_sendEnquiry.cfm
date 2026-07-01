
 <CFSCRIPT>
	function wf_paragraphFormat(text) {
		var tempText = "";

			tempText = text;
			
			tempText = HTMLEditFormat(tempText);

			tempText = Replace(tempText, Chr(13), "", "ALL");
			tempText = ReReplaceNoCase(tempText, "#CHR(10)##CHR(10)#", "<P>", "ALL");
			tempText = ReReplaceNoCase(tempText, "#CHR(10)#", "<BR>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[B\]", "<B>", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/B\]", "</B>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[UL\]", "<UL>", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/UL\]", "</UL>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[LI\]", "<LI>", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/LI\]", "</LI>", "ALL");
			
			tempText = ReReplaceNoCase(tempText, "\[A HREF=&quot;([^]]*)&quot;\]", "<A HREF=""\1"">", "ALL");
			tempText = ReReplaceNoCase(tempText, "\[/A\]", "</A>", "ALL");
			
			return tempText;
	}
</CFSCRIPT>

<CFIF NOT Len(ATTRIBUTES.EntryErrors)>
	<CFMAIL FROM="#ATTRIBUTES.email#" TO="#Q_Member.MeEmail#" SUBJECT="#ATTRIBUTES.Subject#" TYPE="HTML">
<html>
<head>
<title>MotorhomeExchange-Sell.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<font face="Arial, Helvetica, sans-serif" size="2">
<p>
Dear #Q_Member.MeFormalName#
</p>
<p>
Below you will find a message from a person interested in your vehicle offer.
</p>
MotorhomeExchange-Sell.com does not get a copy of this e-mail. Make sure you always have a copy by printing a copy now for your records.
<p>
Please make sure that you include THIS ENTIRE MESSAGE in your reply. This will mean that the person who wants to contact you regarding your offer can tell which of their messages you are responding to.
</p>
<p>
Simply respond to the e-mail address below.
</p>
<p>
Sender's Name: #ATTRIBUTES.name#<BR>
Sender's e-mail: #ATTRIBUTES.email#
</p>
<p>
THE MESSAGE
<hr>
</p>
<p>
#wf_paragraphFormat(ATTRIBUTES.Body)#
</p>
<p>
<hr>
Motorhomeexchange.com ensures your privacy. e-mails go directly between members and non-members. MotorhomeExchange-Sell.com does not get a copy.
</p>
<p>
Please respond to all incoming e-mail regarding your MotorhomeExchange-Sell.com listing. Even if you are not interested, a "Thank you for your enquiry, but I am not interested, at this time" message is all that is required. 
</p>
<p>
Happy Holidays,
</p>
<p>
Penny Silva<BR>
#CFG.emailAddress#<BR>
#Replace(CFG.ContactDetails,Chr(13),"<BR>","ALL")#
</p>
</font>
</body>
</html>
	
	</CFMAIL>
</CFIF>