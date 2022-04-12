//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/10/13, 10:04:59
// ----------------------------------------------------
// Method: QQSetColor_OnServer
// Description
// 
//
// Parameters
// ----------------------------------------------------

//===================================================
//Server Side Process
//===================================================

//ARRAY LONGINT (alRecords;0)
ARRAY TEXT:C222(atColorCode; 0)
ARRAY TEXT:C222(atItemNum; 0)
C_LONGINT:C283(viReady; viCount; viDelay; viTimeOut)
C_LONGINT:C283($i; $k)
C_LONGINT:C283(<>useJims)
C_TEXT:C284(vtStatus)

//vtStatus is not being displayed in message on client and could be removed

viReady:=1
viCount:=0
vtStatus:="Server Ready"
viDelay:=3  //ticks
viTimeOut:=200  //3 ticks / 60 * 200 = 10 seconds


//wait for variables
While ((viReady<2) & (viCount<viTimeOut))
	DELAY PROCESS:C323(Current process:C322; viDelay)
	viCount:=viCount+1
End while 

If (viReady>1)
	vtStatus:="Variables Loaded"
Else 
	vtStatus:="Loading Variables Timed Out"
End if 

//===================================================
//Body of work
//===================================================

$k:=Size of array:C274(atItemNum)
ARRAY TEXT:C222(atColorCode; $k)
For ($i; 1; $k)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=atItemNum{$i})
	//###_jwm_### 20101116 have not decided on whethter or not to use bold for Out of stock
	//###_jwm_### 20101115 changed red from #990000 to #CC0000 (brighter red)
	Case of 
		: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14<=0))  //Retired, Qty less than or = zero
			atColorCode{$i}:="1"  //red on yellow  
		: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14>0))  //Retired, Qty greater than zero
			atColorCode{$i}:="2"  //black on yellow
		: (([Item:4]backOrder:24) & ([Item:4]qtyOnHand:14<=0))  //Backordered, Qty less than or = zero
			atColorCode{$i}:="3"  //red on light gray
		: (([Item:4]backOrder:24) & ([Item:4]qtyOnHand:14>0))  //Backordered, Qty greater than zero
			atColorCode{$i}:="4"  //black on light gray
		: ([Item:4]qtyOnHand:14<=0)  //Qty less than or = zero
			atColorCode{$i}:="5"  //red on white
		Else 
			atColorCode{$i}:="0"  //black on white default color code
	End case 
End for 

UNLOAD RECORD:C212([Item:4])

//===================================================
//End body of work
//===================================================

vtStatus:="waiting for client to retrieve data"
viReady:=3

//wait for client to retrieve data
While ((viReady<4) & (viCount<viTimeOut))
	DELAY PROCESS:C323(Current process:C322; viDelay)
	viCount:=viCount+1
End while 

//Courtesy Message
vtStatus:="Closing Server Process"
//### jwm ### 20130126_1722 removing this helped correct the missing variable error message
//DELAY PROCESS(Current process;60)   
