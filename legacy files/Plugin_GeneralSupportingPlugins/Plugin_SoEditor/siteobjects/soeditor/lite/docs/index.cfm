<cfsetting showdebugoutput="No">
<!---

  SourceSafe: $Header: /SiteObjects/Products/ColdFusion Tags/soEditor/lite/docs/index.cfm 5     12/13/01 10:56a Don $
  Date Created: 12/12/2001
  Author: Brett Suwyn
  Project: soEditor Lite 2.0
  Description: Index file for docs

--->

<cfparam name="URL.Method" default="">

<!--- Documentation variables --->
<cfscript>
  Variables.ScriptPath = "/siteobjects/soeditor/lite/";
  Variables.DocPath = "/siteobjects/soeditor/lite/docs/";
</cfscript>

<cfswitch expression="#URL.Method#">

<cfcase value="exampleone">
  <cfinclude template="dsp_header.cfm">
  <cfinclude template="dsp_exampleone.cfm">
  <cfinclude template="dsp_footer.cfm">  
</cfcase>

<cfcase value="exampletwo">
  <cfinclude template="dsp_header.cfm">
  <cfinclude template="dsp_exampletwo.cfm">
  <cfinclude template="dsp_footer.cfm">  
</cfcase>

<cfcase value="Invocation">
  <cfinclude template="dsp_header.cfm">
  <cfinclude template="dsp_invocation.cfm">
  <cfinclude template="dsp_footer.cfm">  
</cfcase>

<cfdefaultcase>
  <cfinclude template="dsp_header.cfm">
  <cfinclude template="dsp_main.cfm">
  <cfinclude template="dsp_footer.cfm">
</cfdefaultcase>

</cfswitch>