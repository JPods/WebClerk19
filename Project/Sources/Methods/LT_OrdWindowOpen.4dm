//%attributes = {"publishedWeb":true}
//LT_OrdWindowOpen
TRACE:C157
C_LONGINT:C283($i; $k; $p; $w)
TRACE:C157
//change from packing window
PKArrayManage(0)
C_LONGINT:C283(eShipList)
iLoInteger1:=1  //donot file <>vrWeightScale in LT_FillArrayLoadItems
<>vrWeightScale:=0
//
LT_FillArrayLoadItems(-12)
vDiaCom:="Load List"
jCenterWindow(571; 318; 5; "Load Tags")
DIALOG:C40([LoadTag:88]; "OrdLoad")
CLOSE WINDOW:C154
vDiaCom:=""
If (OK=1)
	TRACE:C157
	LT_FillArrayLoadItems(-55)
	C_LONGINT:C283($i; $k; $cntTags; $currTag)
	$k:=Size of array:C274(aLiTagGroup)
	$cntTags:=0
	If ($k>0)
		SORT ARRAY:C229(aLiTagGroup)
		$currTag:=-1
		For ($i; 1; $k)
			If (aLiTagGroup{$i}>$currTag)
				$currTag:=aLiTagGroup{$i}
				$cntTags:=$cntTags+1
			End if 
		End for 
	End if 
End if 
[Order:3]labelCount:32:=$cntTags
LT_FillArrayLoadItems(0)
doSearch:=0