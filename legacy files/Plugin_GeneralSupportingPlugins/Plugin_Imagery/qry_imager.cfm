
	<CFPARAM NAME="ATTRIBUTES.ImageURL">
	
	<!--- If the url is relative, make it absolute --->
	<CFIF NOT ReFindNoCase("^http", ATTRIBUTES.ImageURL)>
		<CFSET ATTRIBUTES.ImageURL = CFG.AbsoluteWebURL & "/" & ATTRIBUTES.ImageURL>
	</CFIF>
	
	<!--- If no size change is requested, just pass off to the image --->
	<CFIF NOT IsDefined("ATTRIBUTES.MaxDimension") OR Not Len(ATTRIBUTES.MaxDimension)>
		<CFLOCATION URL="#ATTRIBUTES.ImageURL#" ADDTOKEN="No">
	</CFIF>
	
	<!--- Hash the name and size togethor to get a resized filename --->
	<CFSET hashName = Hash(ATTRIBUTES.ImageURL & ";" & ATTRIBUTES.MaxDimension) & "." & ListLast(ATTRIBUTES.ImageURL, ".")>
	
	<!--- If the hashName exists in our _sysImages directory, check if it's 
		newer than the image stored on the server. If so, just use that. --->
	<CFIF FileExists(CFG.OurDirectory & "\images\_sysImages\#hashName#")>
	
		<CFIF isDefined("CFG.CheckLastModifiedDate") and lcase("#CFG.CheckLastModifiedDate#") eq "yes">
	
			<CFX_HTTP URL="#ATTRIBUTES.ImageURL#" USERAGENT="BigDaddy/1.0" VERB="HEAD" TIMEOUT="10">
		
			<CFDIRECTORY ACTION="LIST" NAME="Q_Dir" FILTER="#hashName#"	DIRECTORY="#CFG.OurDirectory#\images\_sysImages\">
	
			<CFLOOP QUERY="Q_Dir">
				<CFIF UCase(NAME) eq UCase(#hashName#)>
					<CFOUTPUT>
						<CFSET StoredFileDate="#ParseDateTime(DateLastModified)#">
						<CFSET raw="#DateLastModified#">
					</CFOUTPUT>
				</CFIF>
			</CFLOOP>
			
			<!--- Date is returned by CFX_HTTP.Header like this:  
				- "Fri, 12 Apr 2002 00:34:28" 
				- Convert it do something useable by reordering to
				- "8:30:00 Jan. 25, 1999" format and then running it
				- thru LSParseDateTime
				--->
			<CFSET RemoteFileDate=Mid(#CFX_HTTP.Headers#,15+FindNoCase("Last-Modified:",#CFX_HTTP.Headers#,1),len(CFX_HTTP.Headers))>
			<CFSET RemoteFileDate=Mid(RemoteFileDate,1,Find("GMT#chr(13)##chr(10)#",RemoteFileDate)-2)>
			<CFSET rawRemote=RemoteFileDate>
			<CFSET RemoteFileDate=
					ListGetAt("#RemoteFileDate#",5," ")&" "&
					ListGetAt("#RemoteFileDate#",3," ")&". "&
					ListGetAt("#RemoteFileDate#",2," ")&", "&
					ListGetAt("#RemoteFileDate#",4," ")
			>
			<CFSET RemoteFileDate=LSParseDateTime("#RemoteFileDate#")>
			<CFSET TimeZoneInfo=GetTimeZoneInfo()>
			<!--- Correct date for our timezone --->
			<CFSET RemoteFileDate=DateAdd("h",-TimeZoneInfo.UTCHourOffset,RemoteFileDate)>
			<!--- Make the remote file appear newer to account for
				- differences in server times ---->
			<CFSET RemoteFileDate=DateAdd("n",#CFG.TimeDifference#,RemoteFileDate)>
			
<!---
			<CFOUTPUT>
				<CFDUMP var=#TimeZoneInfo#>
				RemoteFileDate: #RemoteFileDate# - #rawRemote#<br>
				StoredFileDate: #StoredFileDate# - #raw#<br>
			</CFOUTPUT>		
--->

			<CFIF RemoteFileDate lt StoredFileDate>
				<!--- Use stored file --->
				<CFLOCATION URL="#CFG.RelativeHere#/images/_sysImages/#hashName#" ADDTOKEN="No">
			<CFELSE>
				<!--- Build new file --->
			</CFIF>
		
		<CFELSE>
			<!--- No last modified date checking --->
			
			<!--- Use stored file --->
			<CFLOCATION URL="#CFG.RelativeHere#/images/_sysImages/#hashName#" ADDTOKEN="No">
			
		</CFIF>
		
	</CFIF>
	
	<CFOUTPUT>#CFG.OurDirectory#_sysImages\</CFOUTPUT>
	
	<CFIF 1>
	
	<!--- The file doesn't exist, so we need to create it --->
	<CFHTTP URL="#ATTRIBUTES.ImageURL#" PATH="#CFG.OurDirectory#\images\_sysImages\" FILE="#hashName#" REDIRECT="Yes" METHOD="GET"  THROWONERROR="Yes"></CFHTTP>
	
	<!--- File has been downloaded, find out if it is a landscape or portrait --->
	<CFX_IMAGE ACTION="IML" FILE="#CFG.OurDirectory#\images\_sysImages\#hashName#" COMMANDS="getsize">
	<CFSET Width = ORIGINAL_WIDTH>
	<CFSET Height = ORIGINAL_Height>
	<CFIF Width GTE Height>
		<CFSET Portrait = "No">
	<CFELSE>
		<CFSET Portrait = "Yes">
	</CFIF>
	cffile
	<!--- Now resize the image --->
	<CFIF Portrait>
		<CFX_IMAGE ACTION="iml" FILE="#CFG.OurDirectory#\images\_sysImages\#hashName#" 
					COMMENT="All your base are belong to James Sleeman" 
					COMMANDS = "
					setjpegdpi 75
					setjpegsmooth 1
					setjpegquality 95
					resize -1,#ATTRIBUTES.MaxDimension#
					write #CFG.OurDirectory#\images\_sysImages\#hashName#
					">
	<CFELSE>
		<CFX_IMAGE ACTION="iml" FILE="#CFG.OurDirectory#images\_sysImages\#hashName#" 
					COMMENT="All your base are belong to James Sleeman" 
					COMMANDS = "
					setjpegdpi 75
					setjpegsmooth 1
					setjpegquality 95
					resize #ATTRIBUTES.MaxDimension#,-1
					write #CFG.OurDirectory#\images\_sysImages\#hashName#
					">
	</CFIF>	
	
	<!--- And locate to the final image --->
	<CFLOCATION URL="#CFG.RelativeHere#/images/_sysImages/#hashName#" ADDTOKEN="No">
	</CFIF>
