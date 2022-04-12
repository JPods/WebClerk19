C_LONGINT:C283($tableNum; $tableCnt; $fieldNum; $foundRecord)
C_TEXT:C284($tableName)
$tableCnt:=Get last table number:C254
TRACE:C157
If (([SalesIDTrack:97]tableNum:2>0) & ([SalesIDTrack:97]tableNum:2<=$tableCnt))
	$fieldNum:=STR_GetUniqueFieldNum("SalesIDTrack")
	If ($fieldNum>0)
		If (Type:C295(Field:C253([SalesIDTrack:97]tableNum:2; $fieldNum)->)=Is alpha field:K8:1)
			QUERY:C277(Table:C252([SalesIDTrack:97]tableNum:2)->; Field:C253([SalesIDTrack:97]tableNum:2; $fieldNum)->=[SalesIDTrack:97]docid:7)
		Else 
			QUERY:C277(Table:C252([SalesIDTrack:97]tableNum:2)->; Field:C253([SalesIDTrack:97]tableNum:2; $fieldNum)->=Num:C11([SalesIDTrack:97]docid:7))
		End if 
		If (Records in selection:C76(Table:C252([SalesIDTrack:97]tableNum:2)->)>0)
			$foundRecord:=1
			DB_ShowCurrentSelection(Table:C252([SalesIDTrack:97]tableNum:2); ""; 1; "")
			$myOK:=0
		Else 
			$foundRecord:=0
		End if 
	Else 
		$foundRecord:=0
	End if 
Else 
	$foundRecord:=0
End if 
If ($foundRecord=0)
	jAlertMessage(9201)
End if 