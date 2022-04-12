Case of 
	: (Before:C29)
		C_LONGINT:C283($i; $k; $error)
		LT_ALDefineLoadItems
		vi5:=1
		$k:=Size of array:C274(aLiTagGroup)
		For ($i; 1; $k)
			If (vi5<=aLiTagGroup{$i})
				vi5:=aLiTagGroup{$i}+1
			End if 
		End for 
	Else 
		
End case 