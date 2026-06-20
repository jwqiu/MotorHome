<CFIF IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#") AND (NOT IsDefined("ATTRIBUTES.Preview"))>
<P>
	Your newsletter has been sent to <CFOUTPUT>#Q_Members.RecordCount#</CFOUTPUT>
	members of your web site.<BR>
<!---	<CFOUTPUT QUERY="Q_Members">
		#Email#<BR>
	</CFOUTPUT>--->
</P>
<CFELSE>
<CFIF IsDefined("ATTRIBUTES.Preview")>
<P>
	A preview e-mail has been sent to your e-mail address.  You should check your 
	e-mail to ensure that it displays in the way you intend.  The preview e-mail 
	does not make the personalization substitutions.  You may edit the e-mail further
	or click the Send button to send it to your members.
</P>
</CFIF>
<CFIF SESSION["admin"] eq "demo">
	<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=administration">
<CFELSE>
	<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.fuseActioN#=Yes">
</CFIF>

<CFFORM NAME="theForm" 	ACTION="#FormAction#" ENCTYPE="multipart/form-data">

<CFOUTPUT>
<TABLE>
	<TR>
		<TD>Send to:</TD>
		<TD>
			<INPUT TYPE="RADIO" NAME="SendTo" VALUE="Both" #IIf(ATTRIBUTES.SendTo EQ "Both",DE('CHECKED'),DE(''))#>	Everyone
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
		<TD>
			<INPUT TYPE="RADIO" NAME="SendTo" VALUE="Paying" #IIf(ATTRIBUTES.SendTo EQ "Paying",DE('CHECKED'),DE(''))#> Paid members
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
		<TD>
			<INPUT TYPE="RADIO" NAME="SendTo" VALUE="Free" #IIf(ATTRIBUTES.SendTo EQ "Free",DE('CHECKED'),DE(''))#> Free newsletter members
		</TD>
	</TR>
</TABLE>
</CFOUTPUT>

<INPUT TYPE="HIDDEN" NAME="SendToGeneral" VALUE="1">
<!---	<P>

	<TABLE>
	<TR>
			<TD VALIGN="TOP">Send to:</TD>
			<CFOUTPUT>
				<TD VALIGN="TOP"><INPUT TYPE="CHECKBOX" NAME="SendToGeneral" VALUE="1" #IIF(len(ATTRIBUTES.SendToGeneral),DE('Checked'),DE(''))#> General</TD>
			</CFOUTPUT>
		</TR>
		<CFIF isDefined("Q_MailingLists")>
			<CFOUTPUT QUERY="Q_MailingLists">
				<TR>
					<TD>&nbsp;</TD>
					<TD VALIGN="TOP"><INPUT TYPE="CHECKBOX" NAME="SendToLists" VALUE="#MaLiID#" #IIF(listFind("#ATTRIBUTES.SendToLists#","#MaLiID#"),DE('Checked'),DE(''))#> #MaLiName#</TD>
				</TR>	
			</CFOUTPUT>
		</CFIF>
		<CFIF isDefined("Q_MemberGroups")>
			<CFOUTPUT QUERY="Q_MemberGroups">
				<TR>
					<TD>&nbsp;</TD>
					<TD VALIGN="TOP"><INPUT TYPE="CHECKBOX" NAME="SendToGroups" VALUE="#MegrpID#" #IIF(listFind("#ATTRIBUTES.SendToGroups#","#MegrpID#"),DE('Checked'),DE(''))#> #MegrpName#</TD>
				</TR>	
			</CFOUTPUT>
		</CFIF>
	</TABLE>
		
</P>--->

<P>
	A separate e-mail will be sent to each member, and you may use the following codes
	in the body to "personalize" each e-mail (for example to greet a member by using their name)...
</P>
<P>
	<TABLE BORDER="0" WIDTH="50%">
		<TR><TH ALIGN="LEFT">Code</TH><TH>Information</TH></TR>
		<TR><TH ALIGN="LEFT">{{Name}}</TH><TD>Member's Name</TD></TR>
		<TR><TH ALIGN="LEFT">{{email}}</TH><TD>Member's e-mail Address</TD></TR>
		<TR><TH ALIGN="LEFT">{{Unsubscribe}}</TH><TD>Display a link to the unsubscribe page</TD></TR>
	</TABLE>
</P>

<!---
<CFIF (NOT (IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#") OR IsDefined("ATTRIBUTES.Preview"))) AND pb_serviceAvailable("NewsletterTemplatesList")>
<CFSILENT><CFMODULE TEMPLATE="#CFG.TopLevel#" FUSEACTION="newsletterTemplatesQuery" /></CFSILENT>
<CFIF CFMODULE.ATTRIBUTES.Q_ListQuery.RecordCount>
<P>
	To use a pre-designed template as the body of your newsletter, select the desired template 
	<SELECT NAME="Template" onChange="useTemplate(this)">
		<OPTION SELECTED VALUE="">Templates...</OPTION>
		<CFOUTPUT QUERY="CFMODULE.ATTRIBUTES.Q_ListQuery">
		<OPTION VALUE="#HTMLEditFormat(NeTmplTemplate)#">#HTMLEditFOrmat(NeTmplName)#</OPTION>
		</CFOUTPUT>
	</SELECT>
	<SCRIPT>
		function useTemplate(theSelect) {
			if (theSelect.selectedIndex >= 1) {
				if (confirm("Are you sure you wish to replace your current newsletter with this template ?")) {
					soEditor.setHTML(theSelect.options[theSelect.selectedIndex].value);
				}
			}
		}
	</SCRIPT>
</P>
</CFIF>
</CFIF>
--->

<TABLE BORDER="0">
	<TR><TH ALIGN="LEFT">Subject :</TH><TD><CFINPUT TYPE="TEXT" NAME="Subject" VALUE="#ATTRIBUTES.Subject#" REQUIRED="Yes" MESSAGE="You must supply a subject for the e-mail." SIZE="50"></TD></TR>
	<TR>
		<TD COLSPAN="2">
			<CFOUTPUT>
			 	<CFMODULE TEMPLATE="#CFG.TopLevel#" 
					FUSEACTION="soEditor" FIELDNAME="Body" FORMNAME="theForm"
					WIDTH="640" HEIGHT="480" HTMLCONTENT="#ATTRIBUTES.Body#"
				/>
			</CFOUTPUT>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN="2"><CFOUTPUT><INPUT TYPE="SUBMIT" VALUE="Preview" NAME="Preview" CLASS="adminButtons"> <INPUT TYPE="SUBMIT" NAME="Send" VALUE="Send" onClick="return confirm('Are you sure you wish to send this e-mail to the selected mailing lists, if you have not previewed you should do.')" CLASS="adminButtons"></CFOUTPUT></TD>
	</TR>
</TABLE>
</CFFORM>
</CFIF>

<SCRIPT language="Javascript">
	//window.setTimeOut(1000, "window.scrollTo(0,0)");
</SCRIPT>