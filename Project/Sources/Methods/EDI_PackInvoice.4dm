//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/26/16, 16:15:29
// ----------------------------------------------------
// Method: EDI_PackInvoice
// Description
// 
//
// Parameters
// ----------------------------------------------------


// Script PackInvoice.4d 20140227

C_LONGINT:C283(viWtPrecision)
C_REAL:C285(vR3)
C_TEXT:C284(vtComment; vtMyDate; vtMyMessage; vtMyName; vtMyTime)
C_TIME:C306(vhElapsed; vhEnd; vhStart)

iLoInteger1:=0
viWtPrecision:=3

vhStart:=Current time:C178

If ([GenericParent:89]Bool03:17)  // ERROR / FAIL
	// DO NOTHING
	[GenericParent:89]T01:64:=[GenericParent:89]T01:64+"ERROR: PackInvoice.4d "+[GenericParent:89]A03:60+"\r"
Else 
	
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[GenericParent:89]LI04:8)
	srso:=[Order:3]orderNum:2
	PKArrayManage(0)  // initialize arrays
	PkOrderLoad([Order:3]orderNum:2; 0)
	
	PKInvoice
	
	// ### jwm ### 20170507_2345 protect against no last Invoice record
	If (<>aLastRecNum{26}>0)
		GOTO RECORD:C242([Invoice:26]; <>aLastRecNum{26})
	Else 
		REDUCE SELECTION:C351([Invoice:26]; 0)
	End if 
	
	If (Records in selection:C76([Invoice:26])=1)
		[GenericParent:89]T01:64:=[GenericParent:89]T01:64+"InvoiceNum =  "+String:C10([Invoice:26]invoiceNum:2)+"\r"
		[GenericParent:89]A06:63:=String:C10([Invoice:26]invoiceNum:2)
		[GenericParent:89]LI03:7:=[Invoice:26]invoiceNum:2
		[Invoice:26]shipFreightCost:15:=vR3  // sum of Freight Cost
		vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
		vtMyDate:=String:C10(Current date:C33; 4)
		vtMyMessage:="945 Invoice "+String:C10([Invoice:26]invoiceNum:2)+" Created by "
		vtMyName:=(Current user:C182)
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyMessage+vtMyName+Char:C90(13)
		[Invoice:26]commentProcess:73:=Insert string:C231([Invoice:26]commentProcess:73; vtComment; 0)
		If ([Invoice:26]profile4:83#"@945@")
			[Invoice:26]profile4:83:=[Invoice:26]profile4:83+"945 "
		End if 
		acceptInvoice
		ELog_NewRecMsg(0; "TIOI"; "Order "+String:C10([GenericParent:89]LI04:8)+" Invoiced to "+String:C10([Invoice:26]invoiceNum:2)+"\r")
		
		If (Records in selection:C76([Order:3])=1)  // verify order selected
			
			[Order:3]profile4:103:=Replace string:C233([Order:3]profile4:103; "P32"; "P33")
			[Order:3]profile4:103:=Replace string:C233([Order:3]profile4:103; "PCK "; "")
			If ([Order:3]completeID:83=2)
				[Order:3]status:59:=Replace string:C233([Order:3]status:59; "Confirmed"; "Completed")
			Else 
				[Order:3]status:59:=Replace string:C233([Order:3]status:59; "Confirmed"; "Invoiced")
			End if 
			
			vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
			vtMyDate:=String:C10(Current date:C33; 4)
			vtMyMessage:="945 Invoice "+String:C10([Invoice:26]invoiceNum:2)+" Created by "
			vtMyName:=(Current user:C182)
			vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyMessage+vtMyName+Char:C90(13)
			[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
			If ([Order:3]profile4:103#"@945@")
				[Order:3]profile4:103:=[Order:3]profile4:103+"945 "
			End if 
			
			SAVE RECORD:C53([Order:3])
		End if 
		
	Else 
		[GenericParent:89]T01:64:=[GenericParent:89]T01:64+"Error: Invoice not found\r"
	End if 
	UNLOAD RECORD:C212([Invoice:26])
End if 

SAVE RECORD:C53([GenericParent:89])


vhEnd:=Current time:C178
vhElapsed:=vhEnd-vhStart
[GenericParent:89]H02:46:=vhElapsed
SAVE RECORD:C53([GenericParent:89])
