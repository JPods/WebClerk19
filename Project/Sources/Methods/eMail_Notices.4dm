//%attributes = {"publishedWeb":true}
//Method: eMail_Notices
If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 
C_LONGINT:C283(vlLogRequirement)
C_TEXT:C284($1; $emailAddresses)
//TRACE
vlLogRequirement:=0  //222
//
If (Count parameters:C259=1)
	
	$emailAddresses:=$1
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$emailAddresses; *)  //"WebClerk_NewOrder"
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WebClerk_MailScript")
	If ((Records in selection:C76([TallyMaster:60])=1) & ([TallyMaster:60]tableNum:1>0) & ([TallyMaster:60]tableNum:1<=Get last table number:C254))
		//SMTP_EmailBuild (Table([TallyMaster]TableNum))
		//build is not required.  This only sends additional copies
		C_LONGINT:C283($p)
		C_TEXT:C284($moreAddress; $workingAddress)
		vtEmailSubject:=[TallyMaster:60]profile1:23+": "+vtEmailSubject
		$workingAddress:=[TallyMaster:60]after:7
		Repeat 
			$p:=Position:C15("\r"; $workingAddress)
			If ($p>0)
				vtEmailReceiver:=Substring:C12($workingAddress; 1; $p-1)
				$workingAddress:=Substring:C12($workingAddress; $p+1)
			Else 
				vtEmailReceiver:=$workingAddress
			End if 
			If (Position:C15(Char:C90(64); vtEmailReceiver)>0)
				SMTP_SendMsg
			End if 
			$moreAddress:=""
		Until ($p=0)
	End if 
	//End if 
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
	
	//
End if 