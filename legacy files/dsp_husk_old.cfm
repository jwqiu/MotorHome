<html>
<head>
<title><CFOUTPUT>Motorhome Exchange-sell.com - #REQUEST.Title#</CFOUTPUT></title>
<meta name="keywords" content="Motorhomes, campervans, caravans, recreational vehicle's, exchange, rent, sell, buy, travel, exchange partners, travelling, tramping, adventure, deluxe, New Zealand, Christchurch, campervan rental, motorhome rental, hire, ">
<meta name="description" content="MotorhomeExchange-Sell.com is a website devoted to private, national and international, motorhome exchange. It also includes private rental and sales.">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="styles.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF" link="#333333" vlink="#FF6600" alink="#FF6600">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="left" valign="top"> <table width="640" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>
		  	<CFOUTPUT>
            <div align="center"><a href="#CGI.SCRIPT_NAME#"><img src="Images/huskImages/logo.gif" alt="MotorHome Exchange-sell.com" width="228" height="49" border="0"></a></div>
			</CFOUTPUT>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
	<CFSCRIPT>
		// Rotating header images
		if (isDefined("SESSION.HeaderImage")) {
			SESSION.HeaderImage = SESSION.HeaderImage+1;
			if (SESSION.HeaderImage GT 7) {
				SESSION.HeaderImage = 1;
			}
		} else {
			SESSION.HeaderImage = 1;			
		}
	</CFSCRIPT>
  	<CFOUTPUT>
    <td height="71" align="left" valign="bottom" background="Images/headers/hdr#SESSION.HeaderImage#.jpg"> 
      <table width="220" border="0" cellpadding="0" cellspacing="0">
	  	<CFFORM NAME="theForm23jcvxj" ACTION="#CGI.SCRIPT_NAME#?FuseAction=Listing">
        <tr> 
          <td width="16" rowspan="2" align="left" valign="bottom"><img src="Images/huskImages/holder.gif" width="16" height="10"></td>
          <td width="10" rowspan="2" align="left" valign="bottom"><img src="Images/huskImages/holder.gif" width="10" height="10"></td>
          <td width="194" align="left" valign="bottom">
              <input name="SearchKeywords" type="text" class="labeltextwhite" size="12">
              <input name="Submit" type="submit" class="labeltextwhite" value="SEARCH">
             </td>
        </tr>
		</CFFORM>
        <tr>
          <td height="10" align="left" valign="bottom"><img src="Images/huskImages/holder.gif" width="10" height="10"></td>
        </tr>
      </table>
    </td>
	</CFOUTPUT>
  </tr>
  <tr>
    <td align="left">
		<CFIF Len(SESSION.SecurityID)>
			<img src="Images/huskImages/top_members_nav.gif" width="640" height="23" usemap="#Map" border="0">
		<CFELSE>
			<img src="Images/huskImages/top_quote.gif" width="640" height="23" border="0">
		</CFIF>
	</td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="141" align="left" valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <CFOUTPUT> 
                <tr> 
                  <td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=MemberHome"><img border="0" src="Images/huskImages/members.gif" alt="Members" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=search"><img border="0" src="Images/huskImages/search.gif" alt="Search" width="141" height="24"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/CompanyProfile.cfm"><img border="0" src="Images/huskImages/company_profile.gif" alt="Company Profile" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/AboutUs.cfm"><img border="0" src="Images/huskImages/about_us.gif" alt="About us" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/SuccessStories.cfm"><img border="0" src="Images/huskImages/success_stories.gif" alt="Success Stories" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/QandA.cfm"><img src="Images/huskImages/q_a.gif" alt="Q &amp; A" width="141" height="19" border="0"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/NonMembers.cfm"><img border="0" src="Images/huskImages/non_members.gif" alt="Non Members" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=FreeNewsletter"><img border="0" src="Images/huskImages/free_newsletter.gif" alt="Free Newsletter" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=ContactUs"><img border="0" src="Images/huskImages/contact_us.gif" alt="Contact Us" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/TermsOfUse.cfm"><img border="0" src="Images/huskImages/terms_of_use.gif" alt="Terms of Use" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="Content/Membership.cfm"><img border="0" src="Images/huskImages/membership.gif" alt="Membership" width="141" height="18"></A></td>
                </tr>
                <tr> 
                  <td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=MemberSignUp"><img border="0" src="Images/huskImages/online_appli.gif" alt="Online Application" width="141" height="18"></A></td>
                </tr>
              </CFOUTPUT> </table></td>
          <td width="3" valign="top" background="Images/huskImages/line_separate.gif"><img src="Images/huskImages/holder_white.gif" width="3" height="10"></td>
          <td width="10" valign="top">&nbsp;</td>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="2">
              <CFOUTPUT> 
<CFIF IsDefined("REQUEST.TitleImage") AND Len(REQUEST.TitleImage)>
                  <tr> 
                    <td> <IMG SRC="#REQUEST.TitleImage#" ALT="#HTMLEditFormat(REQUEST.Title)#" HEIGHT="45"> 
                    </td>
                  </tr>
                  <CFELSE>
                  <!---								<p class="textCopy">#HTMLEditFormat(REQUEST.Title)#</p>--->
                </CFIF>
              </CFOUTPUT> 
              <!---			  <img src="Images/headers/profile.gif" alt="Profile" width="90" height="45"></td>--->
              <tr> 
                <td valign="top" class="bodystyle"> 
<table width="450" border="0" cellpadding="0" cellspacing="0" class="bodystyle">
<tr> 
                      <td class="bodystyle"> 
<p class="bodystyle"> <CFOUTPUT> #BodyData# </CFOUTPUT> 
                        </p></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="left"> <table width="640" border="0" cellspacing="0" cellpadding="10">
        <tr> 
          <td>
            <div align="center"> 
              <p class="textlinks"><br>
                Members <font color="#FF6600">l</font> Search <font color="#FF6600">l</font> 
                Company Profile <font color="#FF6600">l</font> About us <font color="#FF6600">l</font> 
                Success Stories <font color="#FF6600">l</font> Q &amp; A <font color="#FF6600">l</font> 
                Non Members<br>
                Free Newsletter<font color="#0099CC"> </font><font color="#FF6600">l</font> 
                Contact Us <font color="#FF6600">l</font> Terms of Use <font color="#FF6600">l</font> 
                Membership <font color="#FF6600">l</font> Online Application </p>
              <div align="center"><span class="textlinks">&copy; Copyright Motorhome 
                Exchange-sell.com 2002. All rights reserved.<br>
                Terms of use and disclaimer apply.</span></div>
    </div>
          </td>
        </tr>
      </table>
	</td>
  </tr>
</table>
<CFOUTPUT>
<map name="Map"> 
  <area shape="rect" coords="85,2,198,19" href="#CGI.SCRIPT_NAME#?FuseAction=EditRenewListing">
  <area shape="rect" coords="227,2,305,19" href="#CGI.SCRIPT_NAME#?FuseAction=AddListing&ActionType=ADD">
  <area shape="rect" coords="336,3,437,19" href="Content/SampleVehicle.cfm">
  <area shape="rect" coords="468,3,549,20" href="Content/SendPhoto.cfm">
</map>
</CFOUTPUT>
</body>
</html>
