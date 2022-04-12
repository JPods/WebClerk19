//TRACE
C_LONGINT:C283(<>iSabrd)
If (<>iSabrd=1)  // & (Current user="bill.james"))
	//If (False)
	C_LONGINT:C283($fOne; $fTwo)
	$workingText:=Get text from pasteboard:C524
	
	
	$fOne:=Position:C15("Personal Information"; $workingText; 0)
	$fTwo:=Position:C15("Personal Information"; $workingText; 0)
	If ($fOne<1)
		//ConsoleMessage ("TEST: No info on clipboard")
	Else 
		iSabrd
		C_TEXT:C284($firstName; $lastName; $zip; $class; $school; $graduationname)
		$graduationname:=[Customer:2]sICCode:16
		$lastName:=[Customer:2]nameLast:23
		$firstName:=[Customer:2]nameFirst:73
		PUSH RECORD:C176([Customer:2])
		QUERY:C277([Customer:2]; [Customer:2]nameFirst:73=$firstName; *)
		QUERY:C277([Customer:2];  & [Customer:2]nameLast:23=$lastName; *)
		If ($graduationname#"")
			QUERY:C277([Customer:2];  | [Customer:2]sICCode:16=$graduationname; *)
		End if 
		QUERY:C277([Customer:2])
		If (Records in selection:C76([Customer:2])=0)
			POP RECORD:C177([Customer:2])
			SAVE RECORD:C53([Customer:2])
		Else 
			ProcessTableOpen(Table:C252(->[Customer:2]); ""; "PossibleDubs")
			POP RECORD:C177([Customer:2])
			BEEP:C151
			BEEP:C151
			BEEP:C151
		End if 
	End if 
	//Else 
	//MenuReset (1)
	//End if 
	
End if 