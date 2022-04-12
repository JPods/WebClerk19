//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/26/16, 17:00:21
// ----------------------------------------------------
// Method: EDI_CheckOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------


//Script CheckOrder.4d 20140219
//ALERT("Script CheckOrder.4d 20140219")
//ALERT("Declaring variables")
C_TEXT:C284(vText; vsiteID)
C_LONGINT:C283(srSO)
//ALERT("Done Declaring variables")
//TRACE
vText:=""
[GenericParent:89]bool02:16:=False:C215  // Locked Order
[GenericParent:89]bool03:17:=False:C215  // ERROR / FAIL

QUERY:C277([Order:3]; [Order:3]orderNum:2=[GenericParent:89]lI04:8)

ConsoleMessage("Records In Selection([Order] = "+String:C10(Records in selection:C76([Order:3])))

Case of 
	: (Records in selection:C76([Order:3])=1)
		If (Locked:C147([Order:3]))
			[GenericParent:89]bool02:16:=True:C214  // Locked Order
			[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			vText:="ERR"
			[GenericParent:89]a03:60:="Locked"
			[GenericParent:89]t01:64:=[GenericParent:89]t01:64+"Order "+String:C10([GenericParent:89]lI04:8)+" is LOCKED\r"
		Else 
			// update status
			[Order:3]profile4:103:=Replace string:C233([Order:3]profile4:103; "P30"; "P31")
			[Order:3]profile4:103:=Replace string:C233([Order:3]profile4:103; "P31"; "P32")
			[Order:3]status:59:=Replace string:C233([Order:3]status:59; "SENT"; "Confirmed")
			SAVE RECORD:C53([Order:3])
			
			// PACKING WINDOW TESTS
			
			If ([Order:3]status:59="@EXCEPTION@")
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status Exception"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If ([Order:3]status:59="@REJECTED@")
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status REJECTED"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If ([Order:3]status:59="@DUPLICATE@")
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status DUPLICATE"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If ([Order:3]terms:23="@VOID@")
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status VOID"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If ([Order:3]status:59="@HOLD@")
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status HOLD"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If ([Order:3]profile4:103="@ERR@")
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status ERR"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If (([Order:3]profile4:103="@P30@") | ([Order:3]profile4:103="@P31@"))
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status PICKED SPARKS"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If ([Order:3]completeid:83=2)
				[GenericParent:89]a03:60:="ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+" Status Completed"
				[GenericParent:89]bool03:17:=True:C214  // ERROR / FAIL
			End if 
			
			If (([GenericParent:89]bool02:16=False:C215) & ([GenericParent:89]bool03:17=False:C215))  // Not Locked Order & Not // ERROR / FAIL 
				[GenericParent:89]a03:60:="Found"
				[GenericParent:89]t01:64:=[GenericParent:89]t01:64+"Order "+String:C10([GenericParent:89]lI04:8)+" Found\r"
				ConsoleMessage("srSO:=[Order]OrderNum")
				srSO:=[Order:3]orderNum:2
				//ALERT("PKArrayManage(0)")
				PKArrayManage(0)  // initialize arrays
				//ALERT("PkOrderLoad ([Order]OrderNum;0)")
				PkOrderLoad([Order:3]orderNum:2; 0)
				//ALERT("vsiteID:=[Order]siteID")
				vsiteID:=[Order:3]siteid:106  // Make sure that vsiteID matches order (Must be after PkOrderLoad)
			End if 
			
		End if 
		
	: (Records in selection:C76([Order:3])=0)
		[GenericParent:89]bool02:16:=False:C215  // Locked Order
		[GenericParent:89]bool03:17:=False:C215  // ERROR / FAIL
		vText:="ERR"
		[GenericParent:89]a03:60:="NOT FOUND"
		[GenericParent:89]t01:64:=[GenericParent:89]t01:64+"ERROR: ORDER "+String:C10([GenericParent:89]lI04:8)+" NOT FOUND\r"
		
	: (Records in selection:C76([Order:3])>1)
		[GenericParent:89]bool02:16:=False:C215  // Locked Order
		[GenericParent:89]bool03:17:=False:C215  // ERROR / FAIL
		vText:="ERR"
		[GenericParent:89]a03:60:="MULTIPLE ORDERS"
		[GenericParent:89]t01:64:=[GenericParent:89]t01:64+"ERROR: ORDER "+String:C10([GenericParent:89]lI04:8)+" MULTIPLES ORDERS\r"
End case 

If ([GenericParent:89]bool03:17)
	[GenericParent:89]t01:64:=[GenericParent:89]t01:64+"ERROR: CheckOrder.4d "+[GenericParent:89]a03:60+"\r"
End if 
