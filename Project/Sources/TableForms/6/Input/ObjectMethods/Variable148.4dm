C_LONGINT:C283($curSeconds)
$curSeconds:=DateTime_Enter
[Service:6]timer:34:=[Service:6]timer:34+1+(($curSeconds-[Service:6]dtAction:35)\60)
KeyModifierCurrent
If (OptKey=1)
	// zzzqqq jDateTimeStamp(->[Service:6]comment:11)
End if 
_O_OBJECT SET COLOR:C271([Service:6]timer:34; -(15+(256*1)))