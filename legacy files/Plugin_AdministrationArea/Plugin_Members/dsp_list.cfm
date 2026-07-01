<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>#CFG.PlPlural#</TITLE>
</HEAD>

<BODY>

<CFOUTPUT>
<TABLE WIDTH="100%" ALIGN="CENTER" BORDER="0" CELLSPACING="0" CELLPADDING="2">
	
	<TR>
		<!--- button for adding a new record --->
		<FORM ACTION="#CGI.SCRIPT_NAME#?#SESSION.URLToken#" METHOD="POST">
			<INPUT TYPE="HIDDEN" NAME="FuseAction" VALUE="#CFG.PlName#New">
			<INPUT TYPE="HIDDEN" NAME="BreadCrumbs" VALUE="#HTMLEditFormat(ATTRIBUTES.BreadCrumbs)# : &lt;A HREF=&quot;#REQUEST.Back#&quot;&gt;#CFG.PlPlural#&lt;/A&gt;">
			<INPUT TYPE="HIDDEN" NAME="RFA" VALUE="#HTMLEditFormat(REQUEST.BACK & '&' & SESSION.URLToken)#">
		<TD ALIGN="LEFT">
		<CFIF Len(CFG.ParentTable.Name)>
				<INPUT TYPE="HIDDEN" NAME="#CFG.ParentTable.LinkField#"
					VALUE="#HTMLEditFormat(ParentLink)#">
				<INPUT TYPE="SUBMIT" NAME="SubmitButton" 
					VALUE="New #CFG.PlSingular#" CLASS="adminButtons">
		<CFELSE>
				<INPUT TYPE="SUBMIT" NAME="SubmitButton" 
					VALUE="New #CFG.PlSingular#" CLASS="adminButtons">
		</CFIF>
		</TD>
		</FORM>
		
		<!--- Search Options Selector --->
		<CFFORM ACTION="#REQUEST.Back#&#SESSION.URLToken#&CurrentPage=1">
			<TD ALIGN="RIGHT">
				<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
				<TR><TD>
				<TABLE WIDTH="100%"  CELLPADDING="0" CELLSPACING="0" BORDER="0">
					<TR><TD ALIGN="LEFT">Search :</TD><TD ALIGN="RIGHT"><CFINPUT SIZE="10" TYPE="TEXT" VALUE="#ATTRIBUTES.SearchKeyword#" NAME="SearchKeyword"></TD></TR>
				</TABLE>
				</TD></TR>
				<TR><TD>
				<TABLE WIDTH="100%"  CELLPADDING="0" CELLSPACING="0" BORDER="0">
					<TR><TD ALIGN="LEFT"><CFSELECT NAME="RowsPerPage" PASSTHROUGH="OnChange='this.form.submit()'">
					<OPTION VALUE="#ATTRIBUTES.RowsPerPage#">#ATTRIBUTES.RowsPerPage# Rows/Page</OPTION>
					<OPTION>10</OPTION>
					<OPTION>25</OPTION>
					<OPTION>50</OPTION>
					<OPTION>100</OPTION>
					<OPTION VALUE="#Q_ListQuery.RecordCount#">#Q_ListQuery.RecordCount#</OPTION>
				</CFSELECT></TD><TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" VALUE="GO" NAME="Go"  CLASS="adminButtons"></TD></TR>
				</TABLE>
				</TD></TR>
				</TABLE>				
			</TD>
		</CFFORM>
	</TR>
</TABLE>
</CFOUTPUT>

<CFIF Q_ListQuery.RecordCount>
	<TABLE WIDTH="100%" ALIGN="CENTER" BORDER="0" CELLSPACING="0" CELLPADDING="2">
		<CFOUTPUT QUERY="Q_ListQuery" STARTROW="#IM_STARTROW#" MAXROWS="#IM_MAXROW#">
			<FORM>
			<TR CLASS="#IIF(CurrentRow mod 2, DE('evenRow'), DE('oddRow'))#">
			<CFSET Crumbs = "">
			<CFLOOP LIST="#CFG.PlDisplayFields#" INDEX="Field">
			<CFSET Crumbs = ListAppend(Crumbs, Evaluate(Field), ", ")>
			<CFIF Trim(Field) EQ "MeActivate">
				<TD ALIGN="LEFT" VALIGN="TOP">
					<CFIF Evaluate(Field) EQ 1>
						Paid
					<CFELSE>
						&nbsp;
					</CFIF>
				</TD>
			<CFELSE>
				<TD ALIGN="LEFT" VALIGN="TOP">#HTMLEditFormat(Evaluate(Field))#</TD>
			</CFIF>
			</CFLOOP>
			<CFSET Crumbs = ATTRIBUTES.BreadCrumbs & " : <A HREF=""#REQUEST.BACK#"">" & HTMLEditFormat(Crumbs) & "</A>">
			  <TD ALIGN="RIGHT" VALIGN="BOTTOM">
				<SELECT NAME="jumperSelect" onChange="jumper(this)">
					<OPTION VALUE="##">Manage</OPTION>
					<OPTION VALUE="#CGI.SCRIPT_NAME#?FuseAction=#CFG.PlName#Edit&#CFG.PlTablePrimaryKey#=#Evaluate(CFG.PlTablePrimaryKey)#&BreadCrumbs=#URLEncodedFormat(Crumbs)#&RFA=#REQUEST.Back#&#SESSION.URLToken#">View/Edit Detail</OPTION>
					<CFSET ParentKey = Evaluate(CFG.PlTablePrimaryKey)>
					<CFLOOP QUERY="CFG.ChildPlugins">
						<OPTION VALUE="#CGI.SCRIPT_NAME#?FuseAction=#ChildName#List&#LinkField#=#ParentKey#&BreadCrumbs=#URLEncodedFormat(Crumbs)#&#SESSION.URLToken#">#Plural#</OPTION>
					</CFLOOP>
					<CFIF SESSION["admin"] eq "demo">
						<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=administration">
					<CFELSE>
						<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=#CFG.PlName#Delete&#CFG.PlTablePrimaryKey#=#Evaluate(CFG.PlTablePrimaryKey)#&RFA=#REQUEST.Back#&#SESSION.URLToken#">
					</CFIF>
					<OPTION STYLE="background-color:red; color:white" VALUE="javascript:confirmDelete('#FormAction#')">Delete</OPTION>
				</SELECT>
			  </TD>
		    </TR>
			</FORM>
		</CFOUTPUT>
	</TABLE>
</CFIF>

<!--- Next, Previous & Page Number Links --->
<DIV ALIGN="CENTER"><CFOUTPUT>#IM_PAGETHRU#</CFOUTPUT></DIV>

<!--- Supporting Javascript Functions --->
<CFOUTPUT>
<SCRIPT language="Javascript">
<!--
	function confirmDelete(URL) {
		if ( confirm("Are you sure you want to delete this record ?") ) {
			document.location=URL;
		}
	}
	
	function jumper(selectList) {
		urlAppend = selectList.options[selectList.selectedIndex].value;
		selectList.form.reset();
		document.location = urlAppend;
	}
//-->
</SCRIPT>
</CFOUTPUT>

</BODY>
</HTML>
