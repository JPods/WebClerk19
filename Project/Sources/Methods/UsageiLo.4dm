//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:44:58
// ----------------------------------------------------
// Method: UsageiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (UserInPassWordGroup("Archive"))  // ### jwm ### 20151012_1320 was "EditReportScript" copied "Archive from method PasswordGroupAccess
			If (vHere>1)  //coming from another table's input layout
				If (Is new record:C668([Usage:5]))
					$ptLastTable:=ptCurTable
					$fillFromPrevious:=True:C214
				End if 
			End if 
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[Usage:5])
		//
		$doMore:=False:C215
		Case of 
			: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
				
				
			: (iLoRecordNew)  //set in iLoProcedure only once, new record
				
				[Usage:5]itemNum:1:=[Item:4]itemNum:1
				[Usage:5]description:11:=[Item:4]description:7
				//[Usage]UniqueID:=Sequence number([Usage])
				[Usage:5]periodDate:2:=Date:C102(String:C10(Month of:C24(Current date:C33))+"/1/"+String:C10(Year of:C25(Current date:C33)))
				OBJECT SET ENTERABLE:C238([Usage:5]periodDate:2; True:C214)
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once, existing record
				
				viRecordsInSelection:=Records in selection:C76([Ledger:30])
				If ([Usage:5]description:11="")
					If ([Item:4]itemNum:1#[Usage:5]itemNum:1)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=[Usage:5]itemNum:1)
						[Usage:5]description:11:=[Item:4]description:7
						SAVE RECORD:C53([Usage:5])
						UNLOAD RECORD:C212([Item:4])
					Else 
						[Usage:5]description:11:=[Item:4]description:7
					End if 
				End if 
				$doMore:=True:C214
		End case 
		If ($doMore)  //action for the form regardless of new or existing record
			
			If ([Usage:5]costActual:17>0)
				vDaysOnHand:=Round:C94([Usage:5]inventoryActual:6/[Usage:5]costActual:17*30; 1)
			Else 
				vDaysOnHand:=1000
			End if 
			grafUsItMon(->[Usage:5]salesActual:10; ->[Usage:5]salesPlan:9; ->[Usage:5]inventoryActual:6; ->[Usage:5]costActual:17; ->[Usage:5]daysLeadTime:25)
			//REDUCE SELECTION([dInventory];0)
			Before_New(ptCurTable)  //last thing to do
		End if 
		//every cycle
		
		If ((Modified:C32([Usage:5]salesQtyPlan:3)) | (Modified:C32([Usage:5]salesQtyActual:4)) | (Modified:C32([Usage:5]inventoryActual:6)) | (Modified:C32([Usage:5]targetTurns:22)) | (Modified:C32([Usage:5]daysLeadTime:25)))
			If ([Usage:5]inventoryActual:6>0)
				[Usage:5]averageTurns:23:=Round:C94(([Usage:5]costActual:17/[Usage:5]inventoryActual:6)*12; 1)
			Else 
				[Usage:5]averageTurns:23:=0
			End if 
			If ([Usage:5]salesActual:10>0)
				[Usage:5]marginFactor:15:=Round:C94(([Usage:5]salesActual:10-[Usage:5]costActual:17)/[Usage:5]salesActual:10*[Usage:5]averageTurns:23; 2)
			Else 
				[Usage:5]marginFactor:15:=0
			End if 
			vDaysOnHand:=Round:C94([Usage:5]inventoryActual:6/[Usage:5]costActual:17*30; 1)
			grafUsItMon(->[Usage:5]salesActual:10; ->[Usage:5]salesPlan:9; ->[Usage:5]inventoryActual:6; ->[Usage:5]costActual:17; ->[Usage:5]daysLeadTime:25)
		End if 
		booAccept:=True:C214
	End if 
End if 
