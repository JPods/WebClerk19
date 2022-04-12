

C_OBJECT:C1216(iLoObject1)

If (iLoText1="")
	ALERT:C41("You need a script to execute.")
Else 
	ExecuteText(0; iLoText1)
End if 


If (False:C215)
	
	
	
	
	C_OBJECT:C1216($obComplete)
	
	$obPayload:=[SyncRecord:109]ObGeneral:16
	RP_CreateSOfromPO(->$obComplete)
	
	If (False:C215)
		SyncParseStandard
	End if 
	
	If (False:C215)
		READ ONLY:C145([SyncRelation:103])
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]Name:8="SOtoSO")
		
		jsonToSelection
		
		If (False:C215)
			
			
			C_TEXT:C284($jsonPattern)
			C_OBJECT:C1216($objPattern)
			$jsonPattern:=[SyncRecord:109]PackingNotes:14
			$objPattern:=JSON Parse:C1218([SyncRecord:109]PackingNotes:14)
			
			
			
			
			C_OBJECT:C1216($objPattern)
			$objPattern:=JSON Parse:C1218($jsonPattern)
			ARRAY TEXT:C222($atNames; 0)
			ARRAY LONGINT:C221($aiTypes; 0)
			OB GET PROPERTY NAMES:C1232($objPattern; $atNames; $aiTypes)
			
			
			C_OBJECT:C1216($objHead)
			C_OBJECT:C1216($objData)
			
			ARRAY TEXT:C222($atNamesHead; 0)
			ARRAY LONGINT:C221($aiTypesHead; 0)
			
			ARRAY TEXT:C222($atNamesLocal; 0)
			ARRAY LONGINT:C221($aiTypesLocal; 0)
			
			ARRAY OBJECT:C1221($aObjHead; 0)
			ARRAY OBJECT:C1221($aObjData; 0)
			
			$objHead:=OB Get:C1224($objPattern; "head")
			OB GET ARRAY:C1229($objHead; "SyncRecord"; $aObjHead)
			
			$objSync:=$aObjHead{1}
			// header value pairs
			
			jsonParsingToFlat($objSync; "start")
			
			$objData:=OB Get:C1224($objPattern; "data")
			
			jsonParsingToFlat($objData; "start")
			
			ARRAY TEXT:C222($atNamesData; 0)
			ARRAY LONGINT:C221($aiTypesData; 0)
			OB GET PROPERTY NAMES:C1232($objData; $atNamesData; $aiTypesData)
			
			
			OB GET ARRAY:C1229($objData; "data"; $aObjData)
			
		End if 
		
	End if 
	
End if 