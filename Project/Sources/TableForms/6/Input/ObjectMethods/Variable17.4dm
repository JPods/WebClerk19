If (aAttributes>1)
	jRayAtts(1)
	[Service:6]AttNum:24:=aAttNums{aAttributes}
	[Service:6]attribute:5:=aAttributes{aAttributes}
	[Service:6]cause:7:=""
	[Service:6]CauseNum:25:=0
End if 
aAttributes:=1
// zzzqqq U_DTStampFldMod(->[Service:6]comment:11; ->[Service:6]attribute:5)