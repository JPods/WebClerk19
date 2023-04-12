
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/25/17, 18:08:40
// ----------------------------------------------------
// Method: [dInventory].Input1
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170525_1808 Note and Reason set to Enterable and tabable
// ### jwm ### 20180301_1044 changed number display format of [dInventory]QtyOHAfterApplied to |0 (whole numbers)

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([DInventory:36]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[DInventory:36])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			$doMore:=True:C214
	End case 
	If ($doMore)
		DateTime_DTFrom([DInventory:36]dtCreated:15; ->vDate1; ->vTime1)
		DateTime_DTFrom([DInventory:36]dtItemCard:16; ->vDate2; ->vTime2)
		DateTime_DTFrom([DInventory:36]dtStack:17; ->vDate3; ->vTime3)
		DateTime_DTFrom([DInventory:36]dtSiteID:34; ->vDate4; ->vTime4)
		Before_New(ptCurTable)
		
	End if 
	booAccept:=True:C214
End if 
