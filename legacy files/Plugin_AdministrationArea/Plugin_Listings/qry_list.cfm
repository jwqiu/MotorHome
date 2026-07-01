<CFSILENT>
	
	<CFPARAM NAME="ATTRIBUTES.CurrentPage"   DEFAULT="1">
	<CFPARAM NAME="ATTRIBUTES.RowsPerPage"   DEFAULT="10">
	<CFPARAM NAME="ATTRIBUTES.SearchKeyword" DEFAULT="">

	<!--- 
		- Call the query fuseaction to run a query for us
		--->
	<CFIF Len(CFG.ParentTable.Name)>
		<CFPARAM NAME="ATTRIBUTES.#CFG.ParentTable.LinkField#" DEFAULT="#CFG.pb_null#">
		<CFSET   ParentLink = Evaluate("ATTRIBUTES.#CFG.ParentTable.LinkField#")>
		<CFSET PassAtts = StructNew()>
		<CFSET PassAtts["#CFG.ParentTable.LinkField#"] = ParentLink>
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="#CFG.PlName#Query"
			SearchKeyword="#ATTRIBUTES.SearchKeyword#"  ATTRIBUTECOLLECTION=#PassAtts# />
	<CFELSE>
		<CFMODULE TEMPLATE="#CFG.TopLevel#" FuseAction="#CFG.PlName#Query" 
			SearchKeyword="#ATTRIBUTES.SearchKeyword#"  />	
	</CFIF>
	<CFSET Q_ListQuery = CFMODULE.Attributes.Q_ListQuery>
	
	<!---
		- Construct 3 variables, IM_StartRow, IM_MaxRow and IM_PageThru
		- IM_PageThru contains HTML for a search pager
		- Page << < 1 2 3 > >> 
		--->
	
	<CFSCRIPT>
		IM_StartRow = ((ATTRIBUTES.CurrentPage - 1) * ATTRIBUTES.RowsPerPage) + 1;
		IM_MaxRow   = ATTRIBUTES.RowsPerPage;
		IM_PageThru = "Page ";
		IM_PagesPerGroup = 4;
		
		// Work out maximum pages required for this query
		MaxPages    = Q_ListQuery.RecordCount \ ATTRIBUTES.RowsPerPage;
		if (Q_ListQuery.RecordCount Mod ATTRIBUTES.RowsPerPage) {
				MaxPages = MaxPages + 1;	
		}
		
		// Work out the first and last pages in the current page's group
		OurGroup = (ATTRIBUTES.CurrentPage - 1) \ IM_PagesPerGroup;
		GroupFirst = (OurGroup * IM_PagesPerGroup) + 1;
		GroupLast  = Min((GroupFirst + IM_PagesPerGroup - 1), MaxPages);

		// Add previous group link
		if (GroupFirst GT 1) {
			PrevGroup   = Max(1, ATTRIBUTES.CurrentPage - IM_PagesPerGroup);
			IM_PageThru = IM_PageThru & " <A CLASS='pagegroup' HREF='#REQUEST.BACK#&CurrentPage=#PrevGroup#'>&lt;&lt;</A> ";
		}
		// Add previous page link
		if (ATTRIBUTES.CurrentPage GT 1){
			PrevPage = ATTRIBUTES.CurrentPage - 1;
			IM_PageThru = IM_PageThru & " <A CLASS='pagegroup' HREF='#REQUEST.BACK#&CurrentPage=#PrevPage#'>&lt;</A> ";
		}
		// Add group pages links
		for (Page = GroupFirst;  Page LTE GroupLast; Page = Page + 1){
			if (Page eq ATTRIBUTES.CurrentPage){
				IM_PageThru = IM_PageThru & " <SPAN CLASS='selectedPage'>#Page#</SPAN> ";
			} else {
				IM_PageThru = IM_PageThru & " <A CLASS='selectedPage' HREF='#REQUEST.BACK#&CurrentPage=#Page#'>#Page#</A> ";
			}
		}
		// Add next page link
		if (ATTRIBUTES.CurrentPage LT MaxPages){
			NextPage = ATTRIBUTES.CurrentPage + 1;
			IM_PageThru = IM_PageThru & " <A CLASS='pagegroup' HREF='#REQUEST.BACK#&CurrentPage=#NextPage#'>&gt;</A> ";
		}
		// Add next group link
		if (GroupLast LT MaxPages) {
			NextGroup = Min(MaxPages, ATTRIBUTES.CurrentPage + IM_PagesPerGroup);
			IM_PageThru = IM_PageThru & " <A CLASS='pagegroup' HREF='#REQUEST.BACK#&CurrentPage=#NextGroup#'>&gt;&gt;</A> ";
		}
		
		if (IM_PageThru eq "Page ") {
			IM_PageThru = "";
		}
	</CFSCRIPT>
				  	
</CFSILENT>