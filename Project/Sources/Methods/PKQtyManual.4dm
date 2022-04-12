//%attributes = {}

//<declarations>
//==================================
//  Type variables 
//==================================

C_BOOLEAN:C305(vbBuildCarton; $vbBuildPallet; $vberror)
C_LONGINT:C283($vi1; $viBottom; $viCartonCount; $viCartons; $viCenterH; $viCenterW; $viCount)
C_LONGINT:C283($viHeight; $viIndex; $viLeft; $vipallets; $viQtyCalc; $viQtyPack; $viQtyPackTotal; $viQtyShip)
C_LONGINT:C283($viRemainder; $viRight; $viSeconds; $viSelected; $viTop; $viWidth)
C_REAL:C285($vrItemWeight; $vrPercent; $vrQtyBulk; $vrQtyBundelSell)
C_REAL:C285($vrQtyMultiPack; $vrSumBLQ)
C_TEXT:C284($vtMessage)

//==================================
//  Initialize variables 
//==================================

vbBuildCarton:=False:C215
$vbBuildPallet:=False:C215
$vberror:=False:C215
$vi1:=0
$viBottom:=0
$viCartonCount:=0
$viCartons:=0
$viCenterH:=0
$viCenterW:=0
$viCount:=0
$viHeight:=0
$viIndex:=0
$viLeft:=0
$vipallets:=0
$viQtyCalc:=0
$viQtyPack:=0
$viQtyPackTotal:=0
$viQtyShip:=0
$viRemainder:=0
$viRight:=0
$viSeconds:=0
$viSelected:=0
$viTop:=0
$viWidth:=0
$vrItemWeight:=0
$vrPercent:=0
$vrQtyBulk:=0
$vrQtyBundelSell:=0
$vrQtyMultiPack:=0
$vrSumBLQ:=0
$vtMessage:=""
//</declarations>

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/12/18, 10:11:01
// ----------------------------------------------------
// Method: PKQtyManual
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285($vrSumBLQ)
C_LONGINT:C283($viQtyPack; $viQtyShip; $viSelected; $viCount; $viIndex)
C_BOOLEAN:C305($vbError; vbClearCalc)
$vrSumBLQ:=0
vbClearCalc:=True:C214

ARRAY TEXT:C222($atItemNum; 0)
ARRAY REAL:C219($arSumBLQ; 0)
ARRAY LONGINT:C221($aiUniqueID; 0)

For ($vi1; 1; Size of array:C274(aOItemNum))
	$viIndex:=Find in array:C230($atItemNum; aOItemNum{$vi1})
	If ($viIndex<0)  // not found
		APPEND TO ARRAY:C911($atItemNum; aOItemNum{$vi1})
		APPEND TO ARRAY:C911($arSumBLQ; aOQtyBL{$vi1})
		//APPEND TO ARRAY($aiUniqueID;aoUniqueID{$i})
	Else 
		$arSumBLQ{$viIndex}:=$arSumBLQ{$viIndex}+aOQtyBL{$vi1}
		
	End if 
End for 

$viIndex:=Find in array:C230($atItemNum; srItem)

If ($viIndex>0)
	$vrSumBLQ:=$arSumBLQ{$viIndex}
Else 
	$vrSumBLQ:=0
End if 

If ($vrSumBLQ=0)
	
	If (<>barcodeErrorSound#"")
		PLAY:C290(<>barcodeErrorSound)
	Else 
		BEEP:C151
		BEEP:C151
		BEEP:C151
	End if 
	
	errorComment:="IETM FULLY SHIPPED"+"\r"+"\r"+"Item: "+srItem
	<>pkScaleComment:="IETM FULLY SHIPPED, Item: "+srItem
	PKAlertWindow
	
	$vberror:=True:C214
	
Else 
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem)
	$vrQtyBundelSell:=[Item:4]qtyBundleSell:79
	
	If ($vrQtyBundelSell<1)
		PKCartonQty
	End if 
	
	$vrQtyBundelSell:=[Item:4]qtyBundleSell:79
	
	If ([Item:4]qtyBundleSell:79=0)
		$viCartons:=0
		$viRemainder:=0
	Else 
		$viCartons:=Int:C8($vrSumBLQ/[Item:4]qtyBundleSell:79)
		$viRemainder:=($vrSumBLQ%[Item:4]qtyBundleSell:79)
	End if 
	
	$vrItemWeight:=[Item:4]weightAverage:8
	$vrQtyMultiPack:=[Item:4]qtyMasterPack:115
	$vrQtyBulk:=[Item:4]qtyBulk:118
	
	If (cbCheckQtyPallet=1)  // checkbox
		
		If ($vrQtyBulk<1)
			PKPalletQty
		End if 
		
	End if 
	
	If ([Item:4]qtyBulk:118<1)
		$viPallets:=0
	Else 
		$viPallets:=Int:C8($vrSumBLQ/[Item:4]qtyBulk:118)
	End if 
	
	UNLOAD RECORD:C212([Item:4])
	REDUCE SELECTION:C351([Item:4]; 0)
	
	If ($viIndex>0)
		
		If ($vrQtyBundelSell=0)
			$vrQtyBundelSell:=$vrSumBLQ
		End if 
		
		If ($vrSumBLQ>=$vrQtyBundelSell)  // over Carton Qty
			
			// Confirm build multiple cartons
			$vtMessage:="Build "+String:C10($viCartons)+" Cartons of Qty "+String:C10($vrQtyBundelSell)+" - "+srItem
			
			CONFIRM:C162($vtMessage; "Build "+String:C10($viCartons)+" Cartons"; " Cancel  ")
			
			If (OK=1)
				$viQtyPackTotal:=$viCartons*$vrQtyBundelSell
				vbBuildCarton:=True:C214
				//$viRemainder less than full quantity not packed
			Else 
				$viQtyPackTotal:=$vrQtyBundelSell
				vbBuildCarton:=False:C215
			End if 
			
			If ($viPallets>0)  // 
				
				$viCartons:=Int:C8($vrQtyBulk/$vrQtyBundelSell)  // cartons per pallet
				
				// Confirm build Pallet
				$vtMessage:="Build "+String:C10($viPallets)+" Pallets of Qty "+String:C10($viCartons)+" Cartons of "+srItem
				
				CONFIRM:C162($vtMessage; "Build "+String:C10($viPallets)+" Pallets"; " Cancel ")
				
				If (OK=1)
					$viQtyPackTotal:=$vipallets*$viCartons*$vrQtyBundelSell
					$vbBuildPallet:=True:C214
					vbBuildCarton:=True:C214  // override must build cartons to build pallets
					//$viRemainder less than full quantity not packed
				Else 
					//$viQtyPackTotal:=$vrQtyBundelSell
					$vbBuildPallet:=False:C215
					
				End if 
				
			End if 
			
		Else   // under carton qty
			
			$viQtyPackTotal:=$vrSumBLQ
			
		End if 
		
		calcString:=String:C10($viQtyPackTotal)
		vbClearCalc:=False:C215
		
	End if 
	$vhPKWindow:=Frontmost window:C447
	
	jCenterWindow(360; 360; 1)
	DIALOG:C40([Control:1]; "Calculator")
	CLOSE WINDOW:C154
	
	If (OK=1)
		
		$viQtyShip:=0
		$viSelected:=0
		$viCount:=0
		$w:=0
		$lastInstance:=0
		$vbError:=False:C215
		
		$viQtyCalc:=Num:C11(calcString)
		
		If ($viQtyCalc>$vrSumBLQ)
			
			If (<>barcodeErrorSound#"")
				PLAY:C290(<>barcodeErrorSound)
			Else 
				BEEP:C151
				BEEP:C151
				BEEP:C151
			End if 
			
			errorComment:="QTY "+String:C10($viQtyCalc)+" > BLQ "+String:C10($vrSumBLQ; "###,###,##0")+"\r"+"\r"+"Item: "+srItem
			<>pkScaleComment:="QTY "+String:C10($viQtyCalc)+" > BLQ "+String:C10($vrSumBLQ; "###,###,##0")
			PKAlertWindow
			
		Else 
			
			$viQtyPackTotal:=$viQtyCalc
			
			If (vbBuildCarton=True:C214)
				
				// progress window
				SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D software:K37:66)  // Enable Direct2D fixes message bug with Windows client
				$viCenterW:=Screen width:C187\2
				$viCenterH:=(Screen height:C188\2)
				$viWidth:=400
				$viHeight:=100
				$viLeft:=$viCenterW-($viWidth\2)
				$viRight:=$viCenterW+($viWidth\2)
				$viTop:=$viCenterH-($viHeight/2)
				$viBottom:=$viCenterH+($viHeight/2)
				//left,top,right,bottom
				Open window:C153($viLeft; $viTop; $viRight; $viBottom; 8; "Progress")
				
			End if 
			
			$viCartonCount:=0
			
			Repeat   // pack carton
				// reset values here for each Carton
				$viQtyShip:=0
				$viSelected:=0
				$viCount:=0
				$w:=0
				$lastInstance:=0
				$vbError:=False:C215
				
				// check for multi carton Quantity
				If ($viQtyPackTotal>=$vrQtyBundelSell)
					$viQtyPack:=$vrQtyBundelSell
				Else 
					$viQtyPack:=$viQtyPackTotal
				End if 
				
				ERASE WINDOW:C160
				GOTO XY:C161(2; 1)
				MESSAGE:C88("Total Qty: "+String:C10($viQtyPackTotal))
				
				$viQtyPackTotal:=$viQtyPackTotal-$viQtyPack
				
				Repeat 
					$w:=Find in array:C230(aOItemNum; srItem; $lastInstance)
					$lastInstance:=$w+1  // position in array
					$viCount:=$viCount+1  // passes through array
					
					If ($w>0)
						If (aOQtyBL{$w}>0)
							$viSelected:=$viSelected+1
							ARRAY LONGINT:C221(aoLnSelect; 0)  // rebuild current selection
							APPEND TO ARRAY:C911(aoLnSelect; $w)
							If ($viQtyPack>=aOQtyBL{$w})
								iLoReal3:=aOQtyBL{$w}
							Else 
								iLoReal3:=$viQtyPack
							End if 
							
							PKLineIntoBox(-1; iLoReal3)
							$viQtyShip:=$viQtyShip+iLoReal3
							$viQtyPack:=$viQtyPack-iLoReal3
							
							iLoReal3:=$viQtyShip  // to update packing window count
							iLoReal4:=Round:C94(aOUnitWt{$w}*$viQtyShip; 1)
							srItem:=aOItemNum{$w}
							srItemAltNum:=aOAltItem{$w}
							srItemDscrp:=aODescpt{$w}
							
							//aOQtyPack{$w}:=aOQtyPack{$w}+$viQtyPack
							//aOQtyBL{$w}:=aOQtyBL{$w}-$viQtyPack
							
						End if 
						
					End if 
					
				Until (($w<1) | ($viQtyPack<=0) | ($viCount>Size of array:C274(aoItemNum)))
				
				If (vbBuildCarton=True:C214)
					
					If ($vbBuildPallet)
						$viCartons:=$viQtyCalc/$vrQtyBundelSell/$vipallets
					Else 
						$viCartons:=$viQtyCalc/$vrQtyBundelSell
					End if 
					
					$viCartonCount:=$viCartonCount+1
					$vrPercent:=Round:C94(($viCartonCount/$viCartons*100); 0)
					
					GOTO XY:C161(2; 3)
					MESSAGE:C88(" Building "+String:C10($viCartonCount)+" of "+String:C10($viCartons)+"  "+String:C10($vrPercent)+" %")
					DELAY PROCESS:C323(Current process:C322; 2)  //test pause two ticks
					
					If ((<>vbScaleOn=True:C214) & (iLoInteger1=0))
						// ### jwm ### 20141211_1054
						// if scale should be on and ignore weight false
						// Trigger capture of Tare Weight
						<>vrWeightTare:=-77777
						C_LONGINT:C283($TickStart; $ticks)
						$TickStart:=Tickcount:C458
						$ticks:=Tickcount:C458-$TickStart
						// Wait 3 seconds or until resets
						While ((<>vrWeightTare=-77777) & ($ticks<180))
							// wait for PkScaleProcess to update Tare Weight
							DELAY PROCESS:C323(Current process:C322; 6)  // test length 1/10 second 6 ticks
							$ticks:=Tickcount:C458-$TickStart
						End while 
					End if 
					
					If (<>vrWeightScale=0)  // dither factor handled in PKWtScalRead
						
						If ((<>vbScaleOn=True:C214) & (iLoInteger1=0))  // scale should be on and ignore weight false
							
							$viSeconds:=30
							Repeat 
								
								ERASE WINDOW:C160
								GOTO XY:C161(3; 2)
								MESSAGE:C88("ERROR: ZERO WEIGHT PLACE CARTON ON SCALE")
								GOTO XY:C161(12; 4)
								MESSAGE:C88(" PAUSED: "+String:C10($viSeconds))
								$viSeconds:=$viSeconds-1
								DELAY PROCESS:C323(Current process:C322; 60)  // pause 1seconds
								
							Until ((<>vrWeightScale#0) | ($viSeconds<=0))
							
							If ((<>vrWeightScale=0) & ($viSeconds<=0))  // ERROR: TIMEOUT calculate carton weight
								<>vrWeightScale:=$vrItemWeight*$vrQtyBundelSell  // calcualte carton weight
							End if 
							
						Else 
							<>vrWeightScale:=$vrItemWeight*$vrQtyBundelSell  // calcualte carton weight
						End if 
						
					End if 
					
					//pkCheckWeight 
					// ### jwm ### 20180606_1637 TEST TEST TEST
					
					<>vrWeightProduct:=$vrItemWeight*$vrQtyBundelSell  // calcualte product weight
					<>vrWeightTare:=<>vrWeightScale-<>vrWeightProduct
					<>vrWeightErrPC:=Abs:C99(Round:C94((<>vrWeightProduct+<>vrWeightTare-<>vrWeightScale)/<>vrWeightScale*100; 1))
					<>wtDitherPC:=Abs:C99(Round:C94(<>wtDitherFactor/<>vrWeightScale*100; 1))  // ### jwm ### 20141210_2241 added dither percent of total weight
					
					<>pkScaleComment:="OK"
					
					C_TEXT:C284($message)
					$message:="<>vrWeightScale = "+String:C10(<>vrWeightScale)+"\r"
					$message:=$message+"<>vrWeightTare = "+String:C10(<>vrWeightTare)+"\r"
					$message:=$message+"<>vrWeightProduct = "+String:C10(<>vrWeightProduct)+"\r"
					$message:=$message+"<>vrWeightErrPC = "+String:C10(<>vrWeightErrPC)+"\r"
					$message:=$message+"<>wtPrecisionFinalPC = "+String:C10(<>wtPrecisionFinalPC)+"\r"
					$message:=$message+"<>wtTarePC = "+String:C10(<>wtTarePC)+"\r"
					
					ConsoleMessage($message)
					
					Case of 
						: (iLoInteger1=1)  // ignore Weight over ride
							OBJECT SET ENABLED:C1123(b3; True:C214)
							//: (<>wtPrecisionPC><>wtPrecisionLimit)//What is this ???
							//<>pkScaleComment:="FULLY SHIPPED"
						: ((<>vrWeightTare<(-<>wtDitherFactor-(<>vrWeightScale*<>wtPrecisionPC*0.01))) & (<>vrWeightTare#-77777))
							//: ((<>vrWeightTare<(-<>wtDitherFactor))&(<>vrWeightTare#-77777))
							//zzzCheck_bj 070920 
							<>pkScaleComment:="Negative Tare"
							OBJECT SET ENABLED:C1123(b3; False:C215)
							
							// : (<>vrWeightErrPC><>wtPrecisionPC)  // (<>vrWeightErrPC><>wtPrecisionPC)
						: (<>vrWeightErrPC>(<>wtPrecisionPC+<>wtDitherPC))  // ### jwm ### 20141210_2241 added percentage of dither to allowed deviation
							If (<>vrWeightScale><>wtDitherFactor)
								<>pkScaleComment:="Weight Mismatch"
								OBJECT SET ENABLED:C1123(b3; False:C215)
							End if 
							
						: (<>vrWeightTare=-77777)
							<>pkScaleComment:="Scale Missing, Click Tare"
							PKAlertWindow
							OBJECT SET ENABLED:C1123(b3; False:C215)
							
						: ((<>vrWeightTare/<>vrWeightScale*100)><>wtTarePC)  // ### jwm ### 20141211_1017 tare weight over <>wtTarePC
							$vtTarePC:=String:C10(Round:C94(<>vrWeightTare/<>vrWeightScale*100; 0))
							<>pkScaleComment:="Tare "+$vtTarePC+"%  > "+String:C10(<>wtTarePC)+"% Limit"
							PKAlertWindow
							OBJECT SET ENABLED:C1123(b3; False:C215)
							
						Else 
							<>pkScaleComment:="OK"
							If (Size of array:C274(aLiItemNum)>0)
								OBJECT SET ENABLED:C1123(b3; True:C214)
								// PKBoxItemsTags 
							Else 
								
								If (<>barcodeErrorSound#"")
									PLAY:C290(<>barcodeErrorSound)
								Else 
									BEEP:C151
									BEEP:C151
									BEEP:C151
								End if 
							End if 
							
					End case 
					If (OBJECT Get enabled:C1079(b3))  // if #3 Box Button Enabled No Weight Errors
						_O_OBJECT SET COLOR:C271(<>pkScaleComment; -(White:K11:1+(256*Green:K11:9)))
						//iLoInteger1:=0  // ignore weight false
						PKBoxItemsTags
						
					Else 
						_O_OBJECT SET COLOR:C271(<>pkScaleComment; -(White:K11:1+(256*Red:K11:4)))
						// ### jwm ### 20180516_1334 STOP PROCESSING force drop out of loop
						$vbBuildPallet:=False:C215
						$viQtyPackTotal:=0
						$vbError:=True:C214
					End if 
					
				End if 
				
				If (($vbBuildPallet=True:C214) & (($viCartonCount*$vrQtyBundelSell)=$vrQtyBulk))  // we are building a pallet and have a full pallet qty
					
					//Build pallet here copied from NEW PALLET button
					
					If ([Order:3]customerID:1#"")  //"Add to New Pallet"
						CONFIRM:C162("Add to new pallet")
						If (OK=1)
							PKPalletPack(-3; iLoInteger5)  //new pallet, selected lines 0/1;Alert
							//
							PKListPalletsAvailable([Order:3]customerID:1)
						End if 
						ALERT:C41("Pallet Built")
					Else 
						ALERT:C41("No Customer")
					End if 
					
					// reset carton counter
					$viCartonCount:=0
					
				End if 
				
			Until (($w<1) | ($viQtyPackTotal<=0) | ($viCount>Size of array:C274(aoItemNum)))
			
			If (vbBuildCarton=True:C214)
				CLOSE WINDOW:C154  // progress Window
				SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D hardware:K37:64)
			End if 
			
			Case of 
				: (($viSelected>0) & ($viQtyShip=0))  //FOUND BUT FULLY SHIPPED
					errorComment:="IETM FULLY SHIPPED"+"\r"+"\r"+"Item: "+srItem
					<>pkScaleComment:="IETM FULLY SHIPPED, Item: "+srItem
					$vberror:=True:C214
					
				: ($viSelected=0)  // NOT FOUND
					errorComment:="IETM NOT FOUND"+"\r"+"\r"+"Item:"+srItem
					<>pkScaleComment:="IETM NOT FOUND, Item: "+srItem
					$vberror:=True:C214
					
				: (($viQtyPack>0) & ($viSelected>0) & ($viQtyShip>0))  // OVER SHIPPED 
					errorComment:="QTY OVER: "+String:C10($viQtyPack)+", QTY SHIPPED: "+String:C10($viQtyShip)+"\r"+"\r"+"Item: "+srItem
					<>pkScaleComment:="OVER: "+String:C10($viQtyPack)+", SHIPPED: "+String:C10($viQtyShip)
					$vberror:=True:C214
					
			End case 
			
			If ($vbError)
				_O_OBJECT SET COLOR:C271(<>pkScaleComment; -(White:K11:1+(256*Red:K11:4)))
				If (<>barcodeErrorSound#"")
					PLAY:C290(<>barcodeErrorSound)
				Else 
					BEEP:C151
					BEEP:C151
					BEEP:C151
				End if 
				
				PKAlertWindow
			End if 
			
		End if 
	End if 
	
End if 
// reset back to scan by 1 
aTmp20Str4:=1
viScanByAction:=1
//aTmp20Str4:=viScanDefault  // ### jwm ### 20180312_0843
//viScanByAction:=viScanDefault  // ### jwm ### 20180312_0843

