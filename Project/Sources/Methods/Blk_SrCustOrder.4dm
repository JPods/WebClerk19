//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 01:44:39
// ----------------------------------------------------
// Method: Blk_SrCustOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2)
C_LONGINT:C283(bChangeRec; $w; $tempB1)
C_POINTER:C301($ptCurFile)
C_BOOLEAN:C305($save)
If (Modified record:C314([Customer:2]))
	$ptCurFile:=ptCurTable
	ptCurTable:=(->[Customer:2])
	$save:=jConfirmSave(True:C214; True:C214)
	If ($save)
		SAVE RECORD:C53([Customer:2])
	End if 
	ptCurTable:=$ptCurFile
End if 
Case of 
	: (aCondAction>3)  //    // zzzqqq jCapitalize1st ($1)
		$2->:=$1->
	: ((aCondAction=1) | (aCondAction=3))
		$tempB1:=b1
		jSrchCustLoad(->[Customer:2]; $2; $1)
		b1:=$tempB1
		If (b10=1)  //
			REDUCE SELECTION:C351([Order:3]; 0)
		Else 
			QUERY:C277([Order:3]; [Order:3]customerID:1=srAcct; *)
			If (b37=0)
				QUERY:C277([Order:3]; [Order:3]flow:134>1; *)  // flow 2, 3 or 4 seem to designate a commission order
			End if 
			If (b1=1)  //
				QUERY:C277([Order:3];  & [Order:3]amountBackLog:54#0; *)
			End if 
			QUERY:C277([Order:3])
		End if 
		booPreNext:=True:C214
		doSearch:=10
	: (aCondAction=2)
		jSrchCustLoad(->[Customer:2]; $2; $1)
		//    SetAreaSort (eListOrders;4;1)
		$w:=Find in array:C230(aOrdCustAcc; [Customer:2]customerID:1)
		If ($w<1)
			BEEP:C151
			BEEP:C151
		Else 
			// -- AL_SetScroll(eListOrders; $w; 1)
			ARRAY LONGINT:C221(aRayLines; 1)
			aRayLines{1}:=$w
			// -- AL_SetSelect(eListOrders; aRayLines)
		End if 
		srPhone:=[Customer:2]phone:13
		srZip:=[Customer:2]zip:8
		srCustomer:=[Customer:2]company:2
		srAcct:=[Customer:2]customerID:1
End case 