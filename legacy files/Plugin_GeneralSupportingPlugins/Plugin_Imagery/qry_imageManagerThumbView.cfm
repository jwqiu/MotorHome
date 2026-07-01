<CFSILENT>
	<CFPARAM NAME="ATTRIBUTES.Path">
	<CFPARAM NAME="ATTRIBUTES.URL">

	<!--- Do a directory list on the path  --->
	<CFDIRECTORY NAME="Q_Directory" DIRECTORY="#ATTRIBUTES.Path#" ACTION="LIST">
	
	<!--- Remove . and .. from that --->
	<CFQUERY DBTYPE="query" NAME="Q_Directory">
		SELECT * FROM Q_Directory
		WHERE 
			(
				TYPE = 'File'
				AND 
				(		NAME LIKE '%.jpg'
					OR  NAME LIKE '%.gif'
					OR  NAME LIKE '%.png'
				)
			)
			OR
			(
			  TYPE = 'Dir'
			  AND
			  NAME NOT LIKE '.'
			  AND 
			  NAME NOT LIKE '..'
			)
		ORDER BY Type, Name
	</CFQUERY>
	
</CFSILENT>