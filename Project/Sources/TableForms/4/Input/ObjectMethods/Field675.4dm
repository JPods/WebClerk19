If ([Item:4]bonusPrice:69<0)
	ALERT:C41("Value must be zero or greater")
	[Item:4]bonusPrice:69:=0
End if 