C_LONGINT:C283($i; $w)
CREATE EMPTY SET:C140([QQQTime:56]; "Current")
For ($i; 1; Size of array:C274(aTCTimeRecs))
	GOTO RECORD:C242([QQQTime:56]; aTCTimeRecs{$i})
	ADD TO SET:C119([QQQTime:56]; "Current")
End for 
USE SET:C118("Current")
CLEAR SET:C117("Current")
TC_SheetsReport