<CFIF NOT Len(ATTRIBUTES.Email) OR NOT isDefined("Sent")>
  <table width="450" border="0" cellpadding="6" cellspacing="0">

	<TR><TD align="left" valign="top">
        <p class="text">Please enter your e-mail address below and your password will be sent to that address</p>
        <br>
        <table width="350" border="0" align="center" cellpadding="5" cellspacing="0" class="formstylre">
<tr> 
            <td width="30" class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td class="text"><font color="#FFFFFF" class="text"><b>Retrieve Password</b></font></td>
                  <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td class="text"><div align="justify"> 
                <table width="350" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" align="center">
<CFFORM name="theForm2" action="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">
                    <tr> 
<td> <table width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#CC9933" align="center">
                          <tr bgcolor="#FFFFFF"> 
<td width="30%"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000"><span class="text">Enter 
                              your e-mail address:</span></font></td>
                            <td width="70%"> <CFINPUT type="text" name="email" size="20" class="formstylre" maxlength="255"
						REQUIRED="YES" MESSAGE="Please enter your e-mail address." VALUE="">
                              
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
<td width="30%" height="2">&nbsp;</td>
                            <td width="70%" height="2"> <INPUT TYPE="SUBMIT" VALUE="Get Password" NAME="Do_#ATTRIBUTES.FuseAction#" SRC="Images/but-getpassword.gif" width="96" height="22" class="formstylreCopy"></td>
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
	
  </table>
</CFIF>