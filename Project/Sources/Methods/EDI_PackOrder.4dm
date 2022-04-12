//%attributes = {}
// Script PackOrder 20170427

// Execute_TallyMaster("PackOrder";"Scripts";3)

// ===================================================
// Setup & Initialize Variables, Arrays, User Input
// ===================================================
// ARRAY TEXT (aText2;0)// initialized in Detail_LX.inc
// ARRAY REAL (aReal1;0)// initialized in Detail_LX.inc
// ARRAY LONGINT (aLongInt1;0)// initialized in Detail_LX.inc
// <>vrWeightScale set in Detail_N9_300.inc

C_LONGINT:C283($1; viOrderNum; iLoInteger1; viWtPrecision)
C_TEXT:C284(vText; vText2; vtTrackingNum)
C_REAL:C285(vr1; vR2; vR3; <>vrWeightScale)

viOrderNum:=$1
allowAlerts_boo:=False:C215  // flag as EDI Process

ConsoleMessage("Packing Order...")
//<>vrWeightScale := vrWeightScale no longer passing values to server

srso:=viOrderNum
PKArrayManage(0)  // initialize arrays
PkOrderLoad(viOrderNum; 0)
vsiteID:=[Order:3]siteID:106  // Make sure that vsiteID matches order (Must be after PkOrderLoad)

// Script PackBox.4d 20140610

iLoInteger1:=0
viWtPrecision:=3

// Barcode Items passed in arrays

k:=Size of array:C274(aText2)
If (k>0)
	For (i; 1; k)
		// test 'barcode' single items to span multiple order lines
		PKBarCodeItem(aReal1{i}; aText2{i}; aLongInt1{i})
	End for 
End if 

// Pack Any Misc. Items into box

ARRAY TEXT:C222(atItemNum; 0)
ARRAY REAL:C219(arQtyShip; 0)
ARRAY LONGINT:C221(alUniqueID; 0)

// Pack Misc. Items (NOT MODELS)
QUERY BY FORMULA:C48([OrderLine:49]; (([OrderLine:49]orderNum:1=vlOrderNum) & ([OrderLine:49]itemNum:4=[Item:4]itemNum:1) & ([Item:4]profile1:35#"@model@") & ([OrderLine:49]qtyBackLogged:8#0)))
SELECTION TO ARRAY:C260([OrderLine:49]qtyBackLogged:8; arQtyShip; [OrderLine:49]itemNum:4; atItemNum; [OrderLine:49]idNum:50; alUniqueID)

If (False:C215)
	
	// jit_Custom=jitCustomScript=ItemsSearchVendor & Variable1=AnticaFarm & Variable10=1 & Variable11=Stock & JitPageOne=ItemsListVendorBasic.html
	
	// I would have to look up how to put it into jit_Custom, but you can put it on a page.  "AnticaFarm" can be replaced by an account ID
	//  <!--  _jit_-6_
	// QUERY BY FORMULA([Item];((Variable1="AnticaFarm") & (Variable10="1") & (Variable11="Stock"))
	// jj
	
	QUERY BY FORMULA:C48([Item:4]; (([Item:4]qtyAvailable:73+[Item:4]qtyOnPo:20)<1) & ([Item:4]type:26="Stock@") & ([Item:4]mfrID:53="Allegria"))
	
End if 

k:=Size of array:C274(atItemNum)
If (k>0)
	For (i; 1; k)
		PKBarCodeItem(arQtyShip{i}; atItemNum{i}; alUniqueID{i})
	End for 
End if 

PKBoxItemsTags

[LoadTag:88]trackingid:7:=vtTrackingNum
SAVE RECORD:C53([LoadTag:88])
// Reset arrays to the current state of the order. 

PkOrderLoad([Order:3]orderNum:2; 0)

UNLOAD RECORD:C212([Order:3])
