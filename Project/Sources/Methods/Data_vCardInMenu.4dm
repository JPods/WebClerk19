//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-07T00:00:00, 00:03:01
// ----------------------------------------------------
// Method: Data_vCardInMenu
// Description
// Modified: 01/07/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $folderPath)
$folderPath:=""
QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Admin"; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]name:8="vCardIn")
Case of 
	: (Count parameters:C259=1)
		$folderPath:=$1
		// ### bj ### 20181221_1344
		// runs a user override
	: (Records in selection:C76([TallyMaster:60])>1)
		ProcessTableOpen(Table:C252(->[TallyMaster:60]); ""; "Multiple vCard Setups")
	: (Records in selection:C76([TallyMaster:60])=0)
		CREATE RECORD:C68([TallyMaster:60])
		
		[TallyMaster:60]purpose:3:="Admin"
		[TallyMaster:60]name:8:="vCardIn"
		[TallyMaster:60]tableNum:1:=46
		[TallyMaster:60]script:9:="// if any, script to run first"+"\r"
		[TallyMaster:60]build:6:=Storage:C1525.folder.jitF+"vCards"+Folder separator:K24:12
		If (Test path name:C476([TallyMaster:60]build:6)#0)
			CREATE FOLDER:C475([TallyMaster:60]build:6; *)
		End if 
		SAVE RECORD:C53([TallyMaster:60])
	Else 
		C_TEXT:C284($folderPath)
		$folderPath:=[TallyMaster:60]build:6
		ExecuteText(0; [TallyMaster:60]script:9)
End case 
If ($folderPath#"")
	If (Test path name:C476($folderPath)=0)  //a folder was found
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		Data_vCardLoadMove($folderPath)
	Else 
		ALERT:C41("Confirm that TallyMaster Purpose = Admin and Name = vCardIn is properly setup.")
	End if 
End if 