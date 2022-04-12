//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:39:16
// ----------------------------------------------------
// Method: OrdLnFillRays
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


//Procedure: OrdLnFillRays
//Procedure: RqOrdLnFillRays  check this before changing

//Procedure: OrdLnFillRays
//Procedure: RqOrdLnFillRays  check this before changing
//unload record([Customer])
//UNLOAD RECORD([Order])
//UNLOAD RECORD([Invoice])

C_LONGINT:C283($lnTest; $i; $cntLines)
C_BOOLEAN:C305(vnotLocked)  //
C_REAL:C285($boxCnt)

//If (Count parameters=2)
//$doByOrdLinesRecords:=True
//Else 
//$doByOrdLinesRecords:=False
//End if 

//If ($doByOrdLinesRecords)
//QUERY([OrdLine];[OrdLine]OrderNum=[Order]OrderNum)
//SELECTION TO ARRAY(
//Else 
C_BOOLEAN:C305(<>doOrderLines; <>doStacks; $linerecordlocked)

C_LONGINT:C283($cntOrderStack; $incOrderStack)
If (<>doStacks)
	
End if 
READ WRITE:C146([OrderLine:49])
//If (false)  // only search if you are not in an order
QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2; *)
// don't display non printing lines when packing orders.
// QUERY([OrderLine]; & ;[OrderLine]PrintNot=0;*)  //this was hiding lines on the orders input layout
// was causing confusion in shipping
QUERY:C277([OrderLine:49])

C_OBJECT:C1216($obRec; $obSel)
C_COLLECTION:C1488($cSelection)
$obSel:=ds:C1482.OrderLine.query("orderNum = :1"; [Order:3]orderNum:2)

// ### jwm ### 20180516_1113  limit lines or sort lines 
If (Current form name:C1298="packing")
	ORDER BY:C49([OrderLine:49]; [OrderLine:49]dateRequired:23; >)
End if 

//End if 
$cntLines:=Records in selection:C76([OrderLine:49])
vResponse:=""  // setup for locked record message
OrdLnRays($cntLines)
FIRST RECORD:C50([OrderLine:49])
For ($i; 1; $cntLines)
	OrderLineArrayElementFill($i)
	//
	aOOgItem{$i}:=aOItemNum{$i}  //test rays
	aOOgQOrd{$i}:=aOQtyOrder{$i}
	aOOgQShip{$i}:=aOQtyShip{$i}
	aOOgCancel{$i}:=aOQtyCanceled{$i}
	aOOgBLQ{$i}:=aOQtyBL{$i}
	aOOgLine{$i}:=aOLineNum{$i}
	//
	$boxCnt:=$boxCnt+aOQtyBL{$i}
	If (Locked:C147([OrderLine:49]))
		$linerecordlocked:=True:C214
		vResponse:="Line Record is locked, no changes can be made."
		LockedNotice(->[OrderLine:49]; "OrderLine is Locked.")  // ### jwm ### 20160318_1049
		vnotLocked:=False:C215
	End if 
	If ((<>doStacks) & (vnotLocked))  // ??????  vnotLocked is used in the.  Idea of stacks not completed
		StackOrderLines(1)  // build stack
	End if 
	NEXT RECORD:C51([OrderLine:49])
End for 

//End if 
viOrdLnCnt:=MaxValueInArray(->aOLineNum)
viBoxCnt:=Round:C94($boxCnt; 0)
aoLineAction:=Size of array:C274(aoLineAction)
If (Size of array:C274(aoSeq)>1)
	OrdLn_RaySize(-11)
End if 