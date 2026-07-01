 
<P> You must log in using your username and password to enter this area. If you 
  have forgotten your password we can <CFOUTPUT><A HREF="#CGI.SCRIPT_NAME#?FuseAction=#CFG.SMPrefix#forgotPassword&Processor=#ATTRIBUTES.Processor#&RFA=#URLEncodedFormat(REQUEST.Back)#">email 
    you your password</A></CFOUTPUT>. </P>
<CFIF Len(ATTRIBUTES.entryErrors)>
<P> <STRONG>A Problem :</STRONG> Please correct the following problem 
  <CFIF ListLen(ATTRIBUTES.entryErrors, ";") GT 1>
  s 
  </CFIF>
  , and try again. 
<UL>
  <CFLOOP LIST="#ATTRIBUTES.entryErrors#" INDEX="error">
    <CFOUTPUT> 
      <LI>#error#</LI>
    </CFOUTPUT> 
  </CFLOOP>
</UL>
<p></P>
</CFIF>
<TABLE  cellSpacing=0 cellPadding=4 width=300 align=center border=1>
  <TBODY> 
  <TR> 
    <TD height=30><B>Login</B></TD>
  </TR>
  <TR> 
    <TD> 
      <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center 
border=0>
        <TBODY> 
        <CFFORM ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.FuseAction#=Yes&Processor=#ATTRIBUTES.Processor#">
          <TR > 
            <TD width="30%">Username:</TD>
            <TD width="70%"> 
              <CFINPUT TYPE="TEXT" SIZE="30" MAXLENGTH="255" REQUIRED="Yes" MESSAGE="You must enter your username." NAME="Username">
            </TD>
          </TR>
          <TR > 
            <TD width="30%" height=2>Password:</TD>
            <TD width="70%" height=2> 
              <CFINPUT TYPE="PASSWORD" SIZE="25" MAXLENGTH="25" REQUIRED="Yes" MESSAGE="You must enter your password." NAME="Password">
            </TD>
          </TR>
          <TR > 
            <TD width="30%" height=2> </TD>
            <TD width="70%" height=2> 
              <INPUT TYPE="SUBMIT" VALUE="Log In" NAME="SUBBY_THE_SUBMIT">
            </TD>
          </TR>
        </CFFORM>
        </TBODY> 
      </TABLE>
    </TD>
  </TR>
  </TBODY> 
</TABLE>
