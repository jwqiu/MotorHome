<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE><CFOUTPUT>#ReReplace(REQUEST.Title, "<[^<>]*>", "", "ALL")#</CFOUTPUT></TITLE>
<LINK REL="stylesheet" HREF="styles.css">
<SCRIPT language="JavaScript">
<!--
function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_changeProp(objName,x,theProp,theValue) { //v3.0
  var obj = MM_findObj(objName);
  if (obj && (theProp.indexOf("style.")==-1 || obj.style)) eval("obj."+theProp+"='"+theValue+"'");
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</SCRIPT>

<SCRIPT language="JavaScript" TYPE="text/javascript">
 <!--
 	<CFOUTPUT>
	<CFLOOP FROM="1" TO="#ArrayLen(AdminMenus)#" INDEX="menu">
		menu#menu# = '#Evaluate("JS_#menu#")#';
	</CFLOOP>
	</CFOUTPUT>
	
	function highlightMenuItem(menuID) {
		MM_changeProp(menuID,'','style.backgroundColor','#CCCCCC','TD');
	}

	function unhighlightMenuItem(menuID) {
		MM_changeProp(menuID,'','style.backgroundColor','#E8EAEB','TD')
	}
	
	function highlightMenuBarItem(menuID) {
		MM_changeProp(menuID,'','style.backgroundColor','#004488','TD');
	}
	
	function unhighlightMenuBarItem(menuID) {
		MM_changeProp(menuID,'','style.backgroundColor','#003366','TD')
	}
 //-->
</SCRIPT>
</HEAD>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" LINK="#000066" VLINK="#999999" ALINK="#666666" >
<DIV ID="overDiv" STYLE="position:absolute; visibility:hide; z-index:1;"></DIV>
<SCRIPT language="JavaScript" SRC="_JS/overlib.js"></SCRIPT>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
    <TD ALIGN="RIGHT" HEIGHT="40"><SPAN CLASS="AdminSiteName"><CFOUTPUT>#CFG.WebSiteName#</CFOUTPUT> 
      Administration</SPAN></TD>
  </TR>
  <TR STYLE="background-color:#003366;border-top:none;"> 
    <TD> 
      <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
        <CFOUTPUT> 
          <TR> 
		  	<!--- Drop Down Menus --->
			<CFSET xPos = 0>
			<CFSET menuOut = 0>
			<CFLOOP FROM="1" TO="#ArrayLen(AdminMenus)#" INDEX="menu">
				<CFIF ArrayLen(AdminMenus[menu].Items)>
				<TD ID="menu_#menu#" CLASS="menuBarItem" onMouseOver="highlightMenuBarItem('menu_#menu#');nd();return overlib(menu#menu#, FIXX, #xPos#, FIXY, 59, PADX, 0, 0, PADY, 0, 0, WIDTH, 110, BORDER, 0, TIMEOUT, 6000);" onMouseOut="unhighlightMenuBarItem('menu_#menu#')">#AdminMenus["#menu#"].Title#</TD>
				<CFSET xPos = xPos + 151>
				<CFSET menuOut = menuOut + 1>
				</CFIF>
			</CFLOOP>
           
		   <!--- Standard menu items --->
			<TD CLASS="menuBarItem" STYLE="width:0">&nbsp; </TD>
			<TD ID="menuBarItemHome" CLASS="menuBarItem" STYLE="width:75px" onMouseOver="highlightMenuBarItem('menuBarItemHome');" onMouseOut="unhighlightMenuBarItem('menuBarItemHome')"><A HREF="#CGI.SCRIPT_NAME#?FuseAction=administration" STYLE="color:white;text-decoration:none;">Home</A></TD>
			<TD ID="menuBarItemHelp" CLASS="menuBarItem" STYLE="width:20px" onMouseOver="highlightMenuBarItem('menuBarItemHelp');" onMouseOut="unhighlightMenuBarItem('menuBarItemHelp')"><A HREF="#CGI.SCRIPT_NAME#?FuseAction=adminHelp" STYLE="color:white;text-decoration:none;"><STRONG>?</STRONG></A></TD>
			<TD ID="menuBarItemLogout" CLASS="menuBarItem" STYLE="width:75px" onMouseOver="highlightMenuBarItem('menuBarItemLogout');" onMouseOut="unhighlightMenuBarItem('menuBarItemLogout')"><A HREF="#CGI.SCRIPT_NAME#?FuseAction=LogOut&Processor=Admin" STYLE="color:white;text-decoration:none;">Log Out</A></TD>
          </TR>
        </CFOUTPUT> 
        <TR> 
         <CFOUTPUT><TD COLSPAN="#Evaluate('menuOut + 4')#" STYLE="background-color:##E8EAEB;border-bottom:1px solid ##999999;">&nbsp;</TD></CFOUTPUT>
        </TR>
      </TABLE>
    </TD>
  </TR>
  <TR> 
    <TD VALIGN="top"> 
      <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
        <TR VALIGN="top"> 
          <TD WIDTH="105" HEIGHT="540" ROWSPAN="2" VALIGN="bottom" STYLE="background-color: #E8EAEB; border-right: 1px solid #999999; border-bottom: 1px solid #999999; font-size: 6pt;"> 
            <P> Innovative Media<BR>
              49 Carlyle Street<BR>
              Christchurch </P>
            <P> PO Box 7667<BR>
              Christchurch<BR>
              New Zealand </P>
            <P> Phone 03 377 6262<BR>
                Fax &nbsp;&nbsp; 03 377 6202 </P>
            <DIV ALIGN="CENTER"> <IMG SRC="images/l-brandmark.jpg" ALT="Innovative Media Limited's Logo"> 
            </DIV>
          </TD>
          <TD STYLE="padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px;" VALIGN="TOP"> 
            <P><STRONG><cfoutput>#REQUEST.Title#</cfoutput></STRONG></P>
            <cfoutput>#ATTRIBUTES.BodyData#</cfoutput></TD>
        </TR>
        <CFOUTPUT> 
          <TR>
            <TD VALIGN="BOTTOM" ALIGN="CENTER"> 
              <P> 
			  <SMALL> <A HREF="#CGI.SCRIPT_NAME#?FuseAction=adminMenu">home</A> 
                I <A HREF="#CGI.SCRIPT_NAME#?FuseAction=adminHelp">help</A> I <A HREF="#CGI.SCRIPT_NAME#?FuseAction=adminLogoff">Logoff</A><BR>
                <BR>
                </SMALL> </P>
            </TD>
          </TR>
        </CFOUTPUT> 
      </TABLE>
    </TD>
  </TR>
</TABLE>
<P>&nbsp;</P>
</BODY>
</HTML>

