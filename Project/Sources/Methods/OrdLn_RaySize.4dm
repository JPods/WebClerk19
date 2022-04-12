//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-04T00:00:00, 14:49:39
// ----------------------------------------------------
// Method: OrdLn_RaySize
// Description
// Modified: 02/04/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)  //initialize all arrays
C_BOOLEAN:C305(<>doStacks)
Case of 
	: ($1=0)  //
		OrdLnRays(0)
	: ($1=2)  //fill arrays with record values
		//SELECTION TO ARRAY([POLine]QtyOrdered;aPOQtyOrder;[POLines    
	: ($1=-1)  //subtract elements
		//$2  --  aPOLineAction - the position and number of elements
		Ray_DeleteElems($2; $3; ->aoLineAction; ->aOLineNum; ->aOItemNum; ->aOAltItem; ->aOQtyOrder; ->aOQtyShip; ->aOQtyBL; ->aODescpt; ->aOUnitPrice; ->aODscntUP; ->aODiscnt; ->aOPQDIR; ->aOExtPrice; ->aOUnitCost; ->aOTaxCost; ->aOPrintThis)
		Ray_DeleteElems($2; $3; ->aOExtCost; ->aOBackLog; ->aOTaxable; ->aOSaleTax; ->aOSaleComm; ->aOSalesRate; ->aORepComm; ->aORepRate; ->aOUnitMeas; ->aOUnitWt; ->aOExtWt; ->aOLocation; ->aOLnCmplt; ->aOQtyCanceled; ->aoShipOrdSt)
		Ray_DeleteElems($2; $3; ->aOQtyOpen; ->aOSerialRc; ->aOSerialNm; ->aOSeq; ->aOPricePt; ->aoDateReq; ->aoDateShipOn; ->aoDateShipped; ->aoProdBy; ->aoLnComment; ->aoProfile1; ->aoProfile2; ->aoProfile3; ->aoUniqueID; ->aoLocationBin)
	: ($1=1)  //add an element
		Ray_InsertElems($2; $3; ->aoLineAction; ->aOLineNum; ->aOItemNum; ->aOAltItem; ->aOQtyOrder; ->aOQtyShip; ->aOQtyBL; ->aODescpt; ->aOUnitPrice; ->aODiscnt; ->aODscntUP; ->aOPQDIR; ->aOExtPrice; ->aOUnitCost; ->aOTaxCost; ->aOPrintThis)
		Ray_InsertElems($2; $3; ->aOExtCost; ->aOBackLog; ->aOTaxable; ->aOSaleTax; ->aOSaleComm; ->aOSalesRate; ->aORepComm; ->aORepRate; ->aOUnitMeas; ->aOUnitWt; ->aOExtWt; ->aOLocation; ->aOLnCmplt; ->aOQtyCanceled; ->aoShipOrdSt)
		Ray_InsertElems($2; $3; ->aOQtyOpen; ->aOSerialRc; ->aOSerialNm; ->aOSeq; ->aOPricePt; ->aoDateReq; ->aoDateShipOn; ->aoDateShipped; ->aoProdBy; ->aoLnComment; ->aoProfile1; ->aoProfile2; ->aoProfile3; ->aoUniqueID; ->aoLocationBin)
		aoUniqueID{$2}:=-3  // must be -3 to be saved
	: ($1=3)  //fill record values from arrays 
		READ WRITE:C146([OrderLine:49])
		// TRACE
		C_TEXT:C284($errorText)
		$errorText:=""
		If (Size of array:C274(aoLinesDelete)>0)
			$k:=Size of array:C274(aoLinesDelete)
			For ($i; 1; $k)
				QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoLinesDelete{$i})
				Case of 
					: (Locked:C147([OrderLine:49]))
						$errorText:="Delete line locked: "+String:C10(aoLinesDelete{$i})+"\r"
					: (Records in selection:C76([OrderLine:49])=0)
						$errorText:="Delete line missing: "+String:C10(aoLinesDelete{$i})+"\r"
					: (Records in selection:C76([OrderLine:49])>1)
						$errorText:="Delete line multiples: "+String:C10(aoLinesDelete{$i})+"\r"
					Else 
						DELETE RECORD:C58([OrderLine:49])
				End case 
				If ($errorText#"")
					ConsoleMessage($errorText)
				End if 
			End for 
		End if 
		ARRAY LONGINT:C221(aoLinesDelete; 0)
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		C_LONGINT:C283($diffRecCnt)
		$k:=Size of array:C274(aOLineNum)
		$diffRecCnt:=Records in selection:C76([OrderLine:49])-$k
		If ($diffRecCnt#0)
			$errorText:="Line count difference: "+String:C10($k)+"\r"
		End if 
		
		For ($i; 1; $k)
			If (<>doStacks)
				StackOrderLines(2; aoUniqueID{$i})
			Else 
				QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoUniqueID{$i})
			End if 
			Case of 
				: (Locked:C147([OrderLine:49]))
					$errorText:="Delete line locked: "+String:C10(aoUniqueID{$i})+"\r"
				: (Records in selection:C76([OrderLine:49])=0)
					//$errorText:="Delete line missing: "+String(aoUniqueID{$i})+"\r"
					CREATE RECORD:C68([OrderLine:49])
					OrdLn_RecordFill($i)
				: (Records in selection:C76([OrderLine:49])>1)
					$errorText:="Delete line multiples: "+String:C10(aoUniqueID{$i})+"\r"
				Else 
					OrdLn_RecordFill($i)
			End case 
		End for 
		
	: ($1=-11)  //fill record values from array
		SORT ARRAY:C229(aOSeq; aoLineAction; aOLineNum; aOItemNum; aOAltItem; aOQtyOrder; aOQtyShip; aOQtyBL; aODescpt; aOUnitPrice; aODscntUP; aODiscnt; aOPQDIR; aOExtPrice; aOUnitCost; aOTaxCost; aOPrintThis; aOExtCost; aOBackLog; aOTaxable; aOSaleTax; aOSaleComm; aOSalesRate; aORepComm; aORepRate; aOUnitMeas; aOUnitWt; aOExtWt; aOLocation; aOLnCmplt; aOQtyCanceled; aoShipOrdSt; aOQtyOpen; aOSerialRc; aOSerialNm; aOPricePt; aoDateReq; aoDateShipOn; aoDateShipped; aoProdBy; aoLnComment; aoProfile1; aoProfile2; aoProfile3; aoUniqueID; aoLocationBin)
End case 