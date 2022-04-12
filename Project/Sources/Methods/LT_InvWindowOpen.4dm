//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $p; $w)
vDiaCom:="Load List"
jCenterWindow(565; 315; 1)
DIALOG:C40([LoadTag:88]; "OrdLoad")
CLOSE WINDOW:C154
vDiaCom:=""
If (OK=1)
	LT_FillArrayLoadItems(-5)
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