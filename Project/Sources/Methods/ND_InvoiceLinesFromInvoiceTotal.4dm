//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-17T00:00:00, 23:40:02
// ----------------------------------------------------
// Method: ND_InvoiceLinesFromInvoiceTotal
// Description
// Modified: 09/17/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($k; $i)
QUERY:C277([Item:4]; [Item:4]itemNum:1="ConvertDueToLine")
If (Records in selection:C76([Item:4])=0)
	CREATE RECORD:C68([Item:4])
	CounterNew(->[Item:4])
	[Item:4]itemNum:1:="ConvertDueToLine"
	[Item:4]description:7:="Convert New Data by Amount Due"
	[Item:4]qtySaleDefault:15:=1
	[Item:4]salesGlAccount:21:="SalesGL"
	[Item:4]costGLAccount:22:="CostGL"
	[Item:4]inventoryGlAccount:23:="InventoryGL"
	[Item:4]type:26:="Admin"
	SAVE RECORD:C53([Item:4])
End if 
$k:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
For ($i; 1; $k)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
	If (Records in selection:C76([InvoiceLine:54])=0)
		IvcLn_RaySize(0; 0; 0)
		If ([Item:4]itemNum:1#"ConvertDueToLine")
			QUERY:C277([Item:4]; [Item:4]itemNum:1="ConvertDueToLine")
		End if 
		pPartNum:=[Item:4]itemNum:1
		pDescript:=[Item:4]description:7
		pUnitCost:=[Item:4]costAverage:13
		pQtyOrd:=1
		pQtyShip:=1
		IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; False:C215)
		
		aiDescpt{aiLineAction}:=[Item:4]description:7
		aiUnitPrice{aiLineAction}:=[Invoice:26]total:18
		pBasePrice:=[Invoice:26]total:18
		pUnitPrice:=[Invoice:26]total:18
		vLineMod:=True:C214
		IvcLnExtend(aiLineAction)
		
		vMod:=True:C214
		acceptInvoice
	End if 
	NEXT RECORD:C51([Invoice:26])
End for 

DELETE SELECTION:C66([Invoice:26])

C_LONGINT:C283($k; $i)
$k:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
For ($i; 1; $k)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
	
	vMod:=True:C214
	acceptInvoice
	
	NEXT RECORD:C51([Invoice:26])
End for 

C_LONGINT:C283($k; $i)
$k:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
For ($i; 1; $k)
	[Invoice:26]bill2Company:69:=[Invoice:26]company:7
	SAVE RECORD:C53([Invoice:26])
	NEXT RECORD:C51([Invoice:26])
End for 


allowAlerts_boo:=False:C215
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Order:3])
FIRST RECORD:C50([Order:3])
For ($i; 1; $k)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	If (Records in selection:C76([OrderLine:49])=0)
		OrdLn_RaySize(0; 0; 0)
		If ([Item:4]itemNum:1#"ConvertDueToLine")
			QUERY:C277([Item:4]; [Item:4]itemNum:1="ConvertDueToLine")
		End if 
		pPartNum:=[Item:4]itemNum:1
		pDescript:=[Item:4]description:7
		pUnitCost:=[Item:4]costAverage:13
		pQtyOrd:=1
		pQtyShip:=1
		OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
		
		aoDescpt{aoLineAction}:=[Item:4]description:7
		aoUnitPrice{aoLineAction}:=[Order:3]total:27
		pBasePrice:=[Order:3]total:27
		pUnitPrice:=[Order:3]total:27
		vLineMod:=True:C214
		OrdLnExtend(aoLineAction)
		
		vMod:=True:C214
		acceptOrders
	End if 
	NEXT RECORD:C51([Order:3])
End for 
UNLOAD RECORD:C212([Order:3])


allowAlerts_boo:=False:C215
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Order:3])
FIRST RECORD:C50([Order:3])
For ($i; 1; $k)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	If (Records in selection:C76([OrderLine:49])=0)
		OrdLn_RaySize(0; 0; 0)
		If ([Item:4]itemNum:1#"ConvertDueToLine")
			QUERY:C277([Item:4]; [Item:4]itemNum:1="ConvertDueToLine")
		End if 
		pPartNum:=[Item:4]itemNum:1
		pDescript:=[Item:4]description:7
		pUnitCost:=[Item:4]costAverage:13
		pQtyOrd:=1
		pQtyShip:=1
		OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
		
		aoDescpt{aoLineAction}:=pDescript
		aoUnitPrice{aoLineAction}:=[Order:3]total:27
		pBasePrice:=[Order:3]total:27
		pUnitPrice:=[Order:3]total:27
		vLineMod:=True:C214
		OrdLnExtend(aoLineAction)
		
		vMod:=True:C214
		acceptOrders
	End if 
	NEXT RECORD:C51([Order:3])
End for 
UNLOAD RECORD:C212([Order:3])





allowAlerts_boo:=False:C215
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Order:3])
FIRST RECORD:C50([Order:3])
vi11:=112135
For ($i; 1; $k)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
	[Order:3]company:15:=[Customer:2]company:2
	[Order:3]billToCompany:76:=[Customer:2]company:2
	SAVE RECORD:C53([Order:3])
	NEXT RECORD:C51([Order:3])
End for 
UNLOAD RECORD:C212([Order:3])



allowAlerts_boo:=False:C215
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
vi11:=112135
For ($i; 1; $k)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
	[Order:3]customerPO:3:=[OrderLine:49]lineProfile2:46
	SAVE RECORD:C53([Order:3])
	NEXT RECORD:C51([OrderLine:49])
End for 
UNLOAD RECORD:C212([OrderLine:49])


