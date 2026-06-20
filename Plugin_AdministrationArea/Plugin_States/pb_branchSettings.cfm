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
	<CFSCRIPT>
		// It's handy to have a special character that we can use as a type of
		// "null" - that is, to signal that variable really is set to nothing
		// rather than the empty string
		if (NOT isDefined("CFG.pb_null")) {
			BRANCH.CFG.pb_null = chr(7);		
		}
		
		// It's good to accept dates in the local format as specified by the 
		// server locale.  This is a little hack to work out what that format
		// is.  Basically we create an "ambiguous" date and see which number
		// was interpreted as the day to find it's location in the string.
		if (NOT isDefined("CFG.pb_lsDateFormatString")) {
			testDate = lsParseDateTime("1/2/03");
			if (day(testDate) eq 1) {
				BRANCH.CFG.pb_lsDateFormatString = "dd/mm/yyyy" ;
			} else if (day(testDate) eq 2) {
				BRANCH.CFG.pb_lsDateFormatString = "mm/dd/yyyy";
			} else {
				BRANCH.CFG.pb_lsDateFormatString = "date format";
			}
		}
		
		if (NOT isDefined("CFG.pb_lsDateValidator")) {
			testDate = lsParseDateTime("1/2/03");
			if (day(testDate) eq 1) {
				BRANCH.CFG.pb_lsDateValidator = "eurodate" ;
			} else if (day(testDate) eq 2) {
				BRANCH.CFG.pb_lsDateValidator = "date";
			} else {
				BRANCH.CFG.pb_lsDateValidator = "date";
			}
		}	
	</CFSCRIPT>
</CFSILENT>