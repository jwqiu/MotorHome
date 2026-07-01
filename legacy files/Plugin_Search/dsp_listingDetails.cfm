<CFOUTPUT QUERY="Q_Details">
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="formstylre">
  <tr> 
    <td colspan="2" class="formtitle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
            <td class="text"><strong> 
              <!--- Display listing type 
				- e.g. Exchange, Sell, etc... --->
              <font color="##FFFFFF"> 
<CFSET Found=0>
              <CFIF LiExchange EQ 1>
                <CFIF Found>
                  , 
                </CFIF>
                EXCHANGE 
                <CFSET Found=1>
              </CFIF>
              <CFIF LiRent EQ 1>
                <CFIF Found>
                  , 
                </CFIF>
                RENT 
                <CFSET Found=1>
              </CFIF>
              <CFIF LiSell EQ 1>
                <CFIF Found>
                  , 
                </CFIF>
              </CFIF>
              <CFIF LiSell EQ 1>
                <CFIF Found>
                </CFIF>
                SELL 
                <CFSET Found=1>
              </CFIF>
              <CFIF LiWantedToBuy EQ 1>
                <CFIF Found>
                  , 
                </CFIF>
              </CFIF>
              <CFIF LiWantedToBuy EQ 1>
                <CFIF Found>
                </CFIF>
                WANTED-TO-BUY 
                <CFSET Found=1>
              </CFIF>
              <CFIF LiWantedToRent EQ 1>
                <CFIF Found>
                  , 
                </CFIF>
              </CFIF>
              <CFIF LiWantedToRent EQ 1>
                <CFIF Found>
                </CFIF>
                WANTED-TO-REN
              </CFIF>
              </font>
              <CFIF LiWantedToRent EQ 1>
                <font color="##FFFFFF"></font><font color="##FFFFFF">T 
                <CFSET Found=1>
                </font> 
</CFIF>
              - <font color="##FFFFFF">#HTMLEditFormat(UCase("#LiMakeAndModel# #LiYear#"))#</font></strong></td>
		  <td width="120" colspan="2" align="right"><img src="Images/#VeTyName#list.gif" height="27"></td>	
<!---          <td width="100" class="text"> <div align="right">#UCase(VeTyName)#</div></td>
          <td width="20"><strong><img src="Images/vehicle.gif" width="20" height="20"></strong></td>
--->		  
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="left" valign="top" class="borderlocation"><div align="center"></div></td>
    <td align="left" valign="top" class="textCopy"> 
	
		<!--- Images... --->
		<CFIF Len(LiPhoto1) OR Len(LiPhoto2)>
		   <table width="200" border="0" align="center" cellpadding="4" cellspacing="0">
			<tr>
				<CFIF Len(LiPhoto1)>
		          <td>
				  	<div align="center"><strong>
						<CF_IMGSIZE FILE="#ExpandPath('Content/images/Listings/#LiPhoto1#')#">
						<a href="##" onMouseDown="window.open('Content/images/Listings/#LiPhoto1#','Photo','width=#Evaluate(WIDTH+30)#,height=#Evaluate(HEIGHT+30)#')"><img src="#CGI.SCRIPT_NAME#?FuseAction=Imager&ImageURL=#URLEncodedFormat('#CFG.AbsoluteWebURL#/Content/images/Listings/#LiPhoto1#')#&MaxDimension=100" alt="image of vehicle" name="image" border="1" id="image" style="background-color: ##999999"></a>
				  	</strong></div>
				  </td>
		 	    </CFIF>
				<CFIF Len(LiPhoto2)>
		          <td>
				  	<div align="center"><strong>
						<CF_IMGSIZE FILE="#ExpandPath('Content/images/Listings/#LiPhoto2#')#">
						<a href="##" onMouseDown="window.open('Content/images/Listings/#LiPhoto2#','Photo','width=#Evaluate(WIDTH+30)#,height=#Evaluate(HEIGHT+30)#')"><img src="#CGI.SCRIPT_NAME#?FuseAction=Imager&ImageURL=#URLEncodedFormat('#CFG.AbsoluteWebURL#/Content/images/Listings/#LiPhoto2#')#&MaxDimension=100" alt="image of vehicle" name="image" border="1" id="image" style="background-color: ##999999"></a>
			  	  	</strong></div>
				  </td>
			  	</CFIF>
	        </tr>
    	    <tr>
				<CFIF Len(LiPhoto1)>
	          		<td><div align="center"><font size="1" face="Arial, Helvetica, sans-serif">Click image to view larger</font></div></td>
				</CFIF>
				<CFIF Len(LiPhoto2)>
					<td><div align="center"><font size="1" face="Arial, Helvetica, sans-serif">Click image to view larger</font></div></td>
   			    </CFIF>
	        </tr>
	      </table>
		
		</CFIF>
	<BR>
      <p><strong> THE VEHICLE</strong><br>
        <br>

		<CFIF Len(LiLongDescription)><strong><img src="Images/bullet.gif" width="10" height="10">
			#HTMLEditFormat(UCase(LiMakeAndModel))# #LiYear# 
			<CFIF LiSold EQ 1>
				&nbsp;<IMG SRC="Images/sold.gif" WIDTH="45" HEIGHT="15" ALT="Sold">
			</CFIF>

			</strong><br>
			#Replace(HTMLEditFormat(LiLongDescription),"#Chr(10)#","<BR>","ALL")#<br><br>
		</CFIF>

		<CFIF Len(LiPrice)><strong><img src="Images/bullet.gif" width="10" height="10">
			THE PRICE</strong><br>
			#Replace(HTMLEditFormat(LiPrice),"#Chr(10)#","<BR>","ALL")#<br><br>
		</CFIF>
		
		<CFIF Len(LiAreaDescription)><strong><img src="Images/bullet.gif" width="10" height="10">
			THE AREA</strong><br>
			#Replace(HTMLEditFormat(LiAreaDescription),"#Chr(10)#","<BR>","ALL")#<br><br>
		</CFIF>
				
		<CFIF Len(LiWhereWantToGo)><strong><img src="Images/bullet.gif" width="10" height="10">
			THE DESTINATION</strong><br>
			#Replace(HTMLEditFormat(LiWhereWantToGo),"#Chr(10)#","<BR>","ALL")#<br><br>
		</CFIF>

		<CFIF (LiExchange EQ 1) OR (LiRent EQ 1)>
		<CFIF Len(LiFromDate) AND Len(LiToDate)><strong><img src="Images/bullet.gif" width="10" height="10">
			THE DATES</strong><br>
			#DateFormat(LiFromDate,"d mmmm yyyy")# - #DateFormat(LiToDate,"d mmmm yyyy")#<BR><BR>
		</CFIF>
		</CFIF>
		
<!---		
        <strong><img src="Images/bullet.gif" width="10" height="10"> THE DATES<br>
        </strong>October 2002- Feburary 2003.<br>
        <br>
--->		

		<CFIF Len(LiProfession) OR Len(LiInterests) OR Len(LiAgeRange) OR Len(LiOther)><strong><img src="Images/bullet.gif" width="10" height="10">
			THE PEOPLE</strong><br>
			<CFIF Len(LiProfession)>
				#Replace(HTMLEditFormat(LiProfession),"#Chr(10)#","<BR>","ALL")#<br>
			</CFIF>
			<CFIF Len(LiInterests)>
				#Replace(HTMLEditFormat(LiInterests),"#Chr(10)#","<BR>","ALL")#<br>
			</CFIF>
			<CFIF Len(LiAgeRange)>
				#Replace(HTMLEditFormat(LiAgeRange),"#Chr(10)#","<BR>","ALL")#<br>
			</CFIF>
			<CFIF Len(LiOther)>
				#Replace(HTMLEditFormat(LiOther),"#Chr(10)#","<BR>","ALL")#<br>
			</CFIF>
			<BR>
		</CFIF>
		
      <table border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><A HREF="#CGI.SCRIPT_NAME#?FuseAction=Return"><img border="0" src="Images/arrow.gif" width="20" height="20"></A></td>
          <td class="text"><strong><A HREF="#CGI.SCRIPT_NAME#?FuseAction=Return" style="text-decoration: none">return to listings</A></strong></td>
        </tr>
      </table>
      <br> </td>
  </tr>
  <tr bgcolor="##CCCCCC"> 
    <td align="left" valign="top" class="borderlocation">&nbsp;</td>
    <td align="left" valign="top" class="formtitleCopy"> 
      <table border="0" cellspacing="0" cellpadding="0">
		<tr>
          <td><img src="Images/envelope.gif"></td>
          <td class="text"><strong>send enquiry</strong></td>
        </tr>
      </table> 
    </td>
  </tr>
  <tr>
    <td align="left" valign="top" class="borderlocation">&nbsp;</td>
    <td align="left" valign="top" class="textCopy"><CFFORM name="theForm" action="#CGI.SCRIPT_NAME#?FuseAction=SendEnquiry">
		<INPUT TYPE="HIDDEN" NAME="LiID" VALUE="#LiID#">
        <table width="450" border="0" cellspacing="0" cellpadding="5">
          <tr align="left" valign="top"> 
            <td class="text"><div align="right"><strong>Your Name</strong></div></td>
            <td>
				<CFIF isDefined("SESSION.SecurityName")>
					<CFINPUT name="name" type="text" class="formstylre" value="#SESSION.SecurityName#" required="yes" message="Please enter your name">
				<CFELSE>
					<CFINPUT name="name" type="text" class="formstylre" required="yes" message="Please enter your name">
				</CFIF>
			</td>
          </tr>
          <tr align="left" valign="top"> 
            <td class="text"><div align="left"> 
                <p align="right"><strong>Your e-mail Address</strong>.<br>
                  Please ensure your e-mail address is correct</p>
              </div></td>
            <td>
				<CFIF isDefined("SESSION.SecurityEmail")>
					<CFINPUT name="email" type="text" class="formstylre" value="#SESSION.SecurityEmail#" required="yes" message="Please enter your e-mail address">
				<CFELSE>
					<CFINPUT name="email" type="text" class="formstylre" required="yes" message="Please enter your e-mail address">
				</CFIF>
			</td>
          </tr>
          <tr align="left" valign="top"> 
            <td class="text"><div align="right"><strong>Subject<br>
                </strong>The text you enter will be the subject of the e-mail message 
                you send to the owner of this listing</div></td>
            <td> <CFINPUT name="subject" type="text" class="formstylre" size="40" required="Yes" message="Please enter a subject" value=""></td>
          </tr>
          <tr align="left" valign="top"> 
            <td class="text"><div align="right"><strong>Message<br>
                </strong>This message will be e-mailed directly to the owner of 
                the above listing. Please describe your motorhome or other vehicle. 
                Discuss your travel plans/renting/buying/selling information in 
                this e-mail message. Please include your contact information including 
                your phone number. Remember that first impressions count. Take 
                your time and remember to sound friendly.</div></td>
            <td> <textarea name="body" cols="40" rows="9" class="formstylre"></textarea></td>
          </tr>
          <tr align="left" valign="top">
            <td class="text">&nbsp;</td>
            <td> 
              <input name="Submit2" type="submit" class="formstylre" value="Send">
              <input name="Reset" type="reset" class="formstylre" value="Reset Form"></td>
          </tr>
        </table>
      </CFFORM></td>
  </tr>
</table>
</CFOUTPUT>