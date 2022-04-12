Case of 
	: (Before:C29)
		C_TEXT:C284(errorComment)
		If (errorComment="")
			If (vsBarCdFld#"")
				errorComment:=<>pkScaleComment+"\r"+"\r"+"Barcode: "+vsBarCdFld
			Else 
				errorComment:=<>pkScaleComment
			End if 
		End if 
	: (After:C31)
		errorComment:=""
End case 