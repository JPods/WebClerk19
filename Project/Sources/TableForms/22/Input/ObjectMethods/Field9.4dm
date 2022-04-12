If (([ItemXRef:22]Currency:16#"") & ([ItemXRef:22]Currency:16#<>tcMONEYCHAR) & (vrExRate#0))
	$error:=Exch_GetCurr([ItemXRef:22]Currency:16)  //sets viExConPrec, viExDisPrec  
	viLoR1:=Round:C94([ItemXRef:22]Cost:7*vrExRate; viExDisPrec)
Else 
	viLoR1:=0
End if 