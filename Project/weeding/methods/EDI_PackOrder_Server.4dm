//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/26/16, 15:59:01
// ----------------------------------------------------
// Method: EDI_PackOrder_Server
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ===================================================
// Server Side Process
// ===================================================

// initialize local variables
Process_InitLocal
// Register Plugins

// Type Variables
C_BOOLEAN:C305(allowAlerts_boo)
C_LONGINT:C283(viCounter; viIndex; viNum; viReady; viSize; viWtPrecision; vlOrderNum)
C_REAL:C285(<>vrWeightScale; vr1; vR2; vR3; vrWeightScale)
C_TEXT:C284(vText; vText2; vtStatus; vtTitle; vtTrackingNum; vsiteID)

//Initialize Variables
<>vrWeightScale:=0
allowAlerts_boo:=False:C215  // flag as EDI Process
iLoInteger1:=0
viCounter:=0
viIndex:=0
viNum:=0
viReady:=1
viSize:=0
viWtPrecision:=3
vlOrderNum:=0
vText:=""
vText2:=""
vtStatus:="Server Ready"
vtTitle:="Status"
vtTrackingNum:=""

// Type and Initialize Arrays
ARRAY LONGINT:C221(alRecords; 0)
ARRAY TEXT:C222(aText2; 0)
ARRAY REAL:C219(aReal1; 0)
ARRAY LONGINT:C221(aLongInt1; 0)

Licenses


If (False:C215)
	If (Application type:C494<4D Remote mode:K5:5)  //4D Remote Mode
		
		//SuperReport Pro 2.9 / 1 U:
		result:=SR_Register("003794-207229989-7OS77QQ5QSXESSOORO-NMN1DODF-TM-CE9R-ON-ROXA84NQ")
		
		//SuperReport Pro 3 / 1 U:
		result:=SR_Register("003795-207229989-FHAFFNN8ND4RDD5535-VKV26A6L-YL-UK7K-2O-30ZZG7WW")
		
		
	Else 
		
		
		//SuperReport Pro 3 / 255 U:
		result:=SR_Register("003744-509219877-QHNFYN8AAQ45DZ53RR-VKV26A6L-YL-ZAEF-JEEMSS-3HZUGUWB")
		
		
	End if 
End if 


// wait for variables
While ((viReady<2) & (viCounter<18000))  // timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	viCounter:=viCounter+1
End while 

If (viReady>1)
	vtStatus:="Packing Order..."
	<>vrWeightScale:=vrWeightScale
Else 
	vtStatus:="Loading Variables Timed Out"
End if 
// ===================================================
// Body of work
// ===================================================
// CREATE SET FROM ARRAY ([Order];alRecords;"myRecords")
// Use Set("myRecords")
// First Record([Order])

QUERY:C277([Order:3]; [Order:3]idNum:2=vlOrderNum)
srso:=vlOrderNum
PKArrayManage(0)  // initialize arrays
allowAlerts_boo:=False:C215  // second time
PkOrderLoad([Order:3]idNum:2; 0)
vsiteID:=[Order:3]siteID:106  // Make sure that vsiteID matches order (Must be after PkOrderLoad)

// Script PackBox.4d 20140610

iLoInteger1:=0
viWtPrecision:=3

// Barcode Items passed in arrays

viSize:=Size of array:C274(aText2)
If (viSize>0)
	For (viIndex; 1; viSize)
		// test 'barcode' single items to span multiple order lines
		PKBarCodeItem(aReal1{viIndex}; aText2{viIndex}; aLongInt1{viIndex})
	End for 
End if 

// Pack Any Misc. Items into box

ARRAY TEXT:C222(atItemNum; 0)
ARRAY REAL:C219(arQtyShip; 0)
ARRAY LONGINT:C221(alUniqueID; 0)

// Pack Misc. Items (NOT MODELS)
QUERY BY FORMULA:C48([OrderLine:49]; (([OrderLine:49]idNumOrder:1=vlOrderNum) & ([OrderLine:49]itemNum:4=[Item:4]itemNum:1) & ([Item:4]profile1:35#"@model@") & ([OrderLine:49]qtyBackLogged:8#0)))
SELECTION TO ARRAY:C260([OrderLine:49]qtyBackLogged:8; arQtyShip; [OrderLine:49]itemNum:4; atItemNum; [OrderLine:49]idNum:50; alUniqueID)

viSize:=Size of array:C274(atItemNum)
If (viSize>0)
	For (viIndex; 1; viSize)
		PKBarCodeItem(arQtyShip{viIndex}; atItemNum{viIndex}; alUniqueID{viIndex})
	End for 
End if 

PKBoxItemsTags

[LoadTag:88]trackingid:7:=vtTrackingNum
SAVE RECORD:C53([LoadTag:88])
// Reset arrays to the current state of the order. 

PkOrderLoad([Order:3]idNum:2; 0)

UNLOAD RECORD:C212([Order:3])

// ===================================================
// End body of work
// ===================================================

viReady:=3
vtStatus:="waiting for client to retrieve data"

// wait for client to retrieve data
While ((viReady<4) & (viCounter<18000))  // timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	viCounter:=viCounter+1
End while 

// Courtesy Message
vtStatus:="Closing Server Process"
//Delay Process(Current Process;60)
