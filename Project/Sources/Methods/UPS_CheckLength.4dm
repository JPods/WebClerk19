//%attributes = {"publishedWeb":true}
//Method: UPS_CheckLength
C_LONGINT:C283($1; $allowedLength)
C_POINTER:C301($2; $ptItem)
If (Count parameters:C259>0)
	$allowedLength:=$1
	If (Count parameters:C259>1)
		$ptItem:=$2
	Else 
		$ptItem:=(->[LoadItem:87]ItemNum:3)
	End if 
Else 
	$allowedLength:=35
	$ptItem:=(->[LoadItem:87]ItemNum:3)
End if 
TRACE:C157
$cntOrd:=Records in selection:C76([Order:3])
FIRST RECORD:C50([Order:3])
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText2; 0)
ARRAY REAL:C219(aReal1; 0)
ARRAY REAL:C219(aReal2; 0)
ARRAY REAL:C219(aReal3; 0)
For ($incOrd; 1; $cntOrd)
	MESSAGE:C88(String:C10($incOrd))
	QUERY:C277([LoadItem:87]; [LoadItem:87]tableNum:1=3; *)
	QUERY:C277([LoadItem:87];  & [LoadItem:87]orderNum:2=[Order:3]orderNum:2)
	$cntLoads:=Records in selection:C76([LoadItem:87])
	If ($cntLoads=0)
		$cntElements:=Size of array:C274(aText2)+1
		INSERT IN ARRAY:C227(aText1; $cntElements; 1)
		INSERT IN ARRAY:C227(aText2; $cntElements; 1)
		INSERT IN ARRAY:C227(aReal1; $cntElements; 1)
		INSERT IN ARRAY:C227(aReal2; $cntElements; 1)
		INSERT IN ARRAY:C227(aReal3; $cntElements; 1)
		aReal1{$cntElements}:=[Order:3]orderNum:2
		aReal2{$cntElements}:=-3
		aReal3{$cntElements}:=-3
		aText1{$cntElements}:=""
		aText2{$cntElements}:=""
	Else 
		vText7:=""
		SELECTION TO ARRAY:C260([LoadItem:87]ItemNum:3; aTmp35Str1; [LoadItem:87]Quantity:7; aTmpReal1; [LoadItem:87]PackGroupID:9; aTmpLong1)
		MULTI SORT ARRAY:C718(aTmpLong1; >; aTmp35Str1; >; aTmpReal1)
		C_LONGINT:C283($i; $k; $packNum; $wItem)
		$i:=1
		$k:=Size of array:C274(aTmpLong1)
		ARRAY TEXT:C222($aTmpItem; 0)
		ARRAY REAL:C219($aTmpQty; 0)
		If ($k>0)
			$packNum:=aTmpLong1{1}
			$testItem:="lkjl;ijiolkajslfkas"
			While (($i<=$k) & ($packNum#305252))
				While (($packNum=aTmpLong1{$i}) & ($i<=$k))
					If ($testItem=aTmp35Str1{$i})
						$aTmpQty{$wItem}:=$aTmpQty{$wItem}+aTmpReal1{$i}
					Else 
						$wItem:=Size of array:C274($aTmpItem)+1
						INSERT IN ARRAY:C227($aTmpItem; $wItem; 1)
						INSERT IN ARRAY:C227($aTmpQty; $wItem; 1)
						$aTmpItem{$wItem}:=aTmp35Str1{$i}
						$aTmpQty{$wItem}:=aTmpReal1{$i}
						$testItem:=aTmp35Str1{$i}
					End if 
					If ($i<$k)
						$i:=$i+1
					Else 
						$packNum:=305252  //break out
					End if 
				End while 
				If ($packNum#305252)
					$packNum:=aTmpLong1{$i}
				End if 
				SORT ARRAY:C229($aTmpItem; $aTmpQty)
				C_LONGINT:C283($cntRay; $incRay)
				$cntRay:=Size of array:C274($aTmpItem)
				$cntElements:=Size of array:C274(aText2)+1
				INSERT IN ARRAY:C227(aText1; $cntElements; 1)
				INSERT IN ARRAY:C227(aText2; $cntElements; 1)
				INSERT IN ARRAY:C227(aReal1; $cntElements; 1)
				INSERT IN ARRAY:C227(aReal2; $cntElements; 1)
				INSERT IN ARRAY:C227(aReal3; $cntElements; 1)
				aReal1{$cntElements}:=[Order:3]orderNum:2
				aReal2{$cntElements}:=$packNum
				For ($incRay; 1; $cntRay)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$aTmpItem{$incRay})
					If (Records in selection:C76([Item:4])=0)
						$theitem:="missing"
					Else 
						$theitem:=$ptItem->
					End if 
					aReal3{$cntElements}:=aReal3{$cntElements}+$aTmpQty{$incRay}
					aText1{$cntElements}:=aText1{$cntElements}+(Num:C11(aText1{$cntElements}#"")*"_")+$theitem+"="+String:C10($aTmpQty{$incRay})
					aText2{$cntElements}:=aText2{$cntElements}+(Num:C11(aText2{$cntElements}#"")*"_")+$aTmpItem{$incRay}+"="+String:C10($aTmpQty{$incRay})
				End for 
				ARRAY TEXT:C222($aTmpItem; 0)
				ARRAY REAL:C219($aTmpQty; 0)
			End while 
		End if 
	End if 
	If (vHere<2)
		NEXT RECORD:C51([Order:3])
	End if 
End for 
$cntOrd:=Size of array:C274(aText1)
For ($incOrd; $cntOrd; 1; -1)
	If (Length:C16(aText1{$incOrd})<$allowedLength)
		DELETE FROM ARRAY:C228(aText1; $incOrd; 1)
		DELETE FROM ARRAY:C228(aText2; $incOrd; 1)
		DELETE FROM ARRAY:C228(aReal1; $incOrd; 1)
		DELETE FROM ARRAY:C228(aReal2; $incOrd; 1)
		DELETE FROM ARRAY:C228(aReal3; $incOrd; 1)
	End if 
End for 
UNLOAD RECORD:C212([LoadItem:87])
//  
REDRAW WINDOW:C456