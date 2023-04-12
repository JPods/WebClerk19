//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/21/10, 09:53:20
// ----------------------------------------------------
// Method: Prs_DisplaySelected
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	C_LONGINT:C283($fia)
	C_POINTER:C301($ptOrgFile)
	
	myOK:=0
	$fia:=Size of array:C274(<>aPrsName)
	<>aPrsName{$fia}:=Substring:C12(<>aPrsName{$fia}+"-"+Table name:C256(<>ptCurTable); 1; 20)
	//Process_Running 
	C_POINTER:C301($ptCurTable)
	$ptCurTable:=<>ptCurTable
	
	C_LONGINT:C283($Process)
	C_TEXT:C284($User; $Session; $Name)
	
	READ WRITE:C146($ptCurTable->)
	
	If (Locked:C147($ptCurTable->))
		LOCKED BY:C353($ptCurTable->; $Process; $User; $Session; $Name)
		If ((Current user:C182=$User) | ($User=""))
			// BRING TO FRONT($Process)
			// $doDisplay:=0
			// fixthis
			
			$doDisplay:=1
		Else 
			$doDisplay:=1
			//ALERT(Table name($ptCurTable)+" locked by: "+$User+"\r"+"Session: "+$Session+"\r"+"Process: "+$Name+"\r"+$theNotice)
			// vResponse:=vResponse+("\r"*(Num(vResponse#"")))+(Table name($ptCurTable))+" locked by: "+$User+"\r"+"Session: "+$Session+"\r"+"Process: "+$Name+"\r"+$theNotice+"\r"
			
		End if 
	Else 
		$doDisplay:=1
	End if 
	If ($doDisplay=1)
		
		WindowOpenTaskOffSets
		
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
		//Open window(4;40;635;475;8)
		$ptOrgFile:=ptCurTable
		If (<>vbSortOnDisplay)
			If (ptCurTable#(->[TallyMaster:60]))
				Execute_TallyMaster(Table name:C256(ptCurTable); "DefaultSort"; 1)
			End if 
			If (False:C215)
				Case of 
					: (ptCurTable=(->[Order:3]))
						ORDER BY:C49([Order:3]; [Order:3]dateDocument:4; <)
						booSorted:=True:C214
					: (ptCurTable=(->[Invoice:26]))
						ORDER BY:C49([Invoice:26]; [Invoice:26]dateDocument:35; <)
						booSorted:=True:C214
					: (ptCurTable=(->[Proposal:42]))
						ORDER BY:C49([Proposal:42]; [Proposal:42]dateDocument:3; <)
						booSorted:=True:C214
					: (ptCurTable=(->[Payment:28]))
						ORDER BY:C49([Payment:28]; [Payment:28]dateDocument:10; <)
						booSorted:=True:C214
				End case 
			End if 
		End if 
		
		Case of 
			: ((ptCurTable=(->[Default:15])) | (ptCurTable=(->[WebClerk:78])) | (ptCurTable=(->[Admin:1])))
				MenuReset(iLoMenu)
			: ((Records in selection:C76(ptCurTable->)=1) & (<>vDisplaySingle))
				MenuReset(iLoMenu)
			Else   // : (Records in selection(ptCurTable->)>1)
				MenuReset(oLoMenu)
		End case 
		
		
		MESSAGES OFF:C175
		MODIFY SELECTION:C204(ptCurTable->)
		MESSAGES ON:C181
		While (($ptOrgFile#ptCurTable) & (Records in selection:C76(ptCurTable->)>0))  //for Join calls
			$ptOrgFile:=ptCurTable
			MODIFY SELECTION:C204(ptCurTable->)
		End while 
		CLEAR VARIABLE:C89(vItemPict)
		
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	End if 
End if 