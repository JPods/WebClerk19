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
		
		var SF_cur; LB_Import : Object
		If (Form:C1466.dataClassName=Null:C1517)
			Form:C1466.dataClassName:="Item"
		End if 
		
		LB_Import:=cs:C1710.listboxK.new("LB_Import"; Form:C1466.dataClassName)
		
		If (Form:C1466.data=Null:C1517)
			//Form.data:=ds[Form.dataClassName].all()
		End if 
		
		
		
		
		LB_Import.setSource(Form:C1466.data)
		
		If (False:C215)
			SF_cur:=cs:C1710.cEntry.new(Form:C1466.dataClassName; "DataBrowser"; "SF_cur")
			SF_cur._setSubForm()  // space between fields
			SF_cur._makeEntryChoices()
			SF_cur.cur:=LB_DataBrowser.cur
		End if 
		
		
		
End case 


