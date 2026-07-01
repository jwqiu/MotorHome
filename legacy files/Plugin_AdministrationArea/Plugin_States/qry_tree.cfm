<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.#CFG.PlTablePrimaryKey#"   DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.TreePath"					 DEFAULT="">
	<CFPARAM NAME="ATTRIBUTES.TreeRoot"                  DEFAULT="#REQUEST.BACK#">
	
	<CFIF NOT Len(Evaluate("ATTRIBUTES.#CFG.PlTablePrimaryKey#"))>
	<!---
		- We have not been asked for details of a specific entity, so grab a query
		- of all the entities of this type
		--->
		<CFIF Len(CFG.ParentTable.Name)>
			<CFPARAM NAME="ATTRIBUTES.#CFG.ParentTable.LinkField#" DEFAULT="#CFG.pb_null#">
			<CFSET   ParentLink = Evaluate("ATTRIBUTES.#CFG.ParentTable.LinkField#")>
			<CFSET PassAtts = StructNew()>
			<CFSET PassAtts["#CFG.ParentTable.LinkField#"] = ParentLink>
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="#CFG.PlName#Query"
				ATTRIBUTECOLLECTION=#PassAtts# />
		<CFELSE>
			<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="#CFG.PlName#Query" />	
		</CFIF>
		
		<CFSET Q_ListQuery = CFMODULE.Attributes.Q_ListQuery>
		
		<!--- Ok, we have the query, now build the array of nodes --->
		<CFSET NodesArray = ArrayNew(1)>
		<CFLOOP QUERY="Q_ListQuery">
			<CFSET NewNode = StructNew()>
			<CFSET NewNode.Display = "">
						
			<!--- Make a display string --->
			<CFLOOP LIST="#CFG.PlDisplayFields#" INDEX="Field">
				<CFIF Len(NewNode.Display)>
					<CFSET NewNode.Display = NewNode.Display &", #Evaluate(Field)#">
				<CFELSE>
					<CFSET NewNode.Display = Evaluate(Field)>
				</CFIF>
			</CFLOOP>
			
			<!--- Make a Node ID --->
			<CFSET NewNode.ID       = Hash(NewNode.Display & CFG.PlName)>
			
			<!--- Set ourself to the childURL --->
			<CFSET NewNode.ChildURL = "#CFG.TopURL#?FuseAction=#ATTRIBUTES.FuseAction#&#CFG.PlTablePrimaryKey#=#Evaluate(CFG.PlTablePrimaryKey)#&TreePath=#URLEncodedFormat(ListAppend(ATTRIBUTES.TreePath, NewNode.ID))#&TreeRoot=#URLEncodedFormat(ATTRIBUTES.TreeRoot)#&#SESSION.URLToken#">
			
			<!--- Make a url to come back here --->
			<CFSET RFA = CFG.TopURL & 
						 "?FuseAction=AdminTree&ExpandNodes=" & 
						 URLEncodedFormat(ListAppend(ATTRIBUTES.TreePath, NewNode.ID))
						 & "&RootURL=#URLEncodedFormat(ATTRIBUTES.TreeRoot)#">
			
			
			<!--- Add actions to edit and delete ourself  --->
			<CFSET NewNode.Actions    = ArrayNew(1)>
			
			<CFSET NewNode.Actions[1] = StructNew()>
			<CFSET NewNode.Actions[1].DISPLAY = "View/Edit Detail">
			<CFSET NewNode.Actions[1].ClickURL     = "#CFG.TopURL#?FuseAction=#CFG.PlName#Edit&#CFG.PlTablePrimaryKey#=#Evaluate(CFG.PlTablePrimaryKey)#&RFA=#URLEncodedFormat(RFA)#&#SESSION.URLToken#">
			
			<CFSET NewNode.Actions[2] = StructNew()>
			<CFSET NewNode.Actions[2].DISPLAY = "Delete">
			<CFSET NewNode.Actions[2].ClickURL     = "#CFG.TopURL#?FuseAction=#CFG.PlName#Delete&#CFG.PlTablePrimaryKey#=#Evaluate(CFG.PlTablePrimaryKey)#&RFA=#URLEncodedFormat(RFA)#&#SESSION.URLToken#">
			<CFSET NewNode.Actions[2].BGCOLOUR = "##FF0000"> 
			<CFSET NewNode.Actions[2].COLOUR   = "##FFFFFF">  
			
			<CFSET NewNode.Actions[3] = StructNew()>
			<CFSET NewNode.Actions[3].DISPLAY = "Root Tree Here">
			<CFSET NewNode.Actions[3].ClickURL     = "#CFG.TopURL#?FuseAction=AdminTree&RootURL=#URLEncodedFormat(NewNode.ChildURL)#&ExpandNodes=#URLEncodedFormat(NewNode.ID)#&#SESSION.URLToken#">
			
			<!--- Add actions to list our children --->
			<CFSET thisPK = Evaluate(CFG.PlTablePrimaryKey)>
			<CFLOOP QUERY="CFG.ChildPlugins">
				<CFSET NewNode.Actions[ArrayLen(NewNode.Actions) + 1] = StructNew()>
				<CFSET NewNode.Actions[ArrayLen(NewNode.Actions)].DISPLAY =  "New #Singular#">
				<CFSET NewNode.Actions[ArrayLen(NewNode.Actions)].ClickURL     = "#CFG.TopURL#?FuseAction=#ChildName#New&#LinkField#=#ThisPK#&RFA=#URLEncodedFormat(RFA)#&#SESSION.URLToken#">
			
				<CFSET NewNode.Actions[ArrayLen(NewNode.Actions) + 1] = StructNew()>
				<CFSET NewNode.Actions[ArrayLen(NewNode.Actions)].DISPLAY =  "List/Search #Plural#">
				<CFSET NewNode.Actions[ArrayLen(NewNode.Actions)].ClickURL     = "#CFG.TopURL#?FuseAction=#ChildName#List&#LinkField#=#ThisPK#&#SESSION.URLToken#">
							
			</CFLOOP>
			
			<CFSET NodesArray[ArrayLen(NodesArray) + 1] = NewNode>
		</CFLOOP>
	<CFELSE>
		<!--- A query about a specific row, return the main arrays of each child
			- concatenated into one array --->	
		<CFSET NodesArray = ArrayNew(1)>
		<CFLOOP QUERY="CFG.ChildPlugins">
			<CFSET PassedAtts = StructNew()>
			<CFSET PassedAtts.FuseAction = "#ChildName#Tree">
			<CFSET PassedAtts.TreePath   = "#ATTRIBUTES.TreePath#">
			<CFSET PassedAtts.TreeRoot   = "#ATTRIBUTES.TreeRoot#">
			<CFSET PassedAtts[LinkField] = ATTRIBUTES[CFG.PlTablePrimaryKey]>
			<CFMODULE TEMPLATE="#CFG.TopLevel#" ATTRIBUTECOLLECTION=#PassedAtts# />
			<CFSET ChildNodes = CFMODULE.Attributes.NodesArray>
			<CFLOOP FROM="1" TO="#ArrayLen(ChildNodes)#" INDEX="x">
				<CFSET ArrayAppend(NodesArray, ChildNodes[x])>
			</CFLOOP>
		</CFLOOP>	
		
		<!--- We want to sort the nodes --->
		<CFSCRIPT>
			function nodeCompare(node1, node2){
				return compare(node1.Display, node2.Display);
			}
			
			function quickSort(arrayToCompare, sorter){
				var lesserArray  = ArrayNew(1);
				var greaterArray = ArrayNew(1);
				var pivotArray   = ArrayNew(1);
				var examine      = 2;
				pivotArray[1]    = arrayToCompare[1];

				if (arrayLen(arrayToCompare) LT 2) {
					return arrayToCompare;
				}
				
				while(examine LTE arrayLen(arrayToCompare)){
					comparison = sorter(arrayToCompare[examine], pivotArray[1]);
					switch(comparison) {
						case "-1": {
							arrayAppend(lesserArray, arrayToCompare[examine]);
							break;
						}
						case "0": {
							arrayAppend(pivotArray, arrayToCompare[examine]);
							break;
						}
						case "1": {
							arrayAppend(greaterArray, arrayToCompare[examine]);
							break;
						}
					}
					examine = examine + 1;
				}				
				
				if (arrayLen(lesserArray)) {
					lesserArray  = quickSort(lesserArray, sorter);
				} else {
					lesserArray = arrayNew(1);
				}	
					
				if (arrayLen(greaterArray)) {
					greaterArray = quickSort(greaterArray, sorter);
				} else {
					greaterArray = arrayNew(1);
				}
				
				examine = 1;
				while(examine LTE arrayLen(pivotArray)){
					arrayAppend(lesserArray, pivotArray[examine]); 
					examine = examine + 1;
				};
				
				examine = 1;
				while(examine LTE arrayLen(greaterArray)){
					arrayAppend(lesserArray, greaterArray[examine]); 
					examine = examine + 1;
				};
				
				return lesserArray;				
			}
		</CFSCRIPT>
		<CFIF ArrayLen(NodesArray)>
			<CFSET NodesArray = quickSort(NodesArray, nodeCompare)>
		</CFIF>
	</CFIF>
	<CFSET ATTRIBUTES.NodesArray = NodesArray>
	<CFSET ATTRIBUTES.Layout     = "None">
	<CFSETTING SHOWDEBUGOUTPUT   = "No">

</CFSILENT>