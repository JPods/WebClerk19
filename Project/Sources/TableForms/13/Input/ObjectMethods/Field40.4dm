
C_BOOLEAN:C305($doPop)
C_LONGINT:C283($recordNum)

If (Record number:C243([Customer:2])>-1)
	$recordNum:=Record number:C243([Customer:2])
	PUSH RECORD:C176([Customer:2])
End if 
QUERY:C277([Customer:2]; [Customer:2]customerID:1=Self:C308->)
Case of 
	: (Records in selection:C76([Customer:2])=1)
		CONFIRM:C162("Change Contacts Company to "+[Customer:2]company:2)
		If (OK=1)
			[Contact:13]company:23:=[Customer:2]company:2
		End if 
	: (Records in selection:C76([Customer:2])=0)
		ALERT:C41("There is no matching customer record.")
	: (Records in selection:C76([Customer:2])>1)
		ALERT:C41("There are multiple matching customer records.")
End case 
If ($doPop)
	$doPop:=False:C215
	If ($recordNum#Record number:C243([Customer:2]))
		$recordNum:=Record number:C243([Customer:2])
		$doPop:=True:C214
	End if 
	POP RECORD:C177([Customer:2])  // get record off the stack
	If ($doPop)
		GOTO RECORD:C242([Customer:2]; $recordNum)  // to to the appropriate customers record
	End if 
End if 