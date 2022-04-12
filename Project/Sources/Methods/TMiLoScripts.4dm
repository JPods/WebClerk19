//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/15/10, 16:37:17
// ----------------------------------------------------
// Method: Method: TMiLoScripts
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2)
//$1 array on form with TallyMaster Name 
//$2 array with TallyMaster record number

Case of 
	: ($1->>1)
		C_LONGINT:C283($selectedItem)
		$selectedItem:=$1->
		//GOTO RECORD([TallyMaster];$1->{$selectedItem})  //###_jwm_### 20100203 was the name and not the record number
		GOTO RECORD:C242([TallyMaster:60]; $2->{$selectedItem})
		If (Record number:C243([TallyMaster:60])>-1)
			ExecuteText(0; [TallyMaster:60]script:9)  //no confirm
		End if 
	: ($1->=1)
		KeyModifierCurrent
		If (OptKey=1)
			$doChange:=(UserInPassWordGroup("UnlockRecord"))
			If ($doChange)
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="iLoScripts"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252(ptCurTable))
				If (Records in selection:C76([TallyMaster:60])>0)
					ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
				Else 
					CREATE RECORD:C68([TallyMaster:60])
					C_TEXT:C284($uniqueText)
					$uniqueText:=IEA_SaveRecord(->[TallyMaster:60]; 0)  //table pointer; do not save
					[TallyMaster:60]purpose:3:="iLoScripts"
					[TallyMaster:60]tableNum:1:=Table:C252(ptCurTable)
					[TallyMaster:60]name:8:="Enter_Script_Name"
					[TallyMaster:60]publish:25:=Storage:C1525.user.securityLevel
					SAVE RECORD:C53([TallyMaster:60])
					ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
				End if 
			End if 
		End if 
		
		// ### jwm ### 20180418_1634
		If (CmdKey=1)
			CREATE RECORD:C68([TallyMaster:60])
			C_TEXT:C284($uniqueText)
			$uniqueText:=IEA_SaveRecord(->[TallyMaster:60]; 0)  //table pointer; do not save
			[TallyMaster:60]purpose:3:="iLoScripts"
			[TallyMaster:60]tableNum:1:=Table:C252(ptCurTable)
			[TallyMaster:60]name:8:="Enter_Script_Name"
			[TallyMaster:60]publish:25:=Storage:C1525.user.securityLevel
			SAVE RECORD:C53([TallyMaster:60])
			ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
		End if 
		
		TallyMasterPopupScirpts(ptCurTable)
		
	Else 
		
		$1->:=1
End case 

$1->:=1  // ### jwm ### 20180418_1642 always rest the menu
