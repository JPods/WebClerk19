C_LONGINT:C283($fileNum)  //$recNum;;$selRec)
C_BOOLEAN:C305($noPrime)
If ([UserReport:46]IsPrimary:15)
	CREATE SET:C116([UserReport:46]; "Current")
	$fileNum:=[UserReport:46]tableNum:3
	$recNum:=Record number:C243([UserReport:46])
	//  $selRec:=Selected record number([UserReport])
	PUSH RECORD:C176([UserReport:46])
	QUERY:C277([UserReport:46]; [UserReport:46]IsPrimary:15=True:C214; *)
	QUERY:C277([UserReport:46];  & [UserReport:46]Active:1=True:C214; *)
	QUERY:C277([UserReport:46];  & [UserReport:46]tableNum:3=$fileNum)
	If ((Records in selection:C76([UserReport:46])>0) & (Record number:C243([UserReport:46])#$recNum))
		jAlertMessage(12003)
		$noPrime:=True:C214
	End if 
	If (booSorted)
		POP RECORD:C177([UserReport:46])
		ONE RECORD SELECT:C189([UserReport:46])
	Else 
		USE SET:C118("Current")
		POP RECORD:C177([UserReport:46])
		//    GOTO SELECTED RECORD([UserReport];$selRec)
	End if 
	CLEAR SET:C117("Current")
	[UserReport:46]IsPrimary:15:=Not:C34($noPrime)
End if 