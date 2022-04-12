//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-08T00:00:00, 18:37:12
// ----------------------------------------------------
// Method: ItemPeriodSales
// Description
// Modified: 12/08/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------




C_LONGINT:C283($found)
C_LONGINT:C283($1; $multiprocess)
$multiprocess:=0
If (Count parameters:C259=1)
	$multiprocess:=$1
End if 

$found:=Prs_CheckRunnin("ItemPeriodSales")
KeyModifierCurrent

Case of 
	: ($found<1)
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("ItemPeriodSales"; <>tcPrsMemory; "ItemPeriodSales"; 1)
	: ($multiprocess=1)  // setup the window
		Process_InitLocal
		<>prcControl:=0
		ptCurTable:=(->[Control:1])
		WindowOpenTaskOffSets
		
		ControlRecCheck
		DISABLE MENU ITEM:C150(1; 4)
		FORM SET INPUT:C55([Control:1]; "diaRptItSalesPe")
		ProcessTableOpen(->[Control:1])
		//DIALOG([Item];"diaRptItSalesPe")
		//CLOSE WINDOW
		ARRAY TEXT:C222(aPartNum; 0)
		ARRAY TEXT:C222(aPartDesc; 0)
		ARRAY REAL:C219(aCosts; 0)
		ARRAY REAL:C219(aQtySold; 0)
		ARRAY REAL:C219(aQtyOrd; 0)
		ARRAY REAL:C219(aQtyOnPOLns; 0)
		ARRAY REAL:C219(aQtyOnHand; 0)
		ARRAY LONGINT:C221(aLeadTime; 0)
		ARRAY LONGINT:C221(aFactor; 0)
	Else 
		//: (($found>1) & ($multiprocess=2))
		<>ptCurTable:=ptCurTable
		<>prcControl:=1
		<>processAlt:=New process:C317("ItemPeriodSales"; <>tcPrsMemory; "ItemPeriodSales"; 1)
End case 
//If (Frontmost process#<>aPrsNum{$found})
//BRING TO FRONT(<>aPrsNum{$found})
//End if 
//Else 


