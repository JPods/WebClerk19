C_LONGINT:C283($tableNum; $tableCnt; $fieldNum; $foundRecord)
C_TEXT:C284($tableName)
$tableCnt:=Get last table number:C254
TRACE:C157
If (([TrackKeyField:98]tableNum:1>0) & ([TrackKeyField:98]tableNum:1<=$tableCnt))
	$fieldNum:=STR_GetUniqueFieldNum(Table name:C256([TrackKeyField:98]tableNum:1))
	If ($fieldNum>0)
		If (Type:C295(Field:C253([TrackKeyField:98]tableNum:1; $fieldNum)->)=Is alpha field:K8:1)
			QUERY:C277(Table:C252([TrackKeyField:98]tableNum:1)->; Field:C253([TrackKeyField:98]tableNum:1; $fieldNum)->=[TrackKeyField:98]docid:8)
		Else 
			QUERY:C277(Table:C252([TrackKeyField:98]tableNum:1)->; Field:C253([TrackKeyField:98]tableNum:1; $fieldNum)->=Num:C11([TrackKeyField:98]docid:8))
		End if 
		If (Records in selection:C76(Table:C252([TrackKeyField:98]tableNum:1)->)>0)
			$foundRecord:=1
			DB_ShowCurrentSelection(Table:C252([TrackKeyField:98]tableNum:1); ""; 1; "")
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