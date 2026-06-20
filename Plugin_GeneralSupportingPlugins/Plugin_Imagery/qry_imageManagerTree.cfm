<CFSILENT>
	
	<CFPARAM NAME="ATTRIBUTES.RootPath">
	<CFPARAM NAME="ATTRIBUTES.RootURL">
	<CFSET   TreeRoot = "#CFG.TopURL#?FuseAction=imageManagerTreeData&Directory=#URLEncodedFormat(ATTRIBUTES.RootPath)#&URL=#URLEncodedFormat(ATTRIBUTES.RootURL)#&JustRoot=Yes&#SESSION.URLToken#">

</CFSILENT>