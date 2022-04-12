//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-30T00:00:00, 15:01:30
// ----------------------------------------------------
// Method: Item_BundleCheck
// Description
// Modified: 07/30/13
// 
// 
//
// Parameters
// ----------------------------------------------------

//  must be changed to adjust create a dInventory

C_TEXT:C284($1)
C_REAL:C285($2; $0)
READ ONLY:C145([Item:4])
QUERY:C277([Item:4]; [Item:4]itemNum:1=$1)
C_REAL:C285($currentQty)
$currentQty:=$2
If (ptCurTable=(->[PO:39]))
	Case of 
		: (([Item:4]qtyBundleBuy:80=0) | ([Item:4]qtyBundleBuy:80=1))  //drop out
			$0:=$2
		: (Records in selection:C76([Item:4])=0)  //drop out
			$0:=$2
		Else 
			If (($2%[Item:4]qtyBundleBuy:80)=0)  //dropped out if zero, avoid divide by zero
				$0:=$2
			Else 
				CONFIRM:C162("Item: "+$1+": Buy Odd Bundle? "+String:C10($2)+"#/"+String:C10([Item:4]qtyBundleBuy:80))
				If (OK=1)
					$0:=$2
				Else 
					$0:=[Item:4]qtyBundleBuy:80
				End if 
			End if 
	End case 
	If ($currentQty#$2)
		
	End if 
	
Else 
	Case of 
		: (([Item:4]qtyBundleSell:79=0) | ([Item:4]qtyBundleSell:79=1))  //drop out
			$0:=$2
		: (Records in selection:C76([Item:4])=0)  //drop out
			$0:=$2
		Else 
			If (($2%[Item:4]qtyBundleSell:79)=0)
				$0:=$2
			Else 
				CONFIRM:C162("Item: "+$1+": Ship Odd Bundle? "+String:C10($2)+"#/"+String:C10([Item:4]qtyBundleSell:79))
				If (OK=1)
					$0:=$2
				Else 
					$0:=[Item:4]qtyBundleSell:79
					
				End if 
			End if 
	End case 
	If ($currentQty#$2)
		
	End if 
End if 





READ WRITE:C146([Item:4])
UNLOAD RECORD:C212([Item:4])
