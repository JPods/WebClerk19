// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-16T00:00:00, 13:58:46
// ----------------------------------------------------
// Method: [Control].HTTPD_Monitor.Button4
// Description
// Modified: 08/16/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
//jitWebPath.txt   contains the path to the <>webFolder

C_TEXT:C284($tempFold; $testName; $testPath; $parentPath)
$tempFold:=""


ProcessTableOpen(Table:C252(->[WebClerk:78]); "QUERY([WebClerk];[WebClerk]PathTojitWeb=<>webFolder)"; "Active")
If (False:C215)
	$tempFold:=Get_FolderName("Select jitWeb folder.")
	If ($tempFold#"")
		$testName:=HFS_ShortName($tempFold)
		$parentPath:=HFS_ParentName(Application file:C491)
		$testPath:=HFS_ParentName($tempFold)
		Case of 
			: (($parentPath=$testPath) & ($testName="jitWeb@"))
				If ($tempFold#<>webFolder)
					<>webFolder:=$tempFold  // change to the new folder
					If (HFS_Exists(Storage:C1525.folder.jitPrefPath+"jitWebPath.txt")=1)  // delete the previous choice
						$error:=HFS_Delete(Storage:C1525.folder.jitPrefPath+"jitWebPath.txt")
					End if 
					
					myDoc:=Create document:C266(Storage:C1525.folder.jitPrefPath+"jitWebPath.txt")  // set new choice
					If (OK=1)
						SEND PACKET:C103(myDoc; <>WebFolder+"\r")
						CLOSE DOCUMENT:C267(myDoc)
					End if 
					
					WC_StartUp
					
					
				End if 
			: ($testName#"jitWeb@")
				ALERT:C41("jitWeb folder must begin with 'jitWeb'.")
			Else 
				ALERT:C41("jitWeb folder must be in the folder with the application.")
		End case 
	End if 
	//
	
	
	
	
End if 




