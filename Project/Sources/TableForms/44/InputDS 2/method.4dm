// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/22/10, 10:26:42
// ----------------------------------------------------
// Method: Form Method: [SpecialDiscount]iSpecDscnts_9
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
$doMore:=False:C215
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		$doMore:=True:C214
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([SpecialDiscount:44]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
		
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[SpecialDiscount:44])
	//
	
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			iLoReturningToLayout:=False:C215
			$doMore:=True:C214
			
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			[SpecialDiscount:44]commission:9:=100
			If ([SpecialDiscount:44]idNum:4=0)
				
			End if 
			iLoRecordNew:=False:C215
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			iLoRecordChange:=False:C215
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		If (([SpecialDiscount:44]priceBase:8<1) | ([SpecialDiscount:44]priceBase:8>5))  //###_jwm_### 20110220 was 4 and did not allow for 5 = MSRP
			[SpecialDiscount:44]priceBase:8:=1
		End if 
		QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
		Disc_ArraysDo(Records in selection:C76([ItemDiscount:45]))
		If ($formEvent=On Load:K2:1)
			
		Else 
			////  --  CHOPPED  AL_UpdateArrays (eItemDis;-2)   //inside QQSetColor
			QQSetColor(eItemDis; ->aSdItemNum)  //###_jwm_### 20101122
		End if 
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	If ([ItemDiscount:45]specialDiscountsid:1=0)
		[ItemDiscount:45]specialDiscountsid:1:=[SpecialDiscount:44]idNum:4
	End if 
	If (([SpecialDiscount:44]perCent:5) & (Modified record:C314([ItemDiscount:45])))
		BEEP:C151
	End if 
	booAccept:=True:C214
End if 
