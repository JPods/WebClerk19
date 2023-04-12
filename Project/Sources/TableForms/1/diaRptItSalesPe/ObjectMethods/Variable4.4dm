// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/12/09, 10:25:27
// ----------------------------------------------------
// Method: Object Method: bSearch
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($k; $eCnt; $i; $w; $c)
C_BOOLEAN:C305($endLoop)
KeyModifierCurrent
$doLoop:=True:C214
If (OptKey=1)
	QUERY:C277([DInventory:36])
Else 
	$i:=DateTime_DTTo(vdDateBeg; ?00:00:00?)
	$c:=DateTime_DTTo(vdDateEnd; ?24:00:00?)
	QUERY:C277([DInventory:36]; [DInventory:36]dtCreated:15>=$i; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=$c)
End if 
ORDER BY:C49([DInventory:36]itemNum:1)
$k:=Records in selection:C76([DInventory:36])
$i:=0
$w:=0
$eCnt:=0
If ($k>0)
	//ThermoInitExit ("Processing Daily Sales";$k;True)
	$viProgressID:=Progress New
	
	FIRST RECORD:C50([DInventory:36])
	ARRAY TEXT:C222(aPartNum; 0)
	ARRAY TEXT:C222(aPartDesc; 0)
	ARRAY REAL:C219(aQtyOrd; 0)
	ARRAY REAL:C219(aQtySold; 0)
	ARRAY REAL:C219(aQtyOnPOLns; 0)
	ARRAY REAL:C219(aQtyOnHand; 0)
	ARRAY REAL:C219(aCosts; 0)
	ARRAY LONGINT:C221(aLeadTime; 0)
	ARRAY LONGINT:C221(aFactor; 0)
	$stopItems:=False:C215
	$stopDivs:=False:C215
	Repeat 
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Processing Daily Sales")
		
		If (<>ThermoAbort)
			$doLoop:=False:C215
			UNLOAD RECORD:C212([DInventory:36])  //drive to rec num -1
		End if 
		If ($doLoop)
			$baseItem:=[DInventory:36]itemNum:1
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
			If (([Item:4]profile4:38="Expensed") | (Record number:C243([Item:4])=-1))
				Repeat 
					$i:=$i+1
					NEXT RECORD:C51([DInventory:36])
				Until (($baseItem#[DInventory:36]itemNum:1) | (Record number:C243([DInventory:36])=-1))
			Else 
				$w:=Size of array:C274(aLeadTime)+1
				Ray_InsertElems($w; 1; ->aPartNum; ->aPartDesc; ->aQtyOrd; ->aQtySold; ->aQtyOnPOLns; ->aQtyOnHand; ->aCosts; ->aLeadTime; ->aFactor)
				aPartNum{$w}:=[Item:4]itemNum:1
				aPartDesc{$w}:=[Item:4]description:7
				aFactor{$w}:=[Item:4]factor:44
				aLeadTime{$w}:=[Item:4]leadTimeSales:12
				aQtyOnHand{$w}:=[Item:4]qtyOnHand:14
				aQtyOnPOLns{$w}:=[Item:4]qtyOnPo:20
				aQtyOrd{$w}:=[Item:4]qtyOnSalesOrder:16
				Repeat 
					$i:=$i+1
					If (Length:C16([DInventory:36]typeID:14)>0)  // Modified by: williamjames (111216 checked for <= length protection)
						aCosts{$w}:=aCosts{$w}-Round:C94(([DInventory:36]unitPrice:21*[DInventory:36]qtyOnHand:2)*Num:C11([DInventory:36]typeID:14[[1]]="i"); 0)
						aQtySold{$w}:=aQtySold{$w}-([DInventory:36]qtyOnHand:2*Num:C11([DInventory:36]typeID:14[[1]]="i"))
					End if 
					NEXT RECORD:C51([DInventory:36])
				Until (($baseItem#[DInventory:36]itemNum:1) | (Record number:C243([DInventory:36])=-1))
			End if 
		End if 
	Until (Record number:C243([DInventory:36])=-1)
	//Thermo_Close 
	Progress QUIT($viProgressID)
	doSearch:=1
	If (iLoText1#"")
		If (iLoText1="all")
			ALL RECORDS:C47([Item:4])
			SELECTION TO ARRAY:C260([Item:4]itemNum:1; $aItemNums)
			REDUCE SELECTION:C351([Item:4]; 0)
		Else 
			TextToArray(iLoText1; ->aText1; ",")
			C_LONGINT:C283($incRay; $raySize)
			C_TEXT:C284($query)
			$raysize:=Size of array:C274(aText1)
			For ($incRay; 1; $raySize)
				If (aText1{$incRay}#"")
					If ($query="")
						$query:="Query([Item];[Item]Itemnum="+Txt_Quoted(aText1{$incRay}+"@")+";*)"
					Else 
						$query:=$query+"\r"+"Query([Item];|;[Item]Itemnum="+Txt_Quoted(aText1{$incRay}+"@")+";*)"
					End if 
				End if 
			End for 
			If ($query#"")
				$query:=$query+"\r"+"Query([Item])"
			End if 
			ExecuteText(0; $query)
			SELECTION TO ARRAY:C260([Item:4]itemNum:1; $aItemNums)
			REDUCE SELECTION:C351([Item:4]; 0)
		End if 
		If (Size of array:C274($aItemNums)>0)
			$raysize:=Size of array:C274($aItemNums)
			For ($incRay; 1; $raySize)
				$w:=Find in array:C230(aPartNum; $aItemNums{$incRay})
				If ($w<1)
					$w:=Size of array:C274(aLeadTime)+1
					Ray_InsertElems($w; 1; ->aPartNum; ->aPartDesc; ->aQtyOrd; ->aQtySold; ->aQtyOnPOLns; ->aQtyOnHand; ->aCosts; ->aLeadTime; ->aFactor)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$aItemNums{$incRay})
					aPartNum{$w}:=[Item:4]itemNum:1
					aPartDesc{$w}:=[Item:4]description:7
					aFactor{$w}:=[Item:4]factor:44
					aLeadTime{$w}:=[Item:4]leadTimeSales:12
					aQtyOnHand{$w}:=[Item:4]qtyOnHand:14
					aQtyOnPOLns{$w}:=[Item:4]qtyOnPo:20
					aQtyOrd{$w}:=[Item:4]qtyOnSalesOrder:16
					aCosts{$w}:=-99.11
					aQtySold{$w}:=0
				End if 
			End for 
			REDUCE SELECTION:C351([Item:4]; 0)
		End if 
	End if 
End if 