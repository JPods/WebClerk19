//%attributes = {"publishedWeb":true}
//PM: BOM_BuildCalcQty
C_REAL:C285($1; $QtyRequested)  // QtyRequested; input only
$QtyRequested:=$1
C_POINTER:C301($2; $QtyOnHand)  //QtyOnHand; input and output
$QtyOnHand:=$2
C_POINTER:C301($3; $QtyAdjOnHand)  //QtyAdjOnHand;output only
$QtyAdjOnHand:=$3

Case of 
	: ((($QtyRequested>=0) & ($QtyOnHand->>=0)))  //+, +
		If ($QtyRequested>$QtyOnHand->)
			$QtyAdjOnHand->:=$QtyRequested-$QtyOnHand->
			$QtyOnHand->:=0
		Else 
			$QtyAdjOnHand->:=0
			$QtyOnHand->:=$QtyOnHand->-$QtyRequested
		End if 
	: ((($QtyRequested<0) & ($QtyOnHand->>=0)))  // -, +
		$QtyAdjOnHand->:=$QtyRequested
		$QtyOnHand->:=$QtyOnHand->-$QtyRequested
	: ((($QtyRequested>=0) & ($QtyOnHand-><0)))  // +, -
		$QtyAdjOnHand->:=$QtyRequested
		$QtyOnHand->:=$QtyOnHand->-$QtyRequested
	: ((($QtyRequested<0) & ($QtyOnHand-><0)))  // -, -
		If ($QtyRequested<$QtyOnHand->)
			$QtyAdjOnHand->:=$QtyRequested-$QtyOnHand->
			$QtyOnHand->:=0
		Else 
			$QtyAdjOnHand->:=0
			$QtyOnHand->:=$QtyOnHand->-$QtyRequested
		End if 
End case 