//%attributes = {"publishedWeb":true}
//(P) rptOrd2Inv 
//October 25, 1995

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:43:11
// ----------------------------------------------------
// Method: rptOrd2Inv
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("MakePayment"))
	C_LONGINT:C283(eOpenOrds)
	KeyModifierCurrent
	C_LONGINT:C283($1; $myOpt)
	If ((Count parameters:C259=0) & (optKey=0))
		$myOpt:=0
	Else 
		If (optKey=1)
			$myOpt:=1
		Else 
			$myOpt:=$1
		End if 
	End if 
	//
	C_LONGINT:C283($i; $k; $incsub; $myOK)
	C_BOOLEAN:C305(booManyInv; $endView)  //coming from add invoice dialog
	C_LONGINT:C283($invNum)
	C_REAL:C285($qtyOK)
	$myOK:=0
	Case of 
		: (allowAlerts_boo=False:C215)
			$myOK:=1
		: (($myOpt=1) & (Size of array:C274(<>aItemLines)>0))
			CONFIRM:C162("INVOICE selected items for these "+String:C10(Records in selection:C76([Order:3]))+" Orders.")
			C_BOOLEAN:C305(doByLine)
			$myOK:=OK
			doByLine:=(OK=1)
		: ((vHere=1) | (booManyInv))
			doByLine:=False:C215
			CONFIRM:C162("INVOICEs will be created shipping all available items on these "+String:C10(Records in selection:C76([Order:3]))+" Orders.")
			$myOK:=OK
		: (vHere>1)  //if creating an invoice from inside an order record
			//BILL: moved this case up from bottom and said end if at bottom
			//BILL: commented this out to fix compiler bug
			myOK:=0
			myCycle:=6  //Do not CANCEL order
			acceptOrders
			jAcceptCancel
			myCycle:=3  //Noting path    
			FORM SET INPUT:C55([Invoice:26]; "iInvoices_9")
			ADD RECORD:C56([Invoice:26])
			If (Records in selection:C76([Order:3])>0)
				vHere:=vHere-1
				jCancelButton
			Else 
				jsplashCancel
				CANCEL:C270
			End if 
			OK:=0
	End case 
	If ($myOK=1)
		CREATE EMPTY SET:C140([Invoice:26]; "NewInvoices")
		CREATE EMPTY SET:C140([Order:3]; "SkipOrders")
		CREATE EMPTY SET:C140([Order:3]; "ProcOrders")
		CREATE SET:C116([Order:3]; "OrigOrders")
		FIRST RECORD:C50([Order:3])
		$k:=Records in selection:C76([Order:3])
		//ThermoInitExit ("Processing Orders";$k;True)
		$viProgressID:=Progress New
		For ($i; 1; $k)
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Processing Orders")
			If (<>ThermoAbort)
				$i:=$k
			End if 
			LOAD RECORD:C52([Order:3])
			If (([Order:3]complete:83<2) & (Not:C34(Locked:C147([Order:3]))))
				jLOADunLocked(->[Order:3]; "Order "+String:C10([Order:3]idNum:2)+" is locked by another user."; ->unLocked)
				If (unLocked=1)
					OrdLnFillRays
					CREATE RECORD:C68([Invoice:26])
					createInvoice
					$qtyOK:=0  //initialize must be done
					For ($incsub; 1; Size of array:C274(aiQtyShip))
						$qtyOK:=$qtyOK+Abs:C99(aiQtyShip{$incsub})
					End for 
					If ($qtyOK=0)
						$invNum:=[Invoice:26]idNum:2
						CounterRecover(->[Invoice:26]; $invNum)
						ADD TO SET:C119([Order:3]; "SkipOrders")
					Else 
						vMod:=True:C214
						acceptInvoice(True:C214)
						ADD TO SET:C119([Invoice:26]; "NewInvoices")
						ADD TO SET:C119([Order:3]; "ProcOrders")
					End if 
				Else 
					ADD TO SET:C119([Order:3]; "SkipOrders")
				End if 
			Else 
				ADD TO SET:C119([Order:3]; "SkipOrders")
			End if 
			NEXT RECORD:C51([Order:3])
		End for 
		//Thermo_Close 
		Progress QUIT($viProgressID)
		If (allowAlerts_boo)
			$showView:=True:C214
			vi1:=Records in set:C195("NewInvoices")
			vi2:=Records in set:C195("SkipOrders")
			vi3:=Records in set:C195("ProcOrders")
			vi4:=Records in set:C195("OrigOrders")
			If ($myOpt=1)
				If (vi1>1)
					USE SET:C118("NewInvoices")
					DB_ShowCurrentSelection(->[Invoice:26]; ""; 1; "NewInvoices")
				End if 
				If (vi2>1)
					USE SET:C118("SkipOrders")
					DB_ShowCurrentSelection(->[Order:3]; ""; 1; "Skipped Orders")
				End if 
				If (vi3>1)
					USE SET:C118("ProcOrders")
					DB_ShowCurrentSelection(->[Order:3]; ""; 1; "Processed Orders")
				End if 
				USE SET:C118("OrigOrders")
				Process_ListActive
			Else 
				Repeat 
					vi1:=Records in set:C195("NewInvoices")
					vi2:=Records in set:C195("SkipOrders")
					vi3:=Records in set:C195("ProcOrders")
					vi4:=Records in set:C195("OrigOrders")
					v1:="Processed Invoices"
					v2:="Skipped Orders"
					v3:="Processed Orders"
					v4:="Original Orders"
					jCenterWindow(292; 180; 1)
					DIALOG:C40([Invoice:26]; "diaLinkedInvSet")
					CLOSE WINDOW:C154
					$endView:=(OK=0)
					ARRAY TEXT:C222(aPartNum; 0)
					ARRAY TEXT:C222(aBackOrder; 0)  //why are this used here??  July 28, 1995
					Case of 
						: ($endView)
						: (b1=1)
							USE SET:C118("NewInvoices")
							DB_ShowCurrentSelection(->[Invoice:26]; ""; 1; "NewInvoices")
						: (b2=1)
							USE SET:C118("SkipOrders")
							DB_ShowCurrentSelection(->[Order:3]; ""; 1; "Skipped Orders")
						: (b3=1)
							USE SET:C118("ProcOrders")
							DB_ShowCurrentSelection(->[Order:3]; ""; 1; "Processed Orders")
						: (b4=1)
							USE SET:C118("OrigOrders")
							DB_ShowCurrentSelection(->[Order:3]; ""; 1; "Starting Orders")
					End case 
				Until ($endView)
			End if 
			CLEAR SET:C117("OrigOrders")
			CLEAR SET:C117("NewInvoices")
			CLEAR SET:C117("SkipOrders")
			CLEAR SET:C117("OldOrders")
			If (ptCurTable#(->[Base:1]))  //lose track of vHere in selection options.
				vHere:=3
			End if 
			//skip if processing from Ord menu
			If (eOpenOrds#0)  //processing from within Ord production
				ARRAY LONGINT:C221(aRayLines; 0)
				//  --  CHOPPED  $clickResult:=AL_GetSelect(eOpenOrds; aRayLines)
				$k:=Size of array:C274(aRayLines)
				For ($i; 1; $k)
					GOTO RECORD:C242([Order:3]; aOrdRecs{aRayLines{$i}})
					aOrdStatus{aRayLines{$i}}:=[Order:3]status:59
					aComDates{aRayLines{$i}}:=[Order:3]dateInvoiceComp:6
				End for 
				doSearch:=1000
				booDuringDo:=True:C214  //needed to run during phase      
			End if 
		Else 
			CLEAR SET:C117("OrigOrders")
			CLEAR SET:C117("NewInvoices")
			CLEAR SET:C117("SkipOrders")
			CLEAR SET:C117("OldOrders")
		End if 
	End if 
	doByLine:=False:C215
End if 