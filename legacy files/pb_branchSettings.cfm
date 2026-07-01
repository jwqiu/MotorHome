<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Branch Settings
    	------------------------------------------------------------------------
    	- If you want to add anything to the CFG structure that apply to this 
		- directory and all child directories (i.e this "branch")  this is the
		- place
		-
		- Anything you define in Branch.CFG structure will be made available 
		- in the CFG scope and passed to child plugins.
    	----------------------------------------------------------------------->
		
	<!--- <CFSET Branch.CFG.Example = "An Example !"> --->
	<CFSET Branch.CFG.Blah = "Hello There">
	<CFPARAM NAME="SESSION.SecurityID" DEFAULT="">
	<CFPARAM NAME="SESSION.SecurityEmail" DEFAULT="">
	<CFPARAM NAME="SESSION.SecurityName" DEFAULT="">
	<CFPARAM NAME="SESSION.SecurityPassword" DEFAULT="">
	
</CFSILENT>