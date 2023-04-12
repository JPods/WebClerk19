//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/24/10, 09:47:46
// ----------------------------------------------------
// Method: Records_Out
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Export"))
	C_LONGINT:C283($i; $o; $k; $3; $err; $4)  //$2>0 all, no confirm; $2<0 all, confirm
	C_POINTER:C301($1; $ptTable)
	C_TEXT:C284($2)
	//
	C_TEXT:C284($fileName)
	$confirm:=0
	$fileName:=""
	If (Count parameters:C259>0)  //###_jwm_###
		$ptTable:=$1
		If (Count parameters:C259>1)
			$fileName:=$2
			If (Count parameters:C259>2)
				$confirm:=$3
				If (Count parameters:C259>3)
					If ($4=0)
						ALL RECORDS:C47($ptTable->)
					End if 
				End if 
			End if 
		End if 
	Else 
		$confirm:=1  //skip naming
		ALL RECORDS:C47([TechNote:58])
		$ptTable:=(->[TechNote:58])
	End if 
	If ($fileName="")
		C_LONGINT:C283($result)
		$inc:=1
		Repeat 
			$incString:=Num:C11($inc>1)*(String:C10($inc))
			//myDocName:=Storage.folder.jitExports+String(Table($ptTable);"000")+"Recs_"+Date_strYrMmDd +$incString+".out"
			// ### jwm ### 20180725_1508
			myDocName:=Storage:C1525.folder.jitExports+String:C10(Table:C252($ptTable); "000")+"_"+Table name:C256($ptTable)+"_"+Date_strYrMmDd+$incString+".out"
			$result:=Test path name:C476(myDocName)
			$inc:=$inc+1
		Until ($result<0)
		$confirm:=1
	Else 
		myDocName:=$fileName
	End if 
	$k:=Records in selection:C76($ptTable->)
	If ($k>0)
		OK:=0
		Case of 
			: ($confirm=-1)  //Path is what we want and do not want to test it.
				OK:=1
			: ($confirm=0)
				$myOK:=EI_CreateDoc(->myDocName; ->myDoc; myDocName; ".out")
				If ($myOK=1)
					OK:=1
					CLOSE DOCUMENT:C267(myDoc)
					//$err:=HFS_Delete (document)
					// Modified by: williamjames 110203  Should not be here. The document should exit and be empty)
					
					myDocName:=document
				Else 
					OK:=0
				End if 
			Else 
				OK:=1
		End case 
		If (OK=1)
			//ThermoInitExit ("Exporting";$k;True)
			
			$viProgressID:=Progress New
			
			SET CHANNEL:C77(10; myDocName)
			
			// ### jwm ### 20180725_1433 send record count
			C_LONGINT:C283($RecordCount)
			$RecordCount:=$k
			SEND VARIABLE:C80($RecordCount)
			
			FIRST RECORD:C50($ptTable->)
			For ($i; 1; $k)
				//Thermo_Update ($i)
				ProgressUpdate($viProgressID; $i; $k; "Exporting Records:")
				
				If (<>ThermoAbort)
					$i:=$k
				End if 
				SEND RECORD:C78($ptTable->)
				If ($k>1)
					NEXT RECORD:C51($ptTable->)
				End if 
			End for 
			SET CHANNEL:C77(11)
			Progress QUIT($viProgressID)
			
			
			$theFolder:=HFS_ParentName(myDocName)
			PathLaunchFolder($theFolder)
			// Modified by: williamjames 110203  Should not be here. The document should exit and be empty)
			If (False:C215)
				App_SetSuffix("out")
				If (Is macOS:C1572)
					C_BOOLEAN:C305($isLocked; $isInvisible)
					C_DATE:C307($dateCreated; $dateModified)
					C_TIME:C306($timeCreated; $timeModified)
					GET DOCUMENT PROPERTIES:C477(document; $isLocked; $isInvisible; $dateCreated; $timeCreated; $dateModified; $timeModified)
					
					
					
				End if 
				//Thermo_Close 
			End if 
		End if 
	End if 
End if 
