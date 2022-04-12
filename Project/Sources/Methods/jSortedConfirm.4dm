//%attributes = {"publishedWeb":true}
If (booSorted)
	CONFIRM:C162("Printing/saving will cause a loss of your sort.")
	If (OK=1)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=True:C214
End if 