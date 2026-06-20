<CFSILENT>
	<!--- Contact Details --->
	<CFPARAM NAME="FORM.Name" DEFAULT="">
	<CFPARAM NAME="FORM.Email" DEFAULT="">
	<CFPARAM NAME="FORM.Comments" DEFAULT="">
	
	<!--- error Details --->
	<CFPARAM NAME="FORM.DateTime" DEFAULT="">
	<CFPARAM NAME="FORM.RemoteAddress" DEFAULT="">
	<CFPARAM NAME="FORM.MailTo"   DEFAULT="">
	
<!--- Send Email --->
<CFMAIL SUBJECT="error Occurred On #CGI.SERVER_NAME#" 
		FROM="errors@#CGI.SERVER_NAME#" TO="#FORM.MailTo#">
User Contributed Bug Report

Date/Time              : #FORM.DateTime#
Remote IP              : #FORM.RemoteAddress#
User's Name            : #FORM.Name#
User's email Address   : #FORM.email#

Description Of Actions :
------------------------
#FORM.Comments#
</CFMAIL>
<CFLOCATION URL="/" ADDTOKEN="No">
</CFSILENT>






















































