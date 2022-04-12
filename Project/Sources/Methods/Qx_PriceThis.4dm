//%attributes = {"publishedWeb":true}
//Procedure: Qx_PriceThis
C_LONGINT:C283($p; $i; $cntLines; $firstFont; $numPoints)
C_TEXT:C284($working)
ARRAY REAL:C219($aFontPoints; 0)
$working:=[WorkOrder:66]Description:3
Repeat 
	$p:=Position:C15("<z"; $working)
	If ($p>0)
		$w:=Size of array:C274($aFontPoints)+1
		INSERT IN ARRAY:C227($aFontPoints; $w; 1)
		$working:=Substring:C12($working; $p+1)
		$p:=Position:C15(">"; $working)
		$aFontPoints{$w}:=Num:C11(Substring:C12($working; 1; $p-1))
	End if 
Until ($p=0)
$k:=Size of array:C274($aFontPoints)
If ($k>0)
	$cntLines:=1
	If ($aFontPoints{1}>18)
		$cntLines:=2
	End if 
	For ($i; 2; $k)
		$cntLines:=$cntLines+($aFontPoints{$i}\24)+1
	End for 
End if 
vUseBase:=SetPricePoint([QQQCustomer:2]typeSale:18)
//[WorkOrder]UnitCost:=[Item]PriceB*$cntLines
[WorkOrder:66]WOPrice:47:=Field:C253(4; vUseBase)->  //[Item]PriceA*$cntLines
//[WorkOrder]ItemNum:="WT"+String($cntLines;"00")
//