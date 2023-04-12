C_OBJECT:C1216($event_o)
$event_o:=FORM Event:C1606
Case of 
	: ($event_o.code=On Clicked:K2:4)
		If ($event_o.objectName="LBLetter")
			Ltr_FillTinyMCE(Form:C1466.cLetterCurrent.body)
		End if 
	: ($event_o.code=On Load:K2:1)
		var process_o : Object
		process_o:=$1  // when passing in all records must be in the process_o.ent
		P_FillVars(process_o)
		Ltr_ListVars(process_o.dataClassName)
		$w:=Size of array:C274(SRVarNames)+1
		INSERT IN ARRAY:C227(SRVarNames; $w)
		SRVarNames{$w}:="P_FillVars"
		viLetterTableNum:=-1
		bConvert:=1
		OBJECT SET ENABLED:C1123(bOK; (bConvert=0))
		
		C_COLLECTION:C1488($cTemp)
		$cTemp:=Ltr_GetCollection(process_o.dataClassName)
		Form:C1466.cLetter:=$cTemp.orderBy("name asc")
		bConvert:=1
		
		If (Form:C1466.cLetter#Null:C1517)
			Ltr_FillTinyMCE(Form:C1466.cLetter[0].body; 1)
		Else 
			Ltr_FillTinyMCE("empty"; 1)
		End if 
		
		
		
	: ($event_o.code=On Close Box:K2:21)
		CANCEL:C270
End case 