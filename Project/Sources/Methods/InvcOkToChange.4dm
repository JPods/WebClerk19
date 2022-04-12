//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)
If ([Invoice:26]jrnlComplete:48=False:C215)
	$0:=True:C214
Else 
	CONFIRM:C162("Changes to Rep Code will not affect A/R data.")
	If (OK=1)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
End if 