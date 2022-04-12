//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w; $fromOne; $totalEnd)
$k:=Size of array:C274(aTmpLong1)
$w:=Size of array:C274(aCustType)+1
$totalEnd:=$k+$w-1
INSERT IN ARRAY:C227(aCustType; $w; $k)
INSERT IN ARRAY:C227(aCustomers; $w; $k)
INSERT IN ARRAY:C227(aCustCity; $w; $k)
INSERT IN ARRAY:C227(aCustAttn; $w; $k)
INSERT IN ARRAY:C227(aCustZip; $w; $k)
INSERT IN ARRAY:C227(aCustPhone; $w; $k)
INSERT IN ARRAY:C227(aCustCodes; $w; $k)
INSERT IN ARRAY:C227(aCustRep; $w; $k)
INSERT IN ARRAY:C227(aCustSales; $w; $k)
INSERT IN ARRAY:C227(aRecNum; $w; $k)
$fromOne:=0
For ($i; $w; $totalEnd)
	$fromOne:=$fromOne+1
	aCustType{$i}:=aTmp2Str1{$fromOne}
	aCustomers{$i}:=aQueryFieldNames{$fromOne}
	aCustCity{$i}:=aTmp40Str2{$fromOne}
	aCustAttn{$i}:=aTmpText1{$fromOne}
	aCustZip{$i}:=aTmp12Str1{$fromOne}
	aCustPhone{$i}:=aTmp20Str1{$fromOne}
	aCustCodes{$i}:=aTmp10Str1{$fromOne}
	aCustRep{$i}:=aTmp25Str1{$fromOne}
	aCustSales{$i}:=aTmp25Str2{$fromOne}
	aRecNum{$i}:=aTmpLong1{$fromOne}
End for 