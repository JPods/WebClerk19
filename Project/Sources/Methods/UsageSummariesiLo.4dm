//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 16:01:38
// ----------------------------------------------------
// Method: UsageSummariesiLo
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
		
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([UsageSummary:33]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		//
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[UsageSummary:33])
		//
		$doMore:=False:C215
		Case of 
			: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
				
				
			: (iLoRecordNew)  //set in iLoProcedure only once, new record
				
				OBJECT SET ENTERABLE:C238([UsageSummary:33]PeriodDate:2; True:C214)
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once, existing record
				
				$doMore:=True:C214
		End case 
		If ($doMore)  //action for the form regardless of new or existing record
			
			grafUsItMon(->[UsageSummary:33]SalesActual:10; ->[UsageSummary:33]SalesPlan:9; ->[UsageSummary:33]InventoryActual:6; ->[UsageSummary:33]CostActual:17; ->[UsageSummary:33]WeightedTurns:25)
			
			
			RELATE MANY:C262([UsageSummary:33]PeriodDate:2)
			Before_New(ptCurTable)  //last thing to do
		End if 
		//every cycle
		
		If ((Modified:C32([UsageSummary:33]SalesPlan:9)) | (Modified:C32([UsageSummary:33]SalesActual:10)) | (Modified:C32([UsageSummary:33]InventoryActual:6)) | (Modified:C32([UsageSummary:33]CostActual:17)) | (Modified:C32([UsageSummary:33]WeightedTurns:25)))
			If ([UsageSummary:33]MarginFactor:15>0)
				[UsageSummary:33]MarginFactor:15:=Round:C94(([UsageSummary:33]SalesActual:10-[UsageSummary:33]CostActual:17)/[UsageSummary:33]SalesActual:10*[UsageSummary:33]AverageTurns:23; 2)
			Else 
				[UsageSummary:33]MarginFactor:15:=0
			End if 
			If ([UsageSummary:33]CostActual:17>0)
				[UsageSummary:33]ActualTurns:24:=Round:C94(([UsageSummary:33]InventoryActual:6/[UsageSummary:33]CostActual:17)*12; 1)
				vDaysOnHand:=Round:C94([UsageSummary:33]InventoryActual:6/[UsageSummary:33]CostActual:17*30; 1)
			Else 
				vDaysOnHand:=1000
				[UsageSummary:33]ActualTurns:24:=0
			End if 
			grafUsItMon(->[UsageSummary:33]SalesActual:10; ->[UsageSummary:33]SalesPlan:9; ->[UsageSummary:33]InventoryActual:6; ->[UsageSummary:33]CostActual:17; ->[UsageSummary:33]WeightedTurns:25)
		End if 
		booAccept:=True:C214
	End if 
End if 
