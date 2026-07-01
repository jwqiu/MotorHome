<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>Page Editor</TITLE>
</HEAD>

<BODY>
<CFIF Len(ATTRIBUTES.entryErrors)>
<P>
	<TABLE WIDTH="95%" BORDER="0" ALIGN="CENTER">
		<TR>
			<TD CLASS="entryErrors">
				Errors were detected in the data you entered, please correct the
				following issues and re-submit.  Nothing has been changed or added
				to the database at this point.
				<UL>
					<CFLOOP INDEX="message" LIST="#ATTRIBUTES.entryErrors#" DELIMITERS=";">
						<LI> <CFOUTPUT>#message#</CFOUTPUT>
					</CFLOOP>
				</UL>
			</TD>
		</TR>
	</TABLE>
</P>
</CFIF>

<CFIF SESSION["admin"] eq "demo">
	<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=administration">
<CFELSE>
	<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&Do_#ATTRIBUTES.FuseAction#=Yes&PageName=#ATTRIBUTES.PageName#&BreadCrumbs=#URLEncodedFormat(ATTRIBUTES.BreadCrumbs)#">
</CFIF>

<CFFORM NAME="theForm" 	ACTION="#FormAction#" ENCTYPE="multipart/form-data">
   <TABLE BORDER="0">
   	<TR><TH ALIGN="LEFT">Page Title :</TH> 
		<TD><CFINPUT TYPE="TEXT" NAME="Title" VALUE="#Title#"></TD>
	</TR>
	<TR><TH ALIGN="LEFT">Title Image :</TH> 
		<TD>
<!---			<CFSELECT QUERY="Q_Heads" NAME="TitleImage" DISPLAY="name" VALUE="name" SELECTED="#TitleImage#"></CFSELECT> --->
			<CFINPUT TYPE="TEXT" NAME="TitleImage" VALUE="#TitleImage#">

			<CFIF pb_serviceAvailable("imageManager")>
				<CFMODULE TEMPLATE="#CFG.TopLevel#"  FUSEACTION="imageManagerFieldButtons" 
				FIELDNAME="TitleImage"			     FORM="theForm"
				DIRECTORY="#CFG.ImagesDirectory#\headers\"   URL="#CFG.ImagesURL#/headers/" />
			</CFIF>
		
		</TD>
	</TR>
	
	<TR>
		<TH ALIGN="LEFT">Layout :</TH>
		<TD>
			<SELECT NAME="Layout">
				<CFLOOP FROM="1" TO="#ArrayLen(CFG.PageEditorLayouts)#" INDEX="i">
					<CFOUTPUT><OPTION VALUE="#CFG.PageEditorLayouts[i].layout#" #IIF(Layout eq CFG.PageEditorLayouts[i].layout, DE('SELECTED'), DE(''))#>#CFG.PageEditorLayouts[i].name#</OPTION></CFOUTPUT>
				</CFLOOP>
				<CFIF isDefined("Q_EditableLayouts")>
					<CFLOOP QUERY="Q_EditableLayouts">
						<CFOUTPUT><OPTION VALUE="#ReplaceNoCase(name,".htm","","ALL")#" #IIF(Layout eq ReplaceNoCase(name,".htm","","ALL"), DE('SELECTED'), DE(''))#>#ReplaceNoCase(name,".htm","","ALL")#</OPTION></CFOUTPUT>
					</CFLOOP>
				</CFIF>
			</SELECT>
		</TD>
	</TR>
	<CFIF pb_ServiceAvailable("MemberGroupsList")>
		<!--- WebMember only --->
		<CFOUTPUT>
		 <TR>
		    <TH ALIGN="LEFT" VALIGN="TOP">Who May View :</TH> 
			<TD>
				<TABLE BORDER="0">
					<TR><TD><INPUT TYPE="RADIO" NAME="MemberOnly" VALUE="N" #IIF(MemberOnly eq "N", DE('CHECKED'), DE(''))#> All users (no login required)</TD></TR>
					<TR><TD><INPUT TYPE="RADIO" NAME="MemberOnly" VALUE="Y" #IIF(MemberOnly eq "Y", DE('CHECKED'), DE(''))#> Only Members</TD></TR>
					<TR>
					<TD VALIGN="TOP"><INPUT TYPE="RADIO" NAME="MemberOnly" VALUE="G" #IIF(MemberOnly eq "G", DE('CHECKED'), DE(''))#> Only Members Of A Selected Group<BR>
						<SMALL>(ctrl-click to select multiple)</SMALL>
					</TD>
					<TD><SELECT NAME="PermittedGroups" MULTIPLE SIZE="3">
							<CFLOOP QUERY="Q_MemberGroups">
								<OPTION VALUE="#Hash(megrpName)#" #IIF(ListFind(PermittedGroups, Hash(megrpName)), DE('SELECTED'), DE(''))#>#megrpName#</OPTION>
							</CFLOOP>
						</SELECT>	</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		</CFOUTPUT>
	</CFIF>
     <TR>
		<TD COLSPAN="2">
			<CFOUTPUT>
			 	<CFMODULE TEMPLATE="#CFG.TopLevel#" 
					FUSEACTION="soEditor" FIELDNAME="FileContent" FORMNAME="theForm"
					WIDTH="640" HEIGHT="480" HTMLCONTENT="#FileContent#"
				/>
			</CFOUTPUT>
		</TD>
	</TR>
   </TABLE>   
  <DIV>
	<INPUT TYPE="SUBMIT" NAME="SUBMIT" VALUE="Save Changes" CLASS="adminButtons">	
  </DIV>  
</CFFORM>
</BODY>
</HTML>

