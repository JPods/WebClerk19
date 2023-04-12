//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/14/18, 13:30:04
// ----------------------------------------------------
// Method: EDI_StopOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Script StopOrder.4d 20170214

//<declarations>
//==================================
//  Type variables
//==================================

C_TEXT:C284($vtComment; $vtMyDate; $vtMyMessage; $vtMyName; $vtMyTime)

//==================================
//  Initialize variables
//==================================

$vtComment:=""
$vtMyDate:=""
$vtMyMessage:=""
$vtMyName:=""
$vtMyTime:=""
//</declarations>
QUERY:C277([GenericChild1:90]; [GenericChild1:90]name:3="EDI_STOP_ORDER@"; *)
QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]purpose:4=[Order:3]customerPO:3; *)
QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]a01:40=[Order:3]customerid:1; *)
QUERY:C277([GenericChild1:90])

If (Records in selection:C76([GenericChild1:90])>0)
	FIRST RECORD:C50([GenericChild1:90])
	If ([Order:3]status:59="")  //don't overwrite previous Error Status
		[Order:3]status:59:="STOP ORDER"
	End if 
	If ([GenericChild1:90]a05:38#"")
		[Order:3]alertMessage:80:=[GenericChild1:90]a05:38+"\r\r"
	Else 
		[Order:3]alertMessage:80:="PO: "+[Order:3]customerPO:3+" Cancelled by Customer\r\r"
	End if 
	
	//Script Sales Order Comment
	$vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
	$vtMyDate:=String:C10(Current date:C33; 4)
	$vtMyMessage:=" Order "+String:C10([Order:3]orderNum:2)+" stopped by "
	$vtMyName:=[GenericChild1:90]a02:41
	$vtComment:=$vtMyDate+": "+$vtMyTime+"; "+$vtMyMessage+$vtMyName+Char:C90(13)
	[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; $vtComment; 0)
	//Order is saved later in EDI Process
	
	[GenericChild1:90]bool01:12:=True:C214
	[GenericChild1:90]d02:25:=Current date:C33
	[GenericChild1:90]h02:31:=Current time:C178
	[GenericChild1:90]a06:39:="Purchase Order "+[Order:3]customerPO:3+" Received "+String:C10([GenericChild1:90]d02:25)+" - "+String:C10([GenericChild1:90]h02:31)
	SAVE RECORD:C53([GenericChild1:90])
	
	If ([Order:3]profile4:103#"@HLD@")
		[Order:3]profile4:103:="HLD "+[Order:3]profile4:103
	End if 
	
	// Create Profile Record
	$viTableNum:=Table:C252(->[Order:3])
	$vtDocAlphaID:=String:C10([Order:3]orderNum:2)
	$vtName:="HOLD"
	$vtValue:="STOP ORDER"
	$viResult:=AddProfile($viTableNum; $vtDocAlphaID; $vtName; $vtValue; $vtComment)
	
End if 

REDUCE SELECTION:C351([GenericChild1:90]; 0)
REDUCE SELECTION:C351([Profile:59]; 0)
