<CFPARAM NAME="ATTRIBUTES.Ref" DEFAULT="">

<!--- Stop people coming in and running this FuseAction 50 times 
	- if they don't know the "Ref" number 
	-
	- (the 'Left' thing was added cos there was a trailing slash
	- at the end of the URL when the scheduled task was set up
	- in the CF administrator on the server)
	--->
	
<CFIF Left(ATTRIBUTES.Ref,5) EQ "2PY4B">

	<CFQUERY NAME="Q_OneMonth" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Listings, Members
		WHERE #CreateODBCDate(DateAdd("m",1,Now()))# = LiRenewDate
			AND LiMemberLink = MeID
			AND LiAuthorised = 1
	</CFQUERY>
	
	<CFQUERY NAME="Q_OneWeek" DATASOURCE="#CFG.DS#" CONNECTSTRING="#CFG.CONNECTSTRING#" DBTYPE="#CFG.DBTYPE#">
		SELECT * FROM Listings, Members
		WHERE #CreateODBCDate(DateAdd("ww",1,Now()))# = LiRenewDate
			AND LiMemberLink = MeID
			AND LiAuthorised = 1
	</CFQUERY>
	
	The following listings expire in one month from today:
	<UL>
	<CFOUTPUT QUERY="Q_OneMonth">
		<LI>#MeFormalName# - #MeEmail# - #LiMakeAndModel# #LiYear#</LI>
	</CFOUTPUT>
	</UL>

	The following listings expire in one week from today:
	<UL>
	<CFOUTPUT QUERY="Q_OneWeek">
		<LI>#MeFormalName# - #MeEmail# - #LiMakeAndModel# #LiYear#</LI>
	</CFOUTPUT>
	</UL>

<CFMAIL FROM="#CFG.EmailAddress#" TO="#MeEmail#" QUERY="Q_OneMonth" SUBJECT="Your vehicle listing at MotorhomeExchange-Sell.com will expire in one month." TYPE="HTML">
<html>
<head>
<title>MotorhomeExchange-Sell.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="##FFFFFF">
<font face="Arial, Helvetica, sans-serif" size="2">
<p>
Dear #MeFormalName#,
</p>
<p>
Your vehicle listing "#LiMakeAndModel# #LiYear#" will expire on #DateFormat(LiRenewDate,"d mmm yyyy")#. If you wish to keep your listing online, then you should renew it now.
</p>
<p>
You can renew your listing from the members area:<br>
<A HREF="http://www.MotorhomeExchange-Sell.com/fusebox.cfm?FuseAction=MemberHome">
http://www.MotorhomeExchange-Sell.com/fusebox.cfm?FuseAction=MemberHome
</A>
</p>
<p>
Regards,
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
	
<CFMAIL FROM="#CFG.EmailAddress#" TO="#MeEmail#" QUERY="Q_OneWeek" SUBJECT="Your vehicle listing at MotorhomeExchange-Sell.com will expire in seven days." TYPE="HTML">
<html>
<head>
<title>MotorhomeExchange-Sell.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="##FFFFFF">
<font face="Arial, Helvetica, sans-serif" size="2">
<p>
Dear #MeFormalName#,
</p>
<p>
Your vehicle listing "#LiMakeAndModel# #LiYear#" will expire on #DateFormat(LiRenewDate,"d mmm yyyy")#. If you wish to keep your listing online, then you should renew it now.
</p>
<p>
This is your final reminder.
</p>
<p>
You can renew your listing from the members area:<br>
<A HREF="http://www.MotorhomeExchange-Sell.com/fusebox.cfm?FuseAction=MemberHome">
http://www.MotorhomeExchange-Sell.com/fusebox.cfm?FuseAction=MemberHome
</A>
</p>
<p>
Regards,
</p>
<p>
Penny Silva<BR>
#CFG.EmailAddress#<BR>
#Replace(CFG.ContactDetails,Chr(13),"<BR>","ALL")#
</p>
</font>
</body>
</html>
</CFMAIL>
	
</CFIF>

