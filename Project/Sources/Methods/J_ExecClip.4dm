//%attributes = {"publishedWeb":true}
//J_ExecClip
//
C_LONGINT:C283($myOK)
C_TEXT:C284($theText; $testString; theText)
//

$doChange:=(UserInPassWordGroup("UnlockRecord"))
If ($doChange)
	C_TEXT:C284($2)
	C_POINTER:C301($1)
	myCycle:=11
	WindowComment("Execute -> click Green Button"; Get text from pasteboard:C524)
	vDiaCom:=""
	myCycle:=0
	$myOK:=0
	If (OK=1)
		Case of 
			: (myOK=3)
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ScriptDrafts"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252(->[Base:1]))
				DB_ShowCurrentSelection(->[TallyMaster:60])
			: (myOK=2)
				$myDocName:=Storage:C1525.folder.jitF+"mydoc"+String:C10(DateTime_DTTo)+".scpt"
				myDoc:=Create document:C266($myDocName)
				If (OK=1)
					SEND PACKET:C103(myDoc; vEntryText)
					CLOSE DOCUMENT:C267(myDoc)
					OPEN URL:C673(document)
				End if 
			Else 
				If (Position:C15("//script"; vEntryText)<50)
					ExecuteText(0; vEntryText; "J_ExecClip")
				Else 
					ExecuteText(1; vEntryText; "on Clipboard, no //script note?")
				End if 
		End case 
	End if 
	myOK:=0
Else 
	ALERT:C41("Access denied.")
End if 
theText:=""
vEntryText:=""