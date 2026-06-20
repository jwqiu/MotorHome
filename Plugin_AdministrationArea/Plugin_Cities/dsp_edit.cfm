<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>Edit A Record</TITLE>
	<CFSAVECONTENT VARIABLE="HTMLHEAD">
		<SCRIPT language="JavaScript" TYPE="text/javascript">
	    <!--
	    	function getFormField(fieldName) {
				return eval('document.forms.theForm.' + fieldName);
			}
	    //-->
	    </SCRIPT>
	</CFSAVECONTENT>
	<CFHTMLHEAD TEXT="#HTMLHEAD#">
</HEAD>

<BODY>
<CFIF Len(ATTRIBUTES.entryErrors) AND IsDefined("ATTRIBUTES.Do_#ATTRIBUTES.FuseAction#")>
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
	<CFSET FormAction = "#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseAction#&#SESSION.URLToken#">
</CFIF>

<CFFORM NAME="theForm" 	ACTION="#FormAction#&Do_#ATTRIBUTES.FuseAction#=1" ENCTYPE="multipart/form-data">

	<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#ATTRIBUTES#
		FUSEACTION="#CFG.PlName#Form" FORMNAME="theForm" />
	
	<CFOUTPUT>
		<INPUT TYPE="SUBMIT" NAME="Do_#ATTRIBUTES.FuseAction#" VALUE="SUBMIT" CLASS="adminButtons">
		<INPUT TYPE="RESET" NAME="RESET" VALUE="RESET" CLASS="adminButtons">
	</CFOUTPUT>
	
	<CFOUTPUT>
		<CFIF Len(CFG.ParentTable.Name)>
			<CFPARAM NAME="ATTRIBUTES.#CFG.ParentTable.LinkField#" DEFAULT="#CFG.pb_null#">
			<CFSET   ParentLink = Evaluate("ATTRIBUTES.#CFG.ParentTable.LinkField#")>
			<INPUT TYPE="HIDDEN" NAME="#CFG.ParentTable.LinkField#" VALUE="#ParentLink#">
		</CFIF>
		
		<INPUT TYPE="HIDDEN" NAME="#CFG.PlTablePrimaryKey#" 
			VALUE="#Evaluate('ATTRIBUTES.' & CFG.PlTablePrimaryKey)#">	
	</CFOUTPUT>
</CFFORM>


<CFIF pb_serviceAvailable("popupEditor")>
	<CFSAVECONTENT VARIABLE="HTMLHEAD">
		<SCRIPT language="Javascript">
		<!--
			function htmlEdit(fieldName) {
				window.open('', 'htmlEditor', 'width=640,height=594');
				document.forms.htmlEditForm.ReturnField.value = 'document.theForm.' + fieldName;
				document.forms.htmlEditForm.HTMLContent.value = document.theForm[fieldName].value;
				document.forms.htmlEditForm.submit();
				return void(0);
			}
		//-->
		</SCRIPT>
	</CFSAVECONTENT>
	<CFHTMLHEAD TEXT="#HTMLHEAD#">

	<CFOUTPUT>
	<FORM NAME="htmlEditForm" ACTION="#CGI.SCRIPT_NAME#?FuseAction=popupEditor"
     METHOD="post" TARGET="htmlEditor">
	 	<INPUT TYPE="HIDDEN" NAME="FuseAction"  VALUE="popupEditor">
		<INPUT TYPE="HIDDEN" NAME="ReturnForm"  VALUE="theForm">
		<INPUT TYPE="HIDDEN" NAME="ReturnField" VALUE="">
		<INPUT TYPE="HIDDEN" NAME="HTMLContent" VALUE="">
	</FORM>
	</CFOUTPUT>
</CFIF>
</BODY>
</HTML>
