C_LONGINT:C283($curSeconds)
$curSeconds:=DateTime_Enter
vrDuration:=Round:C94(($curSeconds-vlStart)/60; 1)+vrDuration
_O_OBJECT SET COLOR:C271(vrDuration; -(15+(256*1)))
vlStart:=0