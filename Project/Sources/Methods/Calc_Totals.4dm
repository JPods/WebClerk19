//%attributes = {"publishedWeb":true}
//Procedure: Calc_Totals
C_POINTER:C301($1; $2; $3; $4)
C_LONGINT:C283($k; $i)
C_REAL:C285($amtTotal; $totWt; $boxCnt)
C_LONGINT:C283(viBoxCnt; curLines)
//$1 amount
//$2 weight
//$3 Ln Count
//$4 Item Coun
//$5 array amount   //aOExtPrice{$i}
//$6 array Weight    //aOUnitWt{$i}
//$7 array Backlog   //aOQtyBL{$i}
$amtTotal:=0
$totWt:=0
$boxCnt:=0
$k:=Size of array:C274($5->)
For ($i; 1; $k)
	$amtTotal:=$amtTotal+$5->{$i}
	$totWt:=$totWt+($6->{$i}*$7->{$i})
	$boxCnt:=$boxCnt+$7->{$i}
End for 
$1->:=$amtTotal
If (Not:C34((ptCurTable=(->[Invoice:26])) & (Records in selection:C76([LoadTag:88])>0)))
	$2->:=$totWt
End if 
$3->:=$k
$4->:=$boxCnt