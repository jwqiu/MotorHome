<SPAN CLASS="introText">
<P>
Open (or close) a "folder" by clicking on the handle to the left of the folder icon, 
right click on the "name" of an item in the tree and choose from actions in the drop down 
menu below the tree.
</P>
</SPAN>


<CFPARAM NAME="ATTRIBUTES.expandNodes" DEFAULT="">
<CFPARAM NAME="ATTRIBUTES.RootURL"       DEFAULT="#CFG.TopURL#?FuseAction=AdminBaseTree&#SESSION.URLToken#">

<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="tree" RootURL="#ATTRIBUTES.RootURL#&TreeRoot=#URLEncodedFormat(ATTRIBUTES.RootURL)#" ExpandNodes="#ATTRIBUTES.expandNodes#"/>
