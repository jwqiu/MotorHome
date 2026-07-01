<html>
<head><title>soEditor - Image</title>
<style>
  body, .button, fieldset{background: #d4d0c8;font: 8pt/8pt Tahoma;margin:0px;}
  input {font: 8pt/8pt Tahoma;}
</style>
</head>

<body scroll="no">
<CFFORM  ACTION="#CGI.SCRIPT_NAME#?FuseAction=#ATTRIBUTES.FuseActioN#" METHOD="POST" ENCTYPE="multipart/form-data">
<table>
<tr><td>
<fieldset style="padding:5px;"><legend>Upload Image To Server</legend>
Click browse to locate the file to upload, then press the upload button, the file
will be uploaded (this may take a while) and you will be returned to the image 
selection.
<P>
<CFOUTPUT>
	<INPUT TYPE="FILE" NAME="ImageToUpload">
	<INPUT TYPE="HIDDEN" NAME="Do_#ATTRIBUTES.FuseAction#" VALUE="Yes">
	
</CFOUTPUT>

</fieldset>
</td>
</tr>
<tr>
<td align="right">
<table>
<tr><td><INPUT TYPE="SUBMIT" CLASS="button" NAME="UPLOAD" VALUE="Upload"></td>
<td><input class="button" type="button" value="  Cancel  " onclick="history.back();"></td></tr>
</table>
</td>
</tr>
</table>
</CFFORM>
</body>
</html>
