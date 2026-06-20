<CFSILENT>
	<!--------------------------------------------------------------------------
    	- Local Settings
    	------------------------------------------------------------------------
    	- If you want to add anything to the CFG structure, or make any
		- other local settings that apply to this directory only
		- (settings here do not filter down to children)
		- this is the place to do it.
		-
		- Anything you define in Local.CFG structure will be made available 
		- in the CFG scope.
		-
		- The PlugBox spec defines some local settings for you...
		- CFG.OurDirectory    : 
		-		absolute path to the current directory
		- CFG.RelativeAppRoot :
		-		relative path to the root application directory 
		-		(where Application.cfm lives)
		- CFG.RelativeWebRoot :
		-		relative path to the root web directory 
		-		(where the initial fusebox.cfm/index.cfm file you requested lives)
		- CFG.CustomTags      :
		-		relative path to the directory _Tags in the root application 
		-		directory (use it for referencing custom tags !)
    	----------------------------------------------------------------------->
		
	<!--- <CFSET Local.CFG.Example = "An Example !"> --->
	
	<CFSET Local.CFG.PlName            = ListLast(ListLast(ReReplace(GetDirectoryFromPath(GetCurrentTemplatePath()), "\\|/$", ""), "\/"),"_")>
	<CFSET Local.CFG.PlPlural          = "Editable Pages">
	<CFSET Local.CFG.PlSingular        = "Editable Page">
	<CFSET Local.CFG.PlTableName       = "Q_ListQuery">
	<CFSET Local.CFG.PlTablePrimaryKey = "PageName">
	<CFSET Local.CFG.PlTableOrderBy    = "PageName">
	<CFSET Local.CFG.PlDisplayFields   = "PageName">
	
	<!--- 
		- Parent Table, each plugin may be a direct child of ONE "parent" table
		- eg Category -> Product Relationship, in Plugin_Product, Category is the
		- parent, CaID is PK and PrCategoryLink is LinkField 
	  --->  
	<CFSET Local.CFG.ParentTable           = StructNew()>
	<CFSET Local.CFG.ParentTable.Name      = "">
	<CFSET Local.CFG.ParentTable.PKField   = "">
	<CFSET Local.CFG.ParentTable.LinkField = "">

	<CFSET Local.CFG.ChildPlugins = QueryNew('Dummy')>
	<CFSET Local.CFG.Fields   = QueryNew('Dummy')>
	
	<CFIF NOT IsDefined("CFG.PageEditorLayouts")>
		<CFSET LOCAL.CFG.PageEditorLayouts = ArrayNew(1)>
		<CFSET LOCAL.CFG.PageEditorLayouts[1] = StructNew()>
		<CFSET LOCAL.CFG.PageEditorLayouts[1].layout = "contentLayout">
		<CFSET LOCAL.CFG.PageEditorLayouts[1].name   = "Standard">
	</CFIF>
</CFSILENT>