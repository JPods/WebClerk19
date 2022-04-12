C_OBJECT:C1216($event_o)
$event_o:=FORM Event:C1606
Case of 
	: ($event_o.code=On Double Clicked:K2:5)
		If (False:C215)  // I do not think this is needed Edit can be done directly in the using window -- Add a New and Save
			C_LONGINT:C283($viProcess)
			C_OBJECT:C1216($obTemp)
			$obTemp:=New object:C1471("tableName"; "Letter"; "id"; "form"; "LetterJoint"; Form:C1466.cLetterCurrent.id; "processParent"; Current process:C322; "parentProcessName"; Current process name:C1392)
			$viProcess:=New process:C317("Dialog_RecordID"; 0; "Letter "+String:C10(Count tasks:C335); $obTemp)
			CANCEL:C270  // close the dialog window
		End if 
	: ($event_o.code=On Data Change:K2:15)
		C_OBJECT:C1216($obRec)
		$obRec:=ds:C1482.Letter.query("id = :1"; Form:C1466.cLetterCurrent.id).first()
		$obRec.name:=Form:C1466.cLetterCurrent.name
		$obRec.topic:=Form:C1466.cLetterCurrent.topic
		$result_o:=$obRec.save()
End case 