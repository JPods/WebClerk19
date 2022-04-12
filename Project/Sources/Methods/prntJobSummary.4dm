//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-01T00:00:00, 11:25:28
// ----------------------------------------------------
// Method: prntJobSummary
// Description
// Modified: 06/01/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------


READ ONLY:C145([QQQCustomer:2])
READ ONLY:C145([Order:3])
READ ONLY:C145([Service:6])
READ ONLY:C145([Invoice:26])
READ ONLY:C145([PO:39])
READ ONLY:C145([InventoryStack:29])
READ ONLY:C145([Proposal:42])
vOrdNum:=0
vL1:=0
vStr1:=""
vStr2:=""
vStr3:=""
vStr4:=""
vStr5:=""
vi1:=0
FORM SET OUTPUT:C54([Project:24]; "rptJobs")
If (vHere=1)
	PRINT SELECTION:C60([Project:24])
Else 
	jPrntiLoSorted(->[Project:24]; ->curRecNum)
End if 
FORM SET OUTPUT:C54([Project:24]; "oJobs_9")
If (vHere<2)
	UNLOAD RECORD:C212([QQQCustomer:2])
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Service:6])
	UNLOAD RECORD:C212([Invoice:26])
	UNLOAD RECORD:C212([PO:39])
	UNLOAD RECORD:C212([Proposal:42])
End if 
vOrdNum:=0
vi1:=1
vL1:=0
vStr1:=""
vStr2:=""
vStr3:=""
vStr4:=""
vStr5:=""
READ WRITE:C146([QQQCustomer:2])
READ WRITE:C146([Order:3])
READ WRITE:C146([Service:6])
READ WRITE:C146([Invoice:26])
READ WRITE:C146([PO:39])
READ WRITE:C146([Proposal:42])
READ WRITE:C146([InventoryStack:29])