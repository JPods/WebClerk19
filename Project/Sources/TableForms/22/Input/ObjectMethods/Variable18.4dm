If (([ItemXRef:22]Currency:16#"") & ([ItemXRef:22]Currency:16#<>tcMONEYCHAR) & (vrExRate#0))
	$error:=Exch_GetCurr([ItemXRef:22]Currency:16)  //sets viExConPrec, viExDisPrec  
	[ItemXRef:22]Cost:7:=Round:C94(viLoR1/vrExRate; viExConPrec)
Else 
	viLoR1:=0
End if 