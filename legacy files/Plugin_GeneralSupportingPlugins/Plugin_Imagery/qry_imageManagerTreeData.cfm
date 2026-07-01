<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Directory" DEFAULT="#CFG.ImagesDirectory#">
	<CFPARAM NAME="ATTRIBUTES.URL"       DEFAULT="#CFG.ImagesURL#">
	
	<CFIF IsDefined("ATTRIBUTES.JustRoot")>
		<CFSET NodesArray = ArrayNew(1)>
		<CFSET NodesArray[1] = StructNew()>
		<CFSET NodesArray[1].Display = ListLast(ATTRIBUTES.URL, '/')>
		<CFSET NodesArray[1].ID = ATTRIBUTES.Directory>
		<CFSET NodesArray[1].ChildURL = "#CFG.TopURL#?FUseAction=#ATTRIBUTES.FuseAction#&Directory=#URLEncodedFormat(ATTRIBUTES.Directory)#&URL=#URLEncodedFormat(ATTRIBUTES.URL)#&#SESSION.URLToken#">
		<CFSET nodesArray[1].ClickURL = "javascript:parent.showThumbs('#JSSTRINGFORMAT(ATTRIBUTES.Directory)#', '#JSSTRINGFORMAT(ATTRIBUTES.URL)#')">
		<CFSET NodesArray[1].Actions = ArrayNew(1)>
	<CFELSE>
	<!--- Build a wddx structure of nodes for the entries in this directory --->
	<CFDIRECTORY ACTION="LIST" DIRECTORY="#ATTRIBUTES.Directory#" NAME="Q_Directory">
	
	<CFSET NodesArray = ArrayNew(1)>
	<CFLOOP QUERY="Q_Directory">
		<CFIF Name neq "." AND Name neq ".." AND Name neq "_sysImages" AND Type eq "dir">
			<CFSET NewNode = StructNew()>
			<CFSET NewNode.Display = Name>
			<CFSET NewNode.NewNode.ID = ATTRIBUTES.Directory & Name>
			<CFIF type eq "dir">
				<CFSET NewNode.ChildURL = 
					"#CFG.TopURL#?FUseAction=#ATTRIBUTES.FuseAction#&Directory=#URLEncodedFormat(ATTRIBUTES.Directory & Name & '\')#&URL=#URLEncodedFormat(ATTRIBUTES.URL & Name & '/')#&#SESSION.URLToken#">
				<CFSET NewNode.ClickURL = "javascript:parent.showThumbs('#JSSTRINGFORMAT(ATTRIBUTES.Directory & Name & '\')#', '#JSSTRINGFORMAT(ATTRIBUTES.URL & Name & '/')#')">
			<CFELSE>
				<CFSET NewNode.LEAFICON =
				"#CFG.TopURL#?FuseAction=imager&MaxDimension=32&ImageURL=#URLEncodedFormat(ATTRIBUTES.URL & Name)#&#SESSION.URLToken#">
				<CFSET NewNode.ClickURL = "javascript:parent.showImage('#JSSTRINGFORMAT(ATTRIBUTES.Directory)#', '#JSSTRINGFORMAT(ATTRIBUTES.URL & Name)#')">
			</CFIF>
			<CFSET NewNode.Actions = ArrayNew(1)>
		
			<CFSET NodesArray[ArrayLen(NodesArray) + 1] = NewNode>
		</CFIF>
	</CFLOOP>
	
	</CFIF>
	
	<CFSET ATTRIBUTES.NodesArray = NodesArray>
	<CFSET ATTRIBUTES.Layout     = "None">
	<CFSETTING SHOWDEBUGOUTPUT   = "No">
</CFSILENT>