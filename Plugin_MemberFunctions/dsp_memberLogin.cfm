<link href="../styles.css" rel="stylesheet" type="text/css"> 
<CFFORM name="theForm" action="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">
  <table width="450" border="0" cellpadding="6" cellspacing="0">
<tr> 
      <td class="bodystyle"> <CFOUTPUT> 
<div align="left"><b>New Members</b><br>
            To list your vehicle with <SPAN CLASS="mhe"><strong><font color="##FF6600"><em>MotorhomeExchange-Sell.com</em></font></strong></SPAN>, 
            please use the <a href="#CGI.SCRIPT_NAME#?FuseAction=memberSignUp">online 
            application form</a> and you will receive access to the members only 
            area. </div>
		  </CFOUTPUT>
      </td>
    </tr>
    <tr> 
      <td align="left" valign="top" class="bodystyle"> <CFOUTPUT> <b>Existing 
          Members</b><br>
        Please enter the e-mail address and password that you chose when creating 
        your member profile. If you have <A HREF="#CGI.SCRIPT_NAME#?FuseAction=memberForgotPassword">forgotten your password</A> we can e-mail 
        your password to you.
		</CFOUTPUT>
		</td>
    </tr>
	<tr><td>
<CFIF Len(ATTRIBUTES.entryErrors)>
	<TABLE WIDTH="450" BORDER="0">
		<TR>
			<TD>
				<FONT COLOR="RED">
					There was an error in the information you supplied, please correct the
					following issues and re-submit. Thank you.
				</FONT>
				<UL>
					<CFLOOP INDEX="message" LIST="#ATTRIBUTES.entryErrors#" DELIMITERS=";">
						<LI> <CFOUTPUT>#message#</CFOUTPUT>
					</CFLOOP>
				</UL>
			</TD>
		</TR>
	</TABLE>
</CFIF>
	
	
	</td></tr>
    <tr> 
      <td align="left" valign="top"> 
<table width="350" border="0" align="center" cellpadding="5" cellspacing="0" class="formstylre">
<tr> 
            <td width="30" class="formtitle"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td><b><font color="#FFFFFF">Login</font></b></td>
<td width="20">&nbsp;</td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td align="left" valign="top" class="text"><div align="justify">
                <table width="350" border="0" cellspacing="0" cellpadding="4" align="center">
                  <tr> 
                    <td> <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#CC9933" align="center">
                        <tr bgcolor="#FFFFFF"> 
                          <td width="30%"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000"><span class="bodystyle">e-mail 
                            address:</span></font></td>
                          <td width="70%"> <input type="text" name="email" size="20" class="formstylre" maxlength="255"> 
                          </td>
                        </tr>
                        <tr bgcolor="#FFFFFF"> 
                          <td width="30%" height="2"> <p><font face="Arial, Helvetica, sans-serif" size="2" color="#000000" class="bodystyle">Password:</font></p></td>
                          <td width="70%" height="2"> <input type="password" name="password" size="20" class="formstylre" maxlength="10"> 
                            <img src="Images/holder.gif" width="10" height="10"> 
                            <input type="submit" name="Submit" value="Submit" class="loginbutton"> 
                          </td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
<br>
              </div></td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
</CFFORM>
