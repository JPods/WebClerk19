Case of 
	: (FORM Event:C1606.code=On After Keystroke:K2:26)
		If (FORM Event:C1606.objectName="searchWidget")
			var $searchString : Text
			$searchString:=Get edited text:C655
			//If (Length($searchString)>=Storage.query.afterLengthMin)
			If (cb_All)
				LB_DataBrowser.source:=ds:C1482[Form:C1466.dataClassName].query("keyTags = :1 "; $searchString+"@")  //.orderBy("company asc")
				LB_DataBrowser.setData()
			Else 
				LB_DataBrowser.ents:=LB_DataBrowser.source.query("keyTags = :1 "; $searchString+"@")  //.orderBy("company asc")
			End if 
			//End if 
		End if 
	: (FORM Event:C1606.code=On After Edit:K2:43)
		If (FORM Event:C1606.objectName="searchWidget")
			
		End if 
		
	: (FORM Event:C1606.code=On Close Box:K2:21)
		CANCEL:C270
		
	: (FORM Event:C1606.code=On Load:K2:1)
		
		process_o._setSFList()
		
		
		process_o._setSFEntry(process_o.dataClassName; Current form name:C1298; "SF_cur")
		// build the entry form
		//SF_cur._setSpacing()
		
End case 


