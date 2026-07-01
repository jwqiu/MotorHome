<CFSILENT>
	<!--------------------------------------------------------------------------
		- Output Filter
		------------------------------------------------------------------------
		- This file is run at the very last moment before the handlers output
		- is returned to the caller (who could be another fuseaction or the user
		- themselves).
		-
		- You have the full compliment of ATTRIBUTES and CFG at yoiur disposal
		- plus the variable BodyData which contains the text that is about
		- to be returned.
		----------------------------------------------------------------------->
	
	<!---
		- An example, fixing relative references
		-  one of the guiding principles of PlugBox is that you should be able
		-   to just "drop in" a plugin directory to an existing application and
		-   *poof* you instantly have a working addition to your application.
		-
		-  now, lets say you produce a plugin and in it's display files you reference
		-   some images.  Where do you put them ?  
		-
		-  If you put them in an images
		-   directory in the root of your site, that will break the plugin, because
		-   now you have to also send out some images, instead of just a plugin.
		-
		-  If you just put them in an images directory within your plugin, you 
		-   will have to know the exact path to where the plugin is installed
		-   which would break the plugin because now you have to also send out
		-   some instructions to "change CFG variable 'pathToPlugin'" instead of
		-   just a plugin.
		-   
		-  But with the outputFilter and a little creativity we can solve this
		-   problem !  We put the images into an images directory within our 
		-   plugin (eg Plugin_Foo/images).  In our dsp_ files within the plugin
		-   we reference the images as "images/myImage.jpg" (which is very nice
		-   for html editors like DreamWeaver by the way).  And here in the 
		-   output filter we just rewrite the relative paths to work from the
		-   RootWeb (eg rewrite "images/myImage.jpg" to 
		-	"Plugin_Foo/images/myImage.jpg") !  Tell me that ai'nt cool, go on.
		-
		- <CFSET RelativeHere = ReplaceNoCase(CFG.OurDirectory, CFG.WebRoot, "")>
		- <CFSET RelativeHere = Replace(RelativeHere, "\", "/")>
		- <CFSET BodyData = ReplaceNoCase(BodyData, 'SRC="images', 'SRC="#RelativeHere#images', "ALL")>
		--->
		
	<CFSET RelativeHere = ReplaceNoCase(CFG.OurDirectory, CFG.WebRoot, "")>
	<CFSET RelativeHere = Replace(RelativeHere, "\", "/")>
	<CFSET BodyData = ReplaceNoCase(BodyData, 'SRC="images', 'SRC="#RelativeHere#images', "ALL")>
	
	<CFPARAM NAME="ATTRIBUTES.Layout" DEFAULT="#CFG.PlName#Layout">
	
</CFSILENT>