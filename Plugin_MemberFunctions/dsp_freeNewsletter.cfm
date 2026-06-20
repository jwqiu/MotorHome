

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
  <font color="0066cc"></font></CFIF>


  <table width="450" border="0" cellpadding="6" cellspacing="0">

  	<CFIF ShowSuccessfulSubscribe>
    <tr> 
      <td align="left" valign="top"> 
	  	<CFOUTPUT>The free newsletter will be sent to #ATTRIBUTES.Email#. Thank you.</CFOUTPUT>
	</TD></TR>
	</CFIF>

  
  	<CFIF ShowSuccessfulUnsubscribe>
    <tr> 
      <td align="left" valign="top"> 
	  	<CFOUTPUT>The free newsletter will no longer be sent to #ATTRIBUTES.Email#. You may subscribe again at any time.</CFOUTPUT>
	</TD></TR>
	</CFIF>
  

	<CFIF ShowSubscribe>
    <tr> 
      <td align="left" valign="top"> 

<p><strong>Receive the &quot;Cruising Together&quot; <SPAN CLASS="mhe">MotorhomeExchange-Sell.com</SPAN> 
          newsletter by completing the information below</strong><br>
        </p>
        <table width="350" border="0" align="center" cellpadding="5" cellspacing="0" class="formstylre">
          <tr> 
<td class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td class="text"><font color="#FFFFFF"><b>SUBSCRIBE</b></font></td>
                  <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
<td class="text"> <div align="right">
                <table width="350" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" align="center">
                  <CFFORM name="theForm" action="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_Subscribe=1">
                    <tr> 
                      <td> <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#CC9933" align="center">
                          <tr bgcolor="#FFFFFF"> 
                            <td width="30%" class="bodystyle"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000">Name: 
                              </font></td>
                            <td width="70%"> <CFINPUT type="text" name="name" size="20" class="formstylre" maxlength="127"
						REQUIRED="Yes" MESSAGE="Please enter your name." VALUE="#ATTRIBUTES.Name#"> 
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
                            <td width="30%" class="bodystyle"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000">E-mail 
                              address:</font></td>
                            <td width="70%"> <CFINPUT type="text" name="email" size="20" class="formstylre" maxlength="255"
						REQUIRED="Yes" MESSAGE="Please enter your e-mail address." VALUE="#ATTRIBUTES.Email#"> 
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
                            <td width="30%" height="2">&nbsp;</td>
                            <td width="70%" height="2"> <input name="" type="submit" class="loginbutton" value="Subscribe"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                  </CFFORM>
                </table>
</div></td>
          </tr>
        </table>
        <div align="center"></div>
        <p>&nbsp; </p>
        
      </TD>
    </TR>
	</CFIF>
	
	<CFIF ShowUnsubscribe>
	<TR>
      <TD align="left" valign="top"> 
        <p><strong>Are you already on our list and want to unsubscribe?<br>
          <br>
          Simply enter your e-mail address below and click &quot;Remove Me&quot;.</strong></p>
        <table width="350" border="0" align="center" cellpadding="5" cellspacing="0" class="formstylre">
          <tr> 
            <td class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td class="text"><font color="#FFFFFF"><b>UNSUBSCRIBE</b></font></td>
                  <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td class="text"> <div align="right">
                <table width="349" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" align="center">
                  <CFFORM name="theForm2" action="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_Unsubscribe=1">
                    <tr> 
                      <td width="337"> <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#CC9933" align="center">
                          <tr bgcolor="#FFFFFF"> 
                            <td width="30%" class="bodystyle"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000">Enter 
                              your <br>
                              e-mail address:</font></td>
                            <td width="70%"> <CFINPUT type="text" name="email" size="20" class="formstylre" maxlength="255"
						REQUIRED="YES" MESSAGE="Please enter your e-mail address." VALUE="#ATTRIBUTES.Email#"> 
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
                            <td width="30%" height="2">&nbsp;</td>
                            <td width="70%" height="2"> <input name="Input" type="submit" class="loginbutton" value="Remove Me"></td>
                          </tr>
                        </table></td>
                    </tr>
                  </CFFORM>
                </table>
              </div></td>
          </tr>
        </table>
        
      </td>
    </tr>
	</CFIF>	

	<CFIF ShowSubscribe OR ShowUnsubscribe>
	<tr><td>
        <p> <CFOUTPUT> <a href="#CGI.SCRIPT_NAME#?FuseAction=MemberSignUp">If 
            you would like to become a member, please visit our members area.</a> <font color="0066cc"><strong>&gt;&gt;&gt;</strong></font>
          </CFOUTPUT> </p>
      </td>
    </tr>
	</CFIF>
	
  </table>
