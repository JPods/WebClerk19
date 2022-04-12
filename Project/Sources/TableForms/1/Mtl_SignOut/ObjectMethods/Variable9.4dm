$k:=Size of array:C274(aWDItemLine)
If ($k>0)
	$w:=Size of array:C274(aWdItemRec)
	C_LONGINT:C283($i; $k; $w; $inc)
	For ($i; 1; $k)
		For ($inc; 1; vi1)
			$w:=$w+1
			Wd_FillRay(-3; $w; 1)
			aWdItem{$w}:=aWdItem{aWDItemLine{$i}}  //[Item]ItemNum
			aWdDscrp{$w}:=aWdDscrp{aWDItemLine{$i}}  //[Item]Description
			aWdReason{$w}:=aWdReason{aWDItemLine{$i}}  //
			aWdQty{$w}:=aWdQty{aWDItemLine{$i}}  //[Item]QtySaleDefault
			aWdCost{$w}:=aWdCost{aWDItemLine{$i}}  //[Item]CostWtStd
			aWdSo{$w}:=aWdSo{aWDItemLine{$i}}  //0
			aWdComment{$w}:=aWdComment{aWDItemLine{$i}}  //[Item]CommentAlert
			aWdVendor{$w}:=aWdVendor{aWDItemLine{$i}}  //[Item]VendorKey
			aWdItemRec{$w}:=aWdItemRec{aWDItemLine{$i}}  //[Item]    
		End for 
	End for 
	doSearch:=18
End if 