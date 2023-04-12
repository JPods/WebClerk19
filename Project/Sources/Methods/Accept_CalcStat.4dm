//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 12:21:49
// ----------------------------------------------------
// Method: Accept_CalcStat
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k; $status)
C_BOOLEAN:C305($virgin; $complete; $2)  //$2 true for arrays, false for rec/subrecord
C_POINTER:C301($1; $3; $4)  //File; Shipped/Received; BackLog Qty
$virgin:=True:C214
$complete:=True:C214
If ($2)
	//$overShip:=True
	//$overShip:=(((($3{$i}>0)&($4{$i}<0))|(($3{$i}<0)&
	//($4{$i}<$3{$i})))&($overShip))
	$k:=Size of array:C274($4->)
	For ($i; 1; $k)
		$virgin:=(($3->{$i}=0) & ($virgin))
		$complete:=(($4->{$i}=0) & ($complete))
	End for 
Else 
	Case of 
		: ($1=(->[Order:3]))
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			$k:=Records in selection:C76([OrderLine:49])
			FIRST RECORD:C50([OrderLine:49])
			For ($i; 1; $k)
				$virgin:=(([OrderLine:49]qtyShipped:7=0) & ([OrderLine:49]complete:48=False:C215) & ($virgin))
				If (([OrderLine:49]complete:48=False:C215) & ([OrderLine:49]qtyBackLogged:8=0))
					[OrderLine:49]complete:48:=True:C214
				End if 
				$complete:=(([OrderLine:49]complete:48=True:C214) & ($complete))
				Case of 
					: (([OrderLine:49]qtyBackLogged:8#0) & ([OrderLine:49]qtyShipped:7=0) & ([OrderLine:49]complete:48=False:C215))
						[OrderLine:49]dateShipped:39:=!00-00-00!
					: (([OrderLine:49]qtyBackLogged:8#0) & ([OrderLine:49]qtyShipped:7#0))
						[OrderLine:49]dateShipped:39:=!1901-01-01!
					: (([OrderLine:49]complete:48=True:C214) & (([OrderLine:49]dateShipped:39=!00-00-00!) | ([OrderLine:49]dateShipped:39=!1901-01-01!)))
						[OrderLine:49]dateShipped:39:=Current date:C33
				End case 
				NEXT RECORD:C51([OrderLine:49])
			End for 
		: ($1=(->[PO:39]))
			READ WRITE:C146([POLine:40])
			QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
			$k:=Records in selection:C76([POLine:40])
			FIRST RECORD:C50([POLine:40])
			LOAD RECORD:C52([POLine:40])
			For ($i; 1; $k)
				If (([POLine:40]qtyBackLogged:5=0) & ([POLine:40]complete:25=""))
					[POLine:40]complete:25:="x"
				End if 
				$virgin:=(([POLine:40]qtyReceived:4=0) & ([POLine:40]complete:25="") & ($virgin))
				$complete:=((([POLine:40]qtyBackLogged:5=0) | ([POLine:40]complete:25#"")) & ($complete))
				NEXT RECORD:C51([POLine:40])
			End for 
	End case 
End if 
Case of 
	: ($1=(->[Order:3]))
		[Order:3]complete:83:=Accept_SetStat(->[Order:3]dateInvoiceComp:6; $virgin; $complete; [Order:3]complete:83)
		// ### bj ### 20181112_1911
		// might want to change [Order]DTProdCompl if the orders has been added to
		// [Order]DTProdCompl really needs to be improved to reflect production changes and a better status choice.
		Case of 
			: ([Order:3]complete:83=2)
				If (([Order:3]dateInvoiceComp:6=!01-01-01!) | ([Order:3]dateInvoiceComp:6=!00-00-00!))
					[Order:3]dateInvoiceComp:6:=Current date:C33
				End if 
				If ([Order:3]status:59#"Completed")
					If (Not:C34(<>vbManOrdSta))
						[Order:3]status:59:="Completed"
					End if 
					If ([Order:3]dtProdCompl:57=0)
						[Order:3]dtProdCompl:57:=DateTime_DTTo
					End if 
				End if 
				If (allowAlerts_boo)
					jMessageWindow("Order is completely shipped.")
				End if 
			: ([Order:3]complete:83=1)
				// ### bj ### 20181112_1906
				[Order:3]dateInvoiceComp:6:=!00-00-00!
				If (([Order:3]status:59="Completed") & ([Order:3]dtProdCompl:57=0))
					[Order:3]dtProdCompl:57:=DateTime_DTTo
				End if 
				// Modified by: William James (2014-03-17T00:00:00 Subrecord eliminated)
				//  [Order]DateShipOn:=!01/01/2001!   added and removed. This is used to project when something must ship on
				If (([Order:3]status:59="Completed") | ([Order:3]status:59=""))  // if there is no other status change
					[Order:3]status:59:="Partial"
				End if 
				If (allowAlerts_boo)
					jMessageWindow("Order is partially shipped.")
				End if 
			: ([Order:3]complete:83=0)
				// ### bj ### 20181112_1906
				[Order:3]dateInvoiceComp:6:=!00-00-00!
				
				[Order:3]dtProdCompl:57:=0  // better control by production
				
				If ([Order:3]status:59="Completed")
					[Order:3]status:59:=""
				End if 
				If (allowAlerts_boo)
					jMessageWindow("Order has no shipments.")
				End if 
		End case 
	: ($1=(->[PO:39]))
		[PO:39]complete:65:=Accept_SetStat(->[PO:39]dateComplete:4; $virgin; $complete; [PO:39]complete:65)
		Case of 
			: ([PO:39]complete:65=2)
				If (allowAlerts_boo)
					jMessageWindow("PO is completely received.")
				End if 
			: ([PO:39]complete:65=1)
				If (allowAlerts_boo)
					jMessageWindow("PO is partially received.")
				End if 
			: ([PO:39]complete:65=0)
				If (allowAlerts_boo)
					jMessageWindow("PO has no receipts.")
				End if 
		End case 
End case 
REDRAW WINDOW:C456