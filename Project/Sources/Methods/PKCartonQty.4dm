//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/08/18, 11:40:58
// ----------------------------------------------------
// Method: PKCartonQty
// Description
// 
//
// Parameters
// ----------------------------------------------------

//### jwm ### 20130423_1115 added PackingManual autority to Reset Carton Quantity
//### jwm ### 20130423_1150 log change to carton quantity
//### jwm ### 20130423_1337 added Alert No Line Item Selected

C_LONGINT:C283($k)
C_REAL:C285($qtyCarton)
C_TEXT:C284(vResponse)

$k:=Size of array:C274(aoLnSelect)
TRACE:C157
If (UserInPassWordGroup("PackingManual"))  //### jwm ### 20130423_1115
	If ($k>0)
		CONFIRM:C162("Reset Item Carton Quantity ? ")
		If (OK=1)
			$qtyCarton:=Num:C11(Request:C163("Enter Carton Quantity"))
			READ WRITE:C146([Item:4])
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aoLnSelect{1}})
			Case of 
				: ((Records in selection:C76([Item:4])=1) & (Not:C34(Locked:C147([Item:4]))))
					CONFIRM:C162("Change Item "+[Item:4]itemNum:1+"'s Carton Quantity to: "+String:C10($qtyCarton))
					If (OK=1)
						[Item:4]qtyBundleSell:79:=$qtyCarton
						SAVE RECORD:C53([Item:4])
						// update packing Window
						vrQtyBundleSell:=[Item:4]qtyBundleSell:79
						UNLOAD RECORD:C212([Item:4])
						//### jwm ### 20130423_1150 log change to carton quantity
						[Order:3]commentProcess:12:="Carton Quantity Changed "+", "+Current user:C182+", "+String:C10(Current date:C33)+", "+String:C10(Current time:C178)+", "+String:C10($qtyCarton)+", "+aOItemNum{aoLnSelect{1}}+"\r"+[Order:3]commentProcess:12
						SAVE RECORD:C53([Order:3])
					End if 
				: (Records in selection:C76([Item:4])=0)
					ALERT:C41("No Item Record")
				: (Records in selection:C76([Item:4])>1)
					ALERT:C41("Multiple Item Records")
				Else 
					ALERT:C41("Item Record is locked")
			End case 
		End if 
	Else 
		ALERT:C41("No Line Item Selected.")  //### jwm ### 20130423_1337
	End if 
Else 
	ALERT:C41("Must have PackingManual Privileges.")
End if 