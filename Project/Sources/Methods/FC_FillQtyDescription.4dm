//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/10/07, 14:48:46
// ----------------------------------------------------
// Method: FC_FillQtyDescription
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	//Date: 03/05/02
	//Who: Dan Bentson, Arkware
	//Description: Added base quantity
	VERSION_960
End if 
// ###_jwm_### 'Item Q&D' sort array by ItemNum and Date before running total

FC_FillRay(-8)  //sort by item num, date of action

C_BOOLEAN:C305($endCheck)
C_LONGINT:C283($i; $k)
C_TEXT:C284($descript)
C_TEXT:C284($typeID)
C_REAL:C285($QtyStart)
KeyModifierCurrent
If ((CmdKey=1) & (CtlKey=1))
	If (Size of array:C274(aFCRunQty)>1)
		aFCRunQty{1}:=aFCBomCnt{1}
		For ($i; 2; Size of array:C274(aFCRecNum))
			aFCRunQty{$i}:=aFCRunQty{$i-1}+aFCBomCnt{$i}
		End for 
		doSearch:=1
	End if 
Else 
	$endCheck:=False:C215
	$k:=Size of array:C274(aFCRecNum)
	//ThermoInitExit ("Listing Description and Quantities.";$k;False)
	$viProgressID:=Progress New
	$i:=1
	If ($k>0)
		Repeat 
			// ### jwm ### 20180718_1018
			ProgressUpdate($viProgressID; $i; $k; "Listing Description and Quantities:")
			If (<>ThermoAbort)
				$endCheck:=True:C214
			End if 
			$partNum:=aFCItem{$i}
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$partNum)
			$QtyStart:=[Item:4]qtyOnHand:14
			$descript:=[Item:4]description:7
			$typeID:=[Item:4]typeid:26
			aFCBaseQty{$i}:=$QtyStart
			UNLOAD RECORD:C212([Item:4])
			
			
			C_DATE:C307($ytdDate; $ytdDateLess1; $ytdDateLess2)
			$ytdDate:=Date_ThisYear(Current date:C33; 0)
			aFCTallyYTD{$i}:=FC_SumYear($partNum; $ytdDate)
			$ytdDateLess1:=Date_ThisYear($ytdDate-1; 0)
			aFCTallyLess1Year{$i}:=FC_SumYear($partNum; $ytdDateLess1)
			$ytdDateLess2:=Date_ThisYear($ytdDateLess1-1; 0)
			aFCTallyLess2Year{$i}:=FC_SumYear($partNum; $ytdDateLess2)
			Repeat 
				aFCDesc{$i}:=$descript
				aFCtypeID{$i}:=$typeID
				If (aFCTypeTran{$i}="It")
					aFCRunQty{$i}:=0
					aFCBomCnt{$i}:=$QtyStart
				Else 
					$QtyStart:=$QtyStart+aFCBomCnt{$i}
					aFCRunQty{$i}:=$QtyStart
				End if 
				If ($i<$k)
					$i:=$i+1
				Else 
					$endCheck:=True:C214
				End if 
			Until (($partNum#aFCItem{$i}) | ($endCheck))
			
		Until ($endCheck)
		For ($i; 1; 11)
			$ptVar:=Get pointer:C304("vR"+String:C10($i))
			$ptVar->:=0
		End for 
		vL1:=0
		vL2:=0
		doSearch:=1
	End if 
	Progress QUIT($viProgressID)
End if 


