//%attributes = {"publishedWeb":true}
//(GP)OrderItmQtyList 
C_POINTER:C301($1; $2)  //$1 points to string array(Item Nums), $2 points to real array(Quantities)

For ($index; 1; Size of array:C274($1->))  //arrays will be the same size  
	pPartNum:=$1->{$index}
	If (ptCurTable=(->[Invoice:26]))
		pQtyShip:=$2->{$index}
	Else 
		pQtyOrd:=$2->{$index}
	End if 
	QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
	listItemsFill(ptCurTable; True:C214)
End for 