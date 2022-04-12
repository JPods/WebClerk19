//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/02/20, 23:28:04
// ----------------------------------------------------
// Method: ImageTesting
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (False:C215)
	
	QUERY:C277([Item:4]; [Item:4]imagePath:104#"")
	READ WRITE:C146([Item:4])
	vi2:=Records in selection:C76([Item:4])
	ALERT:C41("Records: "+String:C10(vi2))
	FIRST RECORD:C50([Item:4])
	For (vi1; 1; vi2)
		[Item:4]imagePath:104:=Replace string:C233([Item:4]imagePath:104; ":CommerceExpert:jitWeb_Dale:catalog:"; ":CommerceExpert:catalog:")
		SAVE RECORD:C53([Item:4])
		NEXT RECORD:C51([Item:4])
	End for 
	UNLOAD RECORD:C212([Item:4])
	ALERT:C41("Complete")
	
	
End if 


QUERY:C277([Item:4]; [Item:4]vendorID:45="CCS")
READ WRITE:C146([Item:4])
//  REDUCE SELECTION([Item];5)
vi2:=Records in selection:C76([Item:4])
CONFIRM:C162("Records: "+String:C10(vi2))
If (OK=1)
	FIRST RECORD:C50([Item:4])
	vi3:=0
	For (vi1; 1; vi2)
		
		vText11:=Storage:C1525.folder.jitF+"catalog"+Folder separator:K24:12+[Item:4]vendorID:45+Folder separator:K24:12+[Item:4]vendorItemNum:40+".jpg"
		If (Test path name:C476(vText11)=1)
			vi3:=vi3+1
			OB SET:C1220([Item:4]obGeneral:127; "imagePath"; vText11)
			[Item:4]imagePath:104:=Convert path system to POSIX:C1106(vText11)
			OB SET:C1220([Item:4]obGeneral:127; "imagePathPOSIX"; [Item:4]imagePath:104)
			SAVE RECORD:C53([Item:4])
		End if 
		NEXT RECORD:C51([Item:4])
	End for 
End if 
UNLOAD RECORD:C212([Item:4])
ALERT:C41("Completed with "+String:C10(vi3))
