//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/08/09, 12:23:02
// ----------------------------------------------------
// Method: jStart2
// Description
// 
//
// Parameters
// ----------------------------------------------------


//*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!!!!!!!!!
//Fix the demo mode and remove the (False) 
//*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!!!!!!!!!

READ WRITE:C146([DefaultAccount:32])
Repeat 
	GOTO RECORD:C242([DefaultAccount:32]; 0)
	If (Record number:C243([DefaultAccount:32])=-1)
		CREATE RECORD:C68([DefaultAccount:32])
		
		SAVE RECORD:C53([DefaultAccount:32])
	End if 
Until (Record number:C243([DefaultAccount:32])=0)

C_LONGINT:C283($k)
ALL RECORDS:C47([DefaultAccount:32])
$k:=Records in table:C83([DefaultAccount:32])
If ($k>0)
	SELECTION TO ARRAY:C260([DefaultAccount:32]; aTmpLong1)
	For ($i; $k; 1; -1)
		If (aTmpLong1{$i}#0)
			GOTO RECORD:C242([DefaultAccount:32]; aTmpLong1{$i})
			DELETE RECORD:C58([DefaultAccount:32])
		End if 
	End for 
End if 


ControlRecCheck

GOTO RECORD:C242([DefaultAccount:32]; 0)

If ([DefaultAccount:32]rs1t:68=0)  //bypass registration issues
	[DefaultAccount:32]rs1t:68:=111111111
	SAVE RECORD:C53([DefaultAccount:32])
End if 


READ ONLY:C145([DefaultAccount:32])
UNLOAD RECORD:C212([Admin:1])
UNLOAD RECORD:C212([DefaultAccount:32])

vDiaCom:=""
SET WINDOW TITLE:C213(Storage:C1525.version.title)
SET ABOUT:C316("About CommerceExpert..."; "jABOUT")  //My_ChangeName
KeyModifierCurrent

dtSYNC:=Char:C90(207)+Char:C90(223)
C_TEXT:C284($tempFold)
C_LONGINT:C283($result)


C_TEXT:C284($docFolder; $aliasPath)

//   https://doc.4d.com/4Dv19/4D/19.1/Folder.301-5652983.en.html

// ### bj ### 20180820_1835  gkgkgk gmgmgm  work this

$old_jitF:=HFS_ParentName(Application file:C491)

// $aliasPath:=System folder(Documents folder)
// RESOLVE ALIAS($aliasPath;$docFolder)


If (Application type:C494#4D Server:K5:6)
	
	//FolderMove
	
	// replaced in Storage_Init
	//
	If (Test path name:C476(Storage:C1525.folder.jitF+"jitCerts")#0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitF+"jitCerts")
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitF+"jitIndex.txt")=0)
		//StructureWrite (Storage.folder.jitF+"jitIndex.txt")
	End if 
	
	If (HFS_Exists(Storage:C1525.folder.jitShip)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitShip; *)
	End if 
	Storage:C1525.folder.jitPrefPath:=Storage:C1525.folder.jitF+"jitPrefs"+Folder separator:K24:12
	If (HFS_Exists(Storage:C1525.folder.jitPrefPath)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitPrefPath; *)
	End if 
	C_TEXT:C284(<>barcodeError)
	C_TEXT:C284(<>barcodeOther)
	<>barCodeErrorSound:=Storage:C1525.folder.jitPrefPath+"barcodes"+Folder separator:K24:12+"barcodeError.wav"
	If (HFS_Exists(<>barcodeErrorSound)#1)
		<>barcodeErrorSound:=""
	End if 
	<>barcodeOther:=""
	If (HFS_Exists(Storage:C1525.folder.jitPrefPath+"barcodes"+Folder separator:K24:12+"barcodePreCode.txt")=1)
		myDoc:=Open document:C264(Storage:C1525.folder.jitPrefPath+"barcodes"+Folder separator:K24:12+"barcodePreCode.txt")
		$thePrefs:=""
		If (OK=1)
			<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
			RECEIVE PACKET:C104(myDoc; $thePrefs; <>vEoF)
			<>barcodeOther:=""  //needs to read in a value
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
	
	
	
	
	//
	Case of 
		: (HFS_Exists(Storage:C1525.folder.jitPrefPath+"jitBuffer.txt")=0)
			myDoc:=Create document:C266(Storage:C1525.folder.jitPrefPath+"jitBuffer.txt")
			SEND PACKET:C103(myDoc; "1"+"\r")
			CLOSE DOCUMENT:C267(myDoc)
			<>doFlushBuffers:=True:C214
		Else 
			C_TEXT:C284($theStr)
			myDoc:=Open document:C264(Storage:C1525.folder.jitPrefPath+"jitBuffer.txt")
			RECEIVE PACKET:C104(myDoc; $theStr; "\r")
			CLOSE DOCUMENT:C267(myDoc)
			<>doFlushBuffers:=($theStr="0")
	End case 
	If (HFS_Exists(Storage:C1525.folder.jitForms)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitForms; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitDefaults)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitDefaults; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitLtrF)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitLtrF; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitScripts)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitScripts; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitQRsF)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitQRsF; *)
		//Storage.folder.jitQRsF:=Storage.folder.jitF
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitDebug)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitDebug; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitFaxF)=0)
		Storage:C1525.folder.jitFaxF:=Storage:C1525.folder.jitF
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitCatalog)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitCatalog; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitLabelsF)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitLabelsF; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitAudits)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitAudits; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitDocs)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitDocs; *)
	End if 
	If (HFS_Exists(Storage:C1525.folder.jitExportsF)=0)
		CREATE FOLDER:C475(Storage:C1525.folder.jitExportsF; *)
	End if 
	ARRAY TEXT:C222(<>aFAX; 0)  //use this to get the FAXes in FAX  in jit Reports
	ARRAY TEXT:C222(<>yFAXCovers; 0)
	
	
	//TRACE
	
	FormatFillArrays
	
	C_BOOLEAN:C305(<>vbFaxServerSelected)
	<>vbFaxServerSelected:=False:C215
	
	//
	ARRAY TEXT:C222(aTCP; 0)
	
End if 