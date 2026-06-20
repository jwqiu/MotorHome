<!--- Write out some javascript to alow selection of images 
	- from a drop-down list --->
<CFOUTPUT>
	<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
		
		function selectImage(imageFile) {
			ImgSrc.value = "#JSStringFormat(ATTRIBUTES.ImagesURL)#/" + imageFile;
			changePreview();
		}
		function saveImageFromManager(imageURL) {
			ImgSrc.value = imageURL;
			changePreview();
		}
	//-->
	</SCRIPT>
</CFOUTPUT>
<TABLE  BORDER="0" WIDTH="468"> 
	<TR><TD>
<FIELDSET Style="padding:5px;">
	<LegEND>Select Image</LegEND>
	<SELECT NAME="SelectImage" STYLE="width:340px" OnChange="selectImage(this.options[this.options.selectedIndex].value)">
		<CFOUTPUT QUERY="Q_Images">
			<OPTION VALUE="#Name#">#HTMLEditFormat(Name)#</OPTION>
		</CFOUTPUT>
	</SELECT>
	<CFOUTPUT>
  <CFIF pb_serviceAvailable("imageManager")>
  <input type="button" name="Upload" value="Browse"  OnClick="window.open('#CGI.SCRIPT_NAME#?FuseAction=imageManager&RootPath=#URLEncodedFormat(ATTRIBUTES.ImagesDirectory & '\')#&RootURL=#URLEncodedFormat(ATTRIBUTES.ImagesURL & '/')#&SaveFunction=saveImageFromManager&#SESSION.URLToken#', 'imageManager_soEditor', 'width=590,height=320,resizeable=yes');" class="button">
  <CFELSE>
  <input type="button" name="Upload" value="Upload"  OnClick="document.location='#CGI.SCRIPT_NAME#?FuseAction=soEditorImageUpload&#SESSION.URLToken#'" class="button">
  </CFIF>
  </CFOUTPUT>
</FIELDSET></TD></TR>
</TABLE> 
<!---
	- BEWARE ! 
	-   the soeditor image manager may cause a request to be sent to your
	-   index.cfm page with no fuseaction supplied (it's actually requesting
	-   a null image), if your default fuseaction is not provided by your application
	-   then this will induce several service resets, which will mean a very long
	-   wait and possibly timeouts.  
	-
	-   In short, make sure that http://your.site/index.cfm does something
	- 	appropriate (not "Unknown Fuseaction") with no attributes before using
	-   the soEditor --->
<CFINCLUDE TEMPLATE="siteobjects/soeditor/lite/image.cfm">
