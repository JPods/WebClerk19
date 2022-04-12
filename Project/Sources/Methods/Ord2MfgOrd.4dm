//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 09:46:37
// ----------------------------------------------------
// Method: Ord2MfgOrd
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("ProductInvoices"))
	C_LONGINT:C283(bComInv; $k; $i; $e; $w; $notMfg; eOrdList)
	//
	READ WRITE:C146([OrderLine:49])
	READ ONLY:C145([ManufacturerTerm:111])
	acceptOrders  // (noNavError)
	C_LONGINT:C283($ordRec; $doSplit; $originalOrderNum)
	$originalOrderNum:=[Order:3]orderNum:2
	$doSplit:=0
	If (booAccept=True:C214)
		$k:=Size of array:C274(aoLineAction)
		If ($k=0)
			BEEP:C151
			BEEP:C151
		Else 
			If (allowAlerts_boo)
				KeyModifierCurrent
			End if 
			$notMfg:=0
			$e:=0
			$i:=0
			ARRAY LONGINT:C221($aUniqueMfrs; 0)
			ARRAY LONGINT:C221($aOrderNum; 0)
			ARRAY LONGINT:C221($aLineUniqueID; Size of array:C274(aoUniqueID))
			COPY ARRAY:C226(aoUniqueID; $aLineUniqueID)
			Repeat 
				$i:=$i+1
				Case of 
					: (aOQtyShip{$i}#0)
						$i:=$k
						$e:=-1
					: ((aOLocation{$i}>-1999999) & ($notMfg=0))
						$notMfg:=1
					: (aOLocation{$i}<-1999999)
						$w:=Find in array:C230($aUniqueMfrs; aOLocation{$i})
						If ($w=-1)
							INSERT IN ARRAY:C227($aUniqueMfrs; 1)  //
							$aUniqueMfrs{1}:=aOLocation{$i}
							$testLoc:=aOLocation{$i}
							$e:=$e+1
						End if 
				End case 
			Until ($i=$k)
			If ($notMfg=1)  //manage the first unit as a possible special case, not mfg
				INSERT IN ARRAY:C227($aUniqueMfrs; 1)
				$aUniqueMfrs{1}:=1
				$e:=$e+1
			End if 
			Case of 
				: ($e=-1)
					If (allowAlerts_boo)
						ALERT:C41("You may not split an order with shipments.")
					End if 
				: (OptKey=1)
					If (allowAlerts_boo)
						CONFIRM:C162("You are about to split this order.")
						If (OK=1)
							$doSplit:=1
						End if 
					End if 
				: ($e=1)
					If (allowAlerts_boo)
						ALERT:C41("There are not multiple manufactures on this order.")
					End if 
					If (Size of array:C274($aUniqueMfrs)=1)
						If ($aUniqueMfrs{1}<-1999999)
							$wMfg:=Find in array:C230(<>aMfgIdKey; $aUniqueMfrs{1})
							If ($wMfg>0)
								[Order:3]mfrID:52:=<>aMfg{$wMfg}
								[Order:3]mfrName:91:=<>aMfgName{$wMfg}
								QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Order:3]mfrID:52)
								[Order:3]divisionMfr:84:=[ManufacturerTerm:111]division:8
								UNLOAD RECORD:C212([ManufacturerTerm:111])
								//[ManufacturerTerm]Terms
								SAVE RECORD:C53([Order:3])
							End if 
						End if 
					End if 
				Else 
					If (allowAlerts_boo)
						CONFIRM:C162("Create "+String:C10($e)+" Mfg Orders.")
						If (OK=1)
							$doSplit:=2
						End if 
					Else 
						$doSplit:=2  //do all line items
					End if 
			End case 
		End if 
	Else 
		jAlertMessage(9200)
	End if 
	//TRACE
	If ($doSplit>0)
		If (allowAlerts_boo)
			BEEP:C151  //PLAY("Sosumi")
		End if 
		CREATE EMPTY SET:C140([Order:3]; "Current")
		ADD TO SET:C119([Order:3]; "Current")
		$wMfg:=Find in array:C230(<>aMfgIdKey; $aUniqueMfrs{1})
		If ($wMfg>0)
			[Order:3]mfrID:52:=<>aMfg{$wMfg}
			[Order:3]mfrName:91:=<>aMfgName{$wMfg}
		End if 
		If ([Order:3]projectNum:50=0)
			[Order:3]projectNum:50:=$originalOrderNum
		End if 
		SAVE RECORD:C53([Order:3])
		C_LONGINT:C283($incLineRay; $cntLineRay)
		$cntLineRay:=Size of array:C274(aoUniqueID)
		
		
		$ordRec:=Record number:C243([Order:3])
		Case of 
			: ($doSplit=2)  //for all line items
				$k:=Size of array:C274($aUniqueMfrs)
				For ($i; 2; $k)
					DUPLICATE RECORD:C225([Order:3])
					[Order:3]orderNum:2:=CounterNew(->[Order:3])
					[Order:3]takenBy:36:=Current user:C182
					$wMfg:=Find in array:C230(<>aMfgIdKey; $aUniqueMfrs{$i})
					If ($wMfg>0)
						[Order:3]mfrID:52:=<>aMfg{$wMfg}
						[Order:3]mfrName:91:=<>aMfgName{$wMfg}  // arrays do not match in size.  zzz
					Else 
						[Order:3]mfrID:52:="NotDefined"
						[Order:3]mfrName:91:="NotDefined"
					End if 
					QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Order:3]mfrID:52)
					[Order:3]divisionMfr:84:=[ManufacturerTerm:111]division:8
					UNLOAD RECORD:C212([ManufacturerTerm:111])
					C_LONGINT:C283($incLineRay; $cntLineRay)
					$cntLineRay:=Size of array:C274(aoUniqueID)
					For ($incLineRay; 1; $cntLineRay)
						If ($aUniqueMfrs{$i}=aOLocation{$incLineRay})  // location id of the line matches the mfr
							QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoUniqueID{$incLineRay})
							[OrderLine:49]orderNum:1:=[Order:3]orderNum:2
							SAVE RECORD:C53([OrderLine:49])
							SAVE RECORD:C53([Order:3])
						End if 
					End for 
					SAVE RECORD:C53([Order:3])
					PUSH RECORD:C176([Order:3])
					ADD TO SET:C119([Order:3]; "Current")
					GOTO RECORD:C242([Order:3]; $ordRec)  // return to clone original
				End for 
				
				OrdLnFillRays
				vMod:=calcOrder(True:C214)
				OrdLineCalc
				vMod:=True:C214
				booAccept:=True:C214
				acceptOrders
				
				$k:=Size of array:C274($aUniqueMfrs)
				For ($i; 2; $k)
					POP RECORD:C177([Order:3])
					OrdLnFillRays
					vMod:=calcOrder(True:C214)
					vMod:=True:C214
					booAccept:=True:C214
					OrdLineCalc
					acceptOrders
				End for 
				USE SET:C118("Current")
				CLEAR SET:C117("Current")
				CANCEL:C270
				
				
			Else 
				ALERT:C41("All lines must be split")
		End case 
		
	Else 
		If ([Order:3]projectNum:50=0)
			[Order:3]projectNum:50:=[Order:3]orderNum:2
			SAVE RECORD:C53([Order:3])
		End if 
	End if 
	READ ONLY:C145([OrderLine:49])
	READ WRITE:C146([ManufacturerTerm:111])
	REDUCE SELECTION:C351([ManufacturerTerm:111]; 0)
End if 