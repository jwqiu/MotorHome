<link href="../styles.css" rel="stylesheet" type="text/css"> <CFIF isDefined("Do_#ATTRIBUTES.FuseAction#")> 
<CFELSE>
<CFFORM NAME="theForm" ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#">
  <p><strong>We hope that you enjoyed visiting <SPAN CLASS="mhe">MotorhomeExchange-Sell.com</SPAN>. 
    To receive further information via e-mail, please complete the following</strong>: 
  </p>
    <div align="left"></div>
    <table border="0" cellpadding="5" cellspacing="0" class="formstylre">
      <tr> 
        <td class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td class="text"><strong><font color="#FFFFFF">CONTACT US</font></strong></td>
              <td width="20"><strong><img src="Images/pencil.gif" width="20" height="20"></strong></td>
            </tr>
          </table></td>
      </tr>
      <tr> 
        <td class="text"> <div align="center"></div>
          <table border="0" width="350" cellspacing="0" cellpadding="4" bgcolor="#ffffff">
            <tr> 
              <td> <table border="0" width="350" cellspacing="0" cellpadding="4">
                  <tr > 
                    <td width="25%" valign="top" height="25" class="text" align="right">Name:</td>
                    <td valign="top" height="25"> <CFINPUT type="text" name="Name" size="33" Required="Yes" Message="Please enter your name" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="text" align="right">Address:</td>
                    <td valign="top" height="25"> <input type="text" name="Address1" size="25" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="Bodytext" align="right">&nbsp;</td>
                    <td valign="top" height="25"> <input type="text" name="Address2" size="25" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="Bodytext" align="right">&nbsp;</td>
                    <td valign="top" height="25"> <input type="text" name="Address3" size="25" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="text" align="right">Country:</td>
                    <td valign="top" height="25"> <input type="text" name="Country" size="25" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="text" align="right">Phone:</td>
                    <td valign="top" height="25"> <input type="text" name="Phone" size="14" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="text" align="right">Fax:</td>
                    <td valign="top" height="25"> <input type="text" name="Fax" size="14" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="text" align="right">E-mail:</td>
                    <td valign="top" height="25"> <CFINPUT type="text" name="Email" size="33" required="Yes" Message="Please enter your e-mail address" class="formstylre"> 
                    </td>
                  </tr>
                  <tr> 
                    <td width="25%" valign="top" height="25" class="text" align="right">Comments:</td>
                    <td valign="top" height="25"> <textarea rows="4" name="Comments" cols="28" class="formstylre"></textarea> 
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="2" valign="top" align="center"> <div align="center"> 
                        <p><img src="images/holder.gif" width="10" height="15"><br>
                          <CFOUTPUT> 
                            <input type="submit" name="Do_#ATTRIBUTES.FuseAction#" value="Submit" class="loginbutton">
                          </CFOUTPUT> </p>
                      </div></td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
    </table>
    </CFFORM>
</CFIF>