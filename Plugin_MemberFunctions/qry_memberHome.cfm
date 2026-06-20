<!--- Members only --->
<CFIF NOT Len(SESSION.SecurityEmail) and NOT Len(SESSION.SecurityPassword)>
	<CFLOCATION URL="#CGI.SCRIPT_NAME#?FuseAction=MemberLogin&RFA=#URLEncodedFormat(REQUEST.Back)#">
</CFIF>
