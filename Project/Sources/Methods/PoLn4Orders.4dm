//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/26/19, 16:49:19
// ----------------------------------------------------
// Method: PoLn4Orders
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
C_LONGINT:C283($2; $theChoice)
C_LONGINT:C283($theCustRec)
$theChoice:=0
If (Count parameters:C259=2)
	$theChoice:=$2
End if 
KeyModifierCurrent

REDUCE SELECTION:C351([PO:39]; 0)
If (Size of array:C274(aOrdLnSel)>0)
	CREATE SET:C116([POLine:40]; "CurPOLines")
	myOK:=0
	Case of 
		: ($theChoice=1)
			myOK:=3
		: (OptKey=1)
			myOK:=1  //New PO      
		: ((CmdKey=1) & ([PO:39]poNum:5#0))
			myOK:=2  //add to existing PO      
		Else 
			vDiaCom:="Select a new PO"+"\r"+"or enter existing PO#."
			jCenterWindow(194; 196; 1)
			DIALOG:C40([PO:39]; "diaChoosePO")
			CLOSE WINDOW:C154
			vDiaCom:=""
	End case 
	Case of 
		: (myOK=3)
			
			Ord2POByVendor
			QUERY:C277([POLine:40]; [POLine:40]orderNum:16=[Order:3]orderNum:2)  //returning to included layout
			//OrdPoPoLineUpDt 
			UNLOAD RECORD:C212([POLine:40])
		: (myOK=0)
		: (myOK=1)  //new PO
			If (Modified record:C314([Customer:2]))
				SAVE RECORD:C53([Customer:2])
			End if 
			myCycle:=10
			myOK:=0
			$theCustRec:=Record number:C243([Customer:2])
			// ### bj ### 20181220_1626
			Alert_OPiP
			
			REDUCE SELECTION:C351([PO:39]; 0)
			
			FORM SET INPUT:C55([PO:39]; "Input")
			
			ADD RECORD:C56([PO:39])
			If ([Order:3]customerID:1#[Customer:2]customerID:1)
				GOTO RECORD:C242([Customer:2]; $theCustRec)
			End if 
			QUERY:C277([POLine:40]; [POLine:40]orderNum:16=[Order:3]orderNum:2)  //returning to included layout
			If ($1=(->[Control:1]))
				PoArrayManage(-5)
			End if 
		: (myOK=2)  //existing PO
			If (Modified record:C314([Customer:2]))
				SAVE RECORD:C53([Customer:2])
			End if 
			myCycle:=11
			myOK:=0
			
			If ([Customer:2]alertMessage:79#"")
				ConsoleMessage([Customer:2]alertMessage:79)
			End if 
			FORM SET INPUT:C55([PO:39]; "Input")
			
			$theCustRec:=Record number:C243([Customer:2])
			MODIFY RECORD:C57([PO:39])
			If ([Order:3]customerID:1#[Customer:2]customerID:1)
				GOTO RECORD:C242([Customer:2]; $theCustRec)
			End if 
			QUERY:C277([POLine:40]; [POLine:40]orderNum:16=[Order:3]orderNum:2)  //returning to included layout
			If ($1=(->[Control:1]))
				PoArrayManage(-5)
			End if 
	End case 
	myCycle:=0
	
Else 
	jAlertMessage(9209)
End if 



If (False:C215)
	C_POINTER:C301($1)
	C_LONGINT:C283($2; $theChoice)
	C_LONGINT:C283($theCustRec)
	$theChoice:=0
	If (Count parameters:C259=2)
		$theChoice:=$2
	End if 
	KeyModifierCurrent
	
	REDUCE SELECTION:C351([PO:39]; 0)
	If (Size of array:C274(aOrdLnSel)>0)
		CREATE SET:C116([POLine:40]; "CurPOLines")
		myOK:=0
		Case of 
			: ($theChoice=1)
				myOK:=3
			: (OptKey=1)
				myOK:=1  //New PO      
			: ((CmdKey=1) & ([PO:39]poNum:5#0))
				myOK:=2  //add to existing PO      
			Else 
				vDiaCom:="Select a new PO"+"\r"+"or enter existing PO#."
				jCenterWindow(220; 196; 1)
				DIALOG:C40([PO:39]; "diaChoosePO")
				CLOSE WINDOW:C154
				vDiaCom:=""
		End case 
		ARRAY TEXT:C222(<>aItemNumTransfer; 0)
		If (myOK>0)
			$k:=Size of array:C274(aOrdLnSel)
			For ($i; 1; $k)
				INSERT IN ARRAY:C227(<>aItemNumTransfer; $i; 1)
				<>aItemNumTransfer{$i}:=aOItemNum{aOrdLnSel{$i}}
			End for 
		End if 
		Case of 
			: (myOK=3)
				Ord2POByVendor
				QUERY:C277([POLine:40]; [POLine:40]orderNum:16=[Order:3]orderNum:2)
				//OrdPoPoLineUpDt 
				UNLOAD RECORD:C212([POLine:40])
			: (myOK=0)
			: (myOK=1)  //new PO
				If (Modified record:C314([Customer:2]))
					SAVE RECORD:C53([Customer:2])
				End if 
				myCycle:=10
				myOK:=0
				$theCustRec:=Record number:C243([Customer:2])
				REDUCE SELECTION:C351([PO:39]; 0)
				
				
				ADD RECORD:C56([PO:39])
				
				
				If ([Order:3]customerID:1#[Customer:2]customerID:1)
					GOTO RECORD:C242([Customer:2]; $theCustRec)
				End if 
				If ($1=(->[Control:1]))
					PoArrayManage(-5)
				End if 
			: (myOK=2)  //existing PO
				If (Modified record:C314([Customer:2]))
					SAVE RECORD:C53([Customer:2])
				End if 
				myCycle:=11
				myOK:=0
				$theCustRec:=Record number:C243([Customer:2])
				ProcessTableOpen(Table:C252(->[PO:39])*-1)
				If ([Order:3]customerID:1#[Customer:2]customerID:1)
					GOTO RECORD:C242([Customer:2]; $theCustRec)
				End if 
				If ($1=(->[Control:1]))
					PoArrayManage(-5)
				End if 
		End case 
		myCycle:=0
	Else 
		jAlertMessage(9209)
	End if 
End if 