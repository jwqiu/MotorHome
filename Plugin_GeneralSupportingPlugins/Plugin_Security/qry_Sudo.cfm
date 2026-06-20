<CFSILENT>
	<!--- Call the sudo processor to do the dirty --->
	<CFPARAM NAME="ATTRIBUTES.Action"    DEFAULT="start">
	<CFPARAM NAME="ATTRIBUTES.Processor" >
	
	<CFMODULE TEMPLATE="#CFG.TopLevel#" 
		FuseAction="#ATTRIBUTES.Processor#processSudo" ATTRIBUTECOLLECTION=#ATTRIBUTES# />
</CFSILENT>