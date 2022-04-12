//%attributes = {"publishedWeb":true}
//Procedure: BOM_SortbyPar
C_LONGINT:C283($i; $0; $k; $w)
ARRAY REAL:C219(aReal1; 0)
ARRAY REAL:C219(aReal2; 0)
ARRAY LONGINT:C221(aLongInt1; 0)
ARRAY TEXT:C222(aStr35; 0)
ARRAY TEXT:C222(a80Str1; 0)
$k:=Size of array:C274(aRptPartNum)
If ($k>0)
	For ($i; 1; $k)
		$w:=Find in array:C230(aStr35; aRptPartNum{$i})
		If ($w=-1)
			$w:=Size of array:C274(aStr35)+1
			INSERT IN ARRAY:C227(aStr35; $w)  //Item Num
			INSERT IN ARRAY:C227(aReal1; $w)  //Cost
			INSERT IN ARRAY:C227(aReal2; $w)  //Qty
			INSERT IN ARRAY:C227(aLongInt1; $w)  //Sales Ord
			INSERT IN ARRAY:C227(a80Str1; $w)  //Descript
			aStr35{$w}:=aRptPartNum{$i}
			a80Str1{$w}:=aRptPartDsc{$i}
			aReal1{$w}:=aCosts{$i}
			aReal2{$w}:=aQtyAct{$i}
			//      aLongInt1{$w}:=aBomRecs{$i}
			
			//If (Size of array(aSOs)>=$i)//why was this here
			//aLongInt1{$w}:=aSOs{$i}
			//End if 
			
		Else 
			aReal2{$w}:=aReal2{$w}+aQtyAct{$i}
		End if 
	End for 
End if 



