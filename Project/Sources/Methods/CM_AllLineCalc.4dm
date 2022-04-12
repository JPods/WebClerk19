//%attributes = {"publishedWeb":true}
//$0[Order]SalesCommission:=CM_AllLineCalc ($6viSaleMar;$4vComSales
//;$7aOExtPrice;$8aOExtCost;$9aOSalesRate;$10aOSaleComm;$12aOQtyOrder)
C_LONGINT:C283($i; $1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8)
C_REAL:C285($theCom; $0)
If (allowAlerts_boo)
	CONFIRM:C162("Change all lines to a new commission rate?")
Else 
	OK:=1
End if 
If (OK=1)
	$theCom:=0
	For ($i; 1; Size of array:C274($3->))
		$5->{$i}:=$2->
		If ($8->{$i}#-3)
			$8->{$i}:=-3000  //line dirty
		End if 
		CM_LineCalc($1; $i; $3; $4; $5; $6; $7)  //(viSaleMar;$i;aOExtPrice;aOExtCost;aORepRate;aORepComm;aOQtyOrder)
		$theCom:=$theCom+$6->{$i}
	End for 
	$0:=$theCom  //[Invoice]RepCommission:=Round($repCom;TOTPREC)
End if 