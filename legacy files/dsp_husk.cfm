<CFIF (FindNoCase("www.","#CGI.HTTP_HOST#") NEQ 0)
	OR (FindNoCase("MotorhomeExchange-Sell.com","#CGI.HTTP_HOST#") NEQ 0)
	OR (FindNoCase("megamall.co.nz","#CGI.HTTP_HOST#") NEQ 0)
	>
	<CFSET InsecureURL="http://www.MotorhomeExchange-Sell.com">
<CFELSE>
	<CFSET InsecureURL="http://motorhome/website">
</CFIF>
<html>
<head>
<title>Motorhome Exchange-sell.com</title>
<CFOUTPUT>
<meta name="keywords" content="#HTMLEditFormat(CFG.Keywords)#">
<meta name="description" content="#HTMLEditFormat(CFG.Description)#">
</CFOUTPUT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<link rel="stylesheet" href="styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" background="Images/huskImages/side-back.gif" text="#000000" link="#FF6600" vlink="#FF6600" alink="#FF6600" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('Images/huskImages/members1.gif','Images/huskImages/search_1.gif','Images/huskImages/com-profile1.gif','Images/huskImages/about-us1.gif','Images/huskImages/succ-stories1.gif','Images/huskImages/q_a-1.gif','Images/huskImages/non-mem1.gif','Images/huskImages/free-news1.gif','Images/huskImages/contac1.gif','Images/huskImages/terms1.gif','Images/huskImages/membeship1.gif','Images/huskImages/onlin-appll1.gif','Images/huskImages/home-r.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <CFFORM NAME="theForm23jcvxj" ACTION="#CGI.SCRIPT_NAME#?FuseAction=Listing">
      <td rowspan="3" width="12" align="left" valign="top"><img src="Images/huskImages/side-orang.gif" width="12" height="600"></td>
      <td width="163" height="76" rowspan="2" align="left" valign="middle"> <div align="center"> 
          <input name="SearchKeywords" type="text" class="labeltextwhite" size="12">
          <input name="Submit" type="submit" class="labeltextwhite" value="SEARCH">
        </div></td>
      <td colspan="3" align="left" valign="top" bgcolor="#FF6600"> <CFOUTPUT> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td align="left" valign="top"><div align="left"><img src="Images/huskImages/header-left.gif" width="118" height="76"></div></td>
              <td> <div align="center"><img src="Images/huskImages/header-mid.gif" width="379" height="76"></div></td>
              <td align="right"><img src="Images/huskImages/header-right.gif" width="128" height="76"></td>
            </tr>
          </table>
        </CFOUTPUT> </td>
    </CFFORM>
  </tr>
  <tr> 
    <td align="left" valign="top" colspan="3"> <div align="center"></div>
<CFIF Len(SESSION.SecurityID)>
        <div align="center"></div>
        <div align="center"><img src="Images/huskImages/members_nav.gif" width="625" height="21" usemap="#Map" border="0"> 
</div>
        <CFELSE>
        <div align="center"><img src="Images/huskImages/quote.gif" width="625" height="21" border="0"> 
        </div>
      </CFIF> </td>
  </tr>
  <tr> 
    <td align="left" valign="top" width="163"> <CFOUTPUT> 
        <table width="163" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td><p><a href="#InsecureURL#/fusebox.cfm?FuseAction=MemberHome" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('members','','Images/huskImages/members1.gif',1)"><img name="members" border="0" src="Images/huskImages/members-.gif" width="163" height="42" alt="Members"></a><a href="#InsecureURL#/fusebox.cfm" onMouseOver="MM_swapImage('Home','','Images/huskImages/home-r.gif',1)" onMouseOut="MM_swapImgRestore()"><br>
                <img src="Images/huskImages/home.gif" name="Home" width="163" height="21" border="0" id="Home"></a><br>
                <a href="#InsecureURL#/fusebox.cfm?FuseAction=search" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('search','','Images/huskImages/search_1.gif',1)"><img name="search" border="0" src="Images/huskImages/search_.gif" width="163" height="18" alt="Search"></a><BR>
                <a href="#InsecureURL#/Content/CompanyProfile.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('company profile','','Images/huskImages/com-profile1.gif',1)"><img name="company profile" border="0" src="Images/huskImages/com-profile.gif" width="163" height="18" alt="Company Profile"></a><BR>
                <a href="#InsecureURL#/Content/AboutUs.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('about us','','Images/huskImages/about-us1.gif',1)"><img name="about us" border="0" src="Images/huskImages/about-us.gif" width="163" height="18" alt="About us"></a><BR>
                <a href="#InsecureURL#/Content/SuccessStories.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('success stories','','Images/huskImages/succ-stories1.gif',1)"><img name="success stories" border="0" src="Images/huskImages/succ-stories.gif" width="163" height="18" alt="Success Stories"></a><BR>
                <a href="#InsecureURL#/Content/QandA.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('q & a','','Images/huskImages/q_a-1.gif',1)"><img src="Images/huskImages/q_a-.gif" alt="Q &amp; A" name="q & a" width="163" height="18" border="0"></a><BR>
                <a href="#InsecureURL#/Content/NonMembers.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('non members','','Images/huskImages/non-mem1.gif',1)"><img name="non members" border="0" src="Images/huskImages/non-mem.gif" width="163" height="18" alt="Non Members"></a><BR>
                <a href="#InsecureURL#/fusebox.cfm?FuseAction=FreeNewsletter" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('free newsletter','','Images/huskImages/free-news1.gif',1)"><img name="free newsletter" border="0" src="Images/huskImages/free-news.gif" width="163" height="18" alt="Free Newsletter"></a><BR>
                <a href="#InsecureURL#/fusebox.cfm?FuseAction=ContactUs" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('contact us','','Images/huskImages/contac1.gif',1)"><img name="contact us" border="0" src="Images/huskImages/contac.gif" width="163" height="18" alt="Contact Us"></a><BR>
                <a href="#InsecureURL#/Content/TermsOfUse.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('terms of use','','Images/huskImages/terms1.gif',1)"><img name="terms of use" border="0" src="Images/huskImages/terms.gif" width="163" height="18" alt="Terms of Use"></a><BR>
                <a href="#InsecureURL#/Content/Membership.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('membership','','Images/huskImages/membeship1.gif',1)"><img name="membership" border="0" src="Images/huskImages/membeship.gif" width="163" height="18" alt="Membership"></a><BR>
                <a href="#InsecureURL#/fusebox.cfm?FuseAction=MemberSignUp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('online application','','Images/huskImages/onlin-appll1.gif',1)"><img name="online application" border="0" src="Images/huskImages/onlin-appll.gif" width="163" height="18" alt="Online Application"></a><BR>
                <img src="Images/huskImages/bottom-nav-pic.gif" width="163" height="301"></p>
              </td>
          </tr>
        </table>
      </CFOUTPUT> </td>
    <td width="15" align="left" valign="top"><img src="Images/holder.gif" height="10" width="15"></td>
    <td width="100%" align="left" valign="top"> 
      <div align="left"> <CFOUTPUT> 
          <CFIF IsDefined("REQUEST.TitleImage") AND Len(REQUEST.TitleImage)>
            <IMG SRC="#REQUEST.TitleImage#" ALT="#HTMLEditFormat(REQUEST.Title)#" HEIGHT="60"> 
            <CFELSE>
            <!---								<p class="textCopy">#HTMLEditFormat(REQUEST.Title)#</p>--->
          </CFIF>
        </CFOUTPUT> 
        <!---	  <img src="Images/headers/welcome.gif" width="115" height="60" alt="Welcome"> --->
        <br>
        <br>
        <CFOUTPUT>
		#BodyData#
		</CFOUTPUT> </div></td>
    <td width="10" align="left" valign="top"><img src="Images/holder.gif" height="10" width="15"></td>
  </tr>
  <tr> 
    <td width="12" align="left" valign="top">&nbsp;</td>
    <td align="left" valign="top" width="163">&nbsp;</td>
    <td width="15" align="left" valign="top">&nbsp;</td>
    <td colspan="2" align="left" valign="top"> 
      <div align="center"> 
        <p class="textlinks"><A style="text-decoration: none" HREF="http://www.motorhomeexchange-sell.com/fusebox.cfm"><font color="#333333"><br>
          <br>
          Back to Home</font></A><br><CFOUTPUT>
          <A style="text-decoration: none" HREF="#InsecureURL#/fusebox.cfm?FuseAction=MemberHome"><font color="##333333">Members</font></A> 
          <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/fusebox.cfm?FuseAction=search"><font color="##333333">Search</font></A> 
          <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/CompanyProfile.cfm"><font color="##333333">Company 
          Profile</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/AboutUs.cfm"><font color="##333333">About 
          us</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/SuccessStories.cfm"><font color="##333333">Success 
          Stories</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/QandA.cfm"><font color="##333333">Q 
          &amp; A</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/NonMembers.cfm"><font color="##333333">Non 
          Members</font></A><br>
          <A style="text-decoration: none" HREF="#InsecureURL#/fusebox.cfm?FuseAction=FreeNewsletter"><font color="##333333">Free 
          Newsletter</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/fusebox.cfm?FuseAction=ContactUs"><font color="##333333">Contact 
          Us</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/TermsOfUse.cfm"><font color="##333333">Terms 
          of Use</font></A> <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/Content/Membership.cfm"><font color="##333333">Membership</font></A> 
          <font color="##FF6600">l</font> <A style="text-decoration: none" HREF="#InsecureURL#/fusebox.cfm?FuseAction=MemberSignUp"><font color="##333333">Online 
          Application</font></A> </p>
</CFOUTPUT>
        <font size="3"><span class="textlinks">&copy; Copyright Motorhome Exchange-sell.com 
        2002. All rights reserved.<br>
        Terms of use and disclaimer apply.<br>
        <br>
        </span></font></div>
      <!---	
	
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
	
<div align="center">
        <p class="textlinks" align="center"><br>
          Members <font color="#FF6600">l</font> Search <font color="#FF6600">l</font> 
          Company Profile <font color="#FF6600">l</font> About us <font color="#FF6600">l</font> 
          Success Stories <font color="#FF6600">l</font> Q &amp; A <font color="#FF6600">l</font> 
          Non Members<br>
          Free Newsletter<font color="#0099CC"> </font><font color="#FF6600">l</font> 
          Contact Us <font color="#FF6600">l</font> Terms of Use <font color="#FF6600">l</font> 
          Membership <font color="#FF6600">l</font> Online Application </p>
        <div align="center">
          <p><span class="textlinks">&copy; Copyright Motorhome Exchange-sell.com 
            2002. All rights reserved.<br>
            Terms of use and disclaimer apply.</span></p>
          <p>&nbsp;</p>
        </div>
    </div>--->
    </td>
  </tr>
</table>
<CFOUTPUT>
  <map name="Map">
<area shape="rect" coords="415,3,496,20" href="#InsecureURL#/Content/SendPhoto.cfm">
  <area shape="rect" coords="282,3,394,18" href="#InsecureURL#/Content/SampleVehicle.cfm">
  <area shape="rect" coords="181,2,267,18" href="#InsecureURL#/fusebox.cfm?FuseAction=AddListing&ActionType=ADD">
    <area shape="rect" coords="45,2,158,19" href="#InsecureURL#/fusebox.cfm?FuseAction=EditRenewListing">
  <area shape="rect" coords="518,2,573,18" href="#InsecureURL#/fusebox.cfm?FuseAction=MemberLogout">
</map>
</CFOUTPUT>

</body>
</html>
