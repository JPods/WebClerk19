If (InvcOkToChange)
	[Invoice:26]repCommission:28:=CM_AllLineCalc(<>tcSaleMar; Self:C308; ->aiExtPrice; ->aiExtCost; ->aiRepRate; ->aiRepComm; ->aiQtyShip; ->aiLineAction)
Else 
	vComRep:=CM_FindRate(->[Invoice:26]repId:22; -><>aReps; -><>aRepRate)
End if 
