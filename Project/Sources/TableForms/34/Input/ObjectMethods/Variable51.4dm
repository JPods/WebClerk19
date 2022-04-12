C_LONGINT:C283($curSeconds)
$curSeconds:=DateTime_Enter
[CallReport:34]durationPlanned:5:=Round:C94(($curSeconds-vlStart)/60; 1)+[CallReport:34]durationPlanned:5
_O_OBJECT SET COLOR:C271([CallReport:34]durationPlanned:5; -(15+(256*1)))
vlStart:=0