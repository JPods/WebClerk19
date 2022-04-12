//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 02/04/10, 15:20:43
// ----------------------------------------------------
// Method: PKPalletPack
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	//Method:Method: PKPalletPack
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
<>pkScaleComment:=""  //clear any existing error message
//If (Size of array(aLiLoadTagID)=0)
//ALERT("There are no records to save.")
//Else 
//LT_FillArrayLoadItems (-5)
//End if 
//
$doSuperiorWt:=False:C215
$err:=1
If (Count parameters:C259<2)
	ALERT:C41("Missing parameters")
Else 
	C_LONGINT:C283($1; $addPallet; $2; $doSelectOnly)
	C_TEXT:C284($3; $dialogMessage)
	If ($1=-3)
		$addPallet:=$1
		$packID:=-3
	Else 
		$packID:=$1
	End if 
	$doSelectOnly:=$2  //which boxes to pack
	If ($2=1)
		$k:=Size of array:C274(aShipSel)
		If ($k>0)
			C_LONGINT:C283($packID; $i; $k; $err)
			$err:=0  //set error to zero before this check
			For ($i; 1; $k)  //see if any packages are already in a pallet
				If (aPKUniqueIDSuperior{aShipSel{$i}}#0)
					$err:=$err+1
					$i:=$k
				End if 
			End for 
			If ($err>0)
				ALERT:C41("Some selected boxes are already on pallets")
				$err:=1
			End if 
		Else 
			$err:=1
			ALERT:C41("There are no boxes selected to put on pallets.")
		End if 
	Else 
		$k:=Size of array:C274(aPKWeightExtended)
		ARRAY LONGINT:C221(aShipSel; $k)
		For ($i; 1; $k)
			aShipSel{$i}:=$i
		End for 
		For ($i; $k; 1; -1)
			If (aPKUniqueIDSuperior{aShipSel{$i}}#0)
				DELETE FROM ARRAY:C228(aShipSel; $i; 1)
			End if 
		End for 
		$k:=Size of array:C274(aShipSel)
		If ($k>0)
			$err:=0
		Else 
			ALERT:C41("Packages already palletized or there are no packages")
		End if 
	End if 
End if 
If ($err=0)
	If ($addPallet=-3)
		CREATE RECORD:C68([LoadTag:88])
		$packID:=[LoadTag:88]idNum:1
		[LoadTag:88]containerType:26:=2
		[LoadTag:88]status:6:="Pending"
		[LoadTag:88]trackingid:7:="Not Assigned"
		[LoadTag:88]carrierid:8:=[Order:3]shipVia:13
		[LoadTag:88]customerID:23:=[Order:3]customerID:1
		[LoadTag:88]idNumOrder:29:=[Order:3]idNum:2
		[LoadTag:88]tableNum:34:=3
		[LoadTag:88]documentID:17:=[LoadTag:88]idNumOrder:29
		[LoadTag:88]dtShipOn:10:=DateTime_Enter
		[LoadTag:88]dtAssembly:9:=DateTime_Enter  //###_jwm_### 20100204
		[LoadTag:88]dateDocument:39:=Current date:C33  //###_jwm_### 20100204
		SAVE RECORD:C53([LoadTag:88])
		$recNumPallet:=Record number:C243([LoadTag:88])
	End if 
	For ($i; 1; $k)  //handle selected elements
		//$theWt:=$theWt+aPKWeightExtended{aShipSel{$i}}
		aPKUniqueIDSuperior{aShipSel{$i}}:=$packID
		PKArrayManage(-4; aShipSel{$i})  //manage pallet record
	End for 
	
	PKPalletWeightReCalc($packID)
	//
	viVert:=1
	ARRAY LONGINT:C221(aShipSel; 1)
	aShipSel{1}:=1
	//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
	// -- AL_SetScroll(eShipList; viVert; viHorz)
	// -- AL_SetSelect(eShipList; aShipSel)
End if 