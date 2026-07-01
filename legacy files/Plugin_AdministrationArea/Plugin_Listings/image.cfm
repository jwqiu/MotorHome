<CFSETTING ENABLECFOUTPUTONLY="Yes">
<!---
	- Image Upload custom tag version 2
	- 2 methods, displayForm and processAction
	-
	- Automatically creates a thumbnail at size 64 for it's own purposes
	- and will accept a list of othersizes to create thumbnails for
	-
	- works in the Attributes scope
	-
	-
	- Arguments :
	- Method = displayForm/processAction
	- FieldName = the name of the field containing the filename
	- ImagePath = the relative path to the images directory (relative to URL)
	- Sizes = additional sizes that file to be stored in (eg "Thumb_120,Medium_240,Large_480")
  --->
  
	<CFPARAM NAME="ATTRIBUTES.Method">

	<CFIF ATTRIBUTES.Method eq "displayForm">
		<CFPARAM NAME="ATTRIBUTES.FieldName">
		
		<!--- Relative path to images directory --->
		<CFPARAM NAME="ATTRIBUTES.ImagePath"> 
		
		<!--- Expects the field to be available in the caller scope --->
		<CFPARAM NAME="CALLER.Value" DEFAULT="">
		<CFSET Filename = Evaluate("CALLER.Value")>
		<CFIF FileExists(ExpandPath("#ATTRIBUTES.ImagePath#/#Filename#"))>
			<CF_ImgSize File="#ExpandPath('#ATTRIBUTES.ImagePath#/#Filename#')#">
		<CFELSE>
			<CFSET WIDth = 0>
			<CFSET Height = 0>
		</CFIF>
		<CFSET WIDth = WIDth + 20>
		<CFSET Height = Height + 20>
		
		<CFOUTPUT>
			<!-- Somebody set us up the #ATTRIBUTES.FieldName# -->
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2">
				<TR>
					<TD ROWSPAN="3" VALIGN="TOP">
						<A HREF="javascript:window.open('#ATTRIBUTES.ImagePath#/#Filename#', 'ImagePopup', 'wIDth=#WIDth#,height=#Height#,dependant=yes,toolbar=no,menubar=no,personalbar=no'); voID(0);"><IMG SRC="#ATTRIBUTES.ImagePath#/imThumbs/_#Filename#" BORDER="0"></A>
					</TD>
					<TD>
						<INPUT TYPE="Radio" VALUE="Upload" 
							   NAME="#ATTRIBUTES.FieldName#_Action">
						<INPUT NAME="#ATTRIBUTES.FieldName#_Upload"
							   TYPE="File"
							   OnClick="this.select()" 
							   OnBlur="this.form.#ATTRIBUTES.FieldName#_Action[0].checked=true;"> 
					</TD>
				</TR>
				<TR><TD><INPUT TYPE="Radio" VALUE="Delete"
							   Name="#ATTRIBUTES.FieldName#_Action"> : Delete</TD></TR>
				<TR><TD><INPUT TYPE="Radio" VALUE="No Change" CHECKED
							   Name="#ATTRIBUTES.FieldName#_Action"> : No Change</TD></TR>
			</TABLE>
			<INPUT TYPE="HIDDEN" NAME="#ATTRIBUTES.FieldName#" 
				   VALUE="#HTMLEditFormat(Filename)#">
			<!-- All Your #ATTRIBUTES.FieldName# Are Belong To Us -->
		</CFOUTPUT>
		
	<CFELSEIF ATTRIBUTES.Method eq "processAction">
		<CFPARAM NAME="ATTRIBUTES.FieldName">
		
		<!--- Relative path to images directory --->
		<CFPARAM NAME="ATTRIBUTES.ImagePath"> 
		<CFSET   SlashPath = ATTRIBUTES.ImagePath>
		<CFIF NOT (Right(ATTRIBUTES.ImagePath,1) eq "/" OR Right(ATTRIBUTES.ImagePath,1) eq "\")>
			<CFSET SlashPath = SlashPath & "/">
		</CFIF> 
		
		<!--- List of more sizes to use, format is
			- Prepend_WIDth,Prepend_WIDth....
			- so that "Thumb_120"
			- will make a filename with "Thumb_" prepended at 120px wIDth
			- maintaining aspect ratio of course
		  --->
		<CFPARAM NAME="ATTRIBUTES.Sizes" DEFAULT="">
		
		<CFSWITCH EXPRESSION="#StructFind(CALLER.ATTRIBUTES, "#ATTRIBUTES.FieldName#_Action")#">
		
		<CFCASE VALUE="Upload">		
			<CFIF Len(Evaluate("FORM.#ATTRIBUTES.FieldName#_Upload"))>
			<!--- First shift the file somewhere we can get it --->
			<CFFILE ACTION="Upload" 
	    		FILEFIELD="#ATTRIBUTES.FieldName#_Upload" 
	    		DESTINATION="#ExpandPath(SlashPath)#"
	    		NAMECONFLICT="MakeUnique">
			
			<!--- Now, rename the file to a unique name --->
			<CFSET UploadedFilename = FILE.ServerFile>
			<CFSET FullUploadedFilename = ExpandPath("#SlashPath##UploadedFilename#")>
			
			<CFSET ServerFilename = "#CreateUUID()#.#FILE.ServerFileExt#">
			<CFSET FullServerFilename = ExpandPath("#SlashPath##ServerFilename#")>
			
			<CFFILE ACTION="RENAME" SOURCE="#FullUploadedFilename#" DESTINATION="#FullServerFilename#">
			
			<!--- Work out if landscape or portrait --->
			<CF_IMGSIZE FILE="#FullServerFilename#">
			<CFIF WIDth GT Height>
				<CFSET ImageFormat = "Landscape">
			<CFELSE>
				<CFSET ImageFormat = "Portrait">
			</CFIF>
			
			<!--- Resize if necessary, max dimension will resize either
				- horizontally (for landscape images), or vertically 
				- (for portrait images) to the given size.
			--->
			<CFPARAM NAME="ATTRIBUTES.HardResize"   DEFAULT="">
			<CFPARAM NAME="ATTRIBUTES.MaxDimension" DEFAULT="">
			
			
			
			<CFIF Len(ATTRIBUTES.MaxDimension)>
			
				<CFIF ImageFormat eq "Landscape">
					<CFIF Len(ATTRIBUTES.HardResize)>
						<CFSET ResizeCommand = "resize #ATTRIBUTES.MaxDimension#">
					<CFELSE>
						<CFSET ResizeCommand = "resizeif #ATTRIBUTES.MaxDimension#,-1,#ATTRIBUTES.MaxDimension#,-1">
					</CFIF>
				<CFELSE>
					<CFIF Len(ATTRIBUTES.HardResize)>
						<CFSET ResizeCommand = "resize -1,#ATTRIBUTES.MaxDimension#">
					<CFELSE>
						<CFSET ResizeCommand = "resizeif -1,#ATTRIBUTES.MaxDimension#,-1,#ATTRIBUTES.MaxDimension#">
					</CFIF>
				</CFIF>
				
					<CFX_IMAGE ACTION="iml" FILE="#FullServerFilename#" 
					COMMENT="All your base are belong to James Sleeman" 
					COMMANDS = "
					setjpegdpi 75
					setjpegsmooth 1
					setjpegquality 95
					#ResizeCommand#
					write #FullServerFilename#
					">
			</CFIF>
			
			<!--- Delete the existing images --->
			<CFSET ExistingFile = 
				ExpandPath("#SlashPath##StructFind(CALLER.Attributes, ATTRIBUTES.FieldName)#")>
			<CFIF FileExists(ExistingFile)>
				<CFFILE ACTION="Delete" FILE="#ExistingFile#">
			</CFIF>
			
			<CFLOOP LIST="imThumbs\_64,#ATTRIBUTES.Sizes#" INDEX="Size">
				<CFSET ExistingFile = 
					ExpandPath("#SlashPath##ListFirst(Size, "_")#_#StructFind(CALLER.Attributes, ATTRIBUTES.FieldName)#")>
				<CFIF FileExists(ExistingFile)>
					<CFFILE ACTION="Delete" FILE="#ExistingFile#">
				</CFIF>
			</CFLOOP>
			
			<!--- Update the caller's attributes to reflect the change --->
			<CFSET CALLER.ATTRIBUTES["#ATTRIBUTES.FieldName#"] = ServerFilename>
			
			<!--- Create other image sizes --->
			<CFLOOP LIST="imThumbs\_64,#ATTRIBUTES.Sizes#" INDEX="Name_Size">
				<CFSET Prepend = ListFirst(Name_Size, "_")>
				<CFSET Size = ListLast(Name_Size, "_")>
				
				<CFIF ImageFormat eq "Landscape">
					<CFIF Len(ATTRIBUTES.HardResize)>
						<CFSET ResizeCommand = "resize #Size#">
					<CFELSE>
						<CFSET ResizeCommand = "resizeif #Size#,-1,#Size#,-1">
					</CFIF>
				<CFELSE>
					<CFIF Len(ATTRIBUTES.HardResize)>
						<CFSET ResizeCommand = "resize -1,#Size#">
					<CFELSE>
						<CFSET ResizeCommand = "resizeif -1,#Size#,-1,#Size#">
					</CFIF>
				</CFIF>

				<CFX_IMAGE ACTION="iml" FILE="#FullServerFilename#" 
				COMMENT="All your base are belong to James Sleeman" 
				COMMANDS = "
				setjpegdpi 75
				setjpegsmooth 1
				setjpegquality 95
				#ResizeCommand#
				write #ExpandPath('#SlashPath##Prepend#_#ServerFilename#')#
				">
			</CFLOOP>
		</CFIF>
		</CFCASE>
		<CFCASE VALUE="Delete">
			<!--- Delete the existing images --->
			<CFSET ExistingFile = 
				ExpandPath("#SlashPath##StructFind(CALLER.Attributes, ATTRIBUTES.FieldName)#")>
			<CFIF FileExists(ExistingFile)>
				<CFFILE ACTION="Delete" FILE="#ExistingFile#">
			</CFIF>
			
			<CFLOOP LIST="imThumbs\_64,#ATTRIBUTES.Sizes#" INDEX="Size">
				<CFSET ExistingFile = 
					ExpandPath("#SlashPath##ListFirst(Size, "_")#_#StructFind(CALLER.Attributes, ATTRIBUTES.FieldName)#")>
				<CFIF FileExists(ExistingFile)>
					<CFFILE ACTION="Delete" FILE="#ExistingFile#">
				</CFIF>
			</CFLOOP>
			
			<!--- Update the caller's attributes to reflect the change --->
			<CFSET CALLER.ATTRIBUTES["#ATTRIBUTES.FieldName#"] = "">
			
		</CFCASE>
		</CFSWITCH>
	</CFIF>	

<CFSETTING ENABLECFOUTPUTONLY="No">



















































