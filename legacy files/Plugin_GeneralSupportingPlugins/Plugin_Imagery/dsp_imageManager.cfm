<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Image Manager</title>
	<CFOUTPUT>
		<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	    <!--
			<CFIF Len(ATTRIBUTES.saveFunction)>
	    	function useImage(imageURL) {
				window.opener.#ATTRIBUTES.saveFunction#(imageURL);
				window.close();
			}
			</CFIF>
			
			function cancel(imageURL) {
				window.close();
			}
	
			function showImage(aPath, imageURL) {
				thumbPane.document.location = '#CGI.SCRIPT_NAME#?FuseAction=imager&ImageURL=' + escape(imageURL)
					 + '&#SESSION.URLToken#';
				urlPane.document.location = '#CGI.SCRIPT_NAME#?FuseAction=imageManagerURLPane&URL=' + escape(imageURL) + '&Path=' + escape(aPath) + '&#SESSION.URLToken#';
			}
			
			function showThumbs(aPath,aURL) {
				thumbPane.document.location = 
					'#CGI.SCRIPT_NAME#?FuseAction=imageManagerThumbView&URL=' + escape(aURL) + '&Path=' + escape(aPath) + '&#SESSION.URLToken#';
				urlPane.document.location = '#CGI.SCRIPT_NAME#?FuseAction=imageManagerURLPane&URL=' + escape(aURL) + '&Path=' + escape(aPath) + '&#SESSION.URLToken#';
			}
		//-->
		</SCRIPT>
	</CFOUTPUT>
</head>
<!--- <FRAMESET COLS="250,*">
<CFOUTPUT>
<FRAME NAME="directoryPane" SCROLLING="NO" NORESIZE  SRC="#CGI.SCRIPT_NAME#?FuseAction=imageManagerTree&RootPath=#URLEncodedFormat(ATTRIBUTES.RootPath)#&RootURL=#URLEncodedFormat(ATTRIBUTES.RootURL)#&#SESSION.URLToken#"/>
	<FRAMESET ROWS="*,60">
		<FRAME NAME="thumbPane" SCROLLING="Yes" SRC="#CGI.SCRIPT_NAME#?FuseAction=imageManagerThumbView&Path=#URLEncodedFormat(ATTRIBUTES.RootPath)#&URL=#URLEncodedFormat(ATTRIBUTES.RootURL)#&#SESSION.URLToken#" />
<FRAME NAME="urlPane" SCROLLING="No" FRAMEBORDER="0" SRC="#CGI.SCRIPT_NAME#?FuseAction=imageManagerURLPane&Path=#URLEncodedFormat(ATTRIBUTES.RootPath)#&URL=#URLEncodedFormat(ATTRIBUTES.RootURL)#&#SESSION.URLToken#">
	</FRAMESET>
	
	</CFOUTPUT>
</FRAMESET> --->
<CFOUTPUT>
<FRAMESET ROWS="*,60">
		<FRAME NAME="thumbPane" SCROLLING="Yes" SRC="#CGI.SCRIPT_NAME#?FuseAction=imageManagerThumbView&Path=#URLEncodedFormat(ATTRIBUTES.RootPath)#&URL=#URLEncodedFormat(ATTRIBUTES.RootURL)#&#SESSION.URLToken#" />
<FRAME NAME="urlPane" SCROLLING="No" FRAMEBORDER="0" SRC="#CGI.SCRIPT_NAME#?FuseAction=imageManagerURLPane&Path=#URLEncodedFormat(ATTRIBUTES.RootPath)#&URL=#URLEncodedFormat(ATTRIBUTES.RootURL)#&#SESSION.URLToken#">
	</FRAMESET>
</CFOUTPUT>
<NOFRAMES>
<body>
	Sorry, in order to use the image manager you must have a frames capable web 
	browser such as Mozilla (Netscape), Opera or Internet Explorer.
</body>
</NOFRAMES>
</html>
