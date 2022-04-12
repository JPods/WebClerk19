//%attributes = {"publishedWeb":true}
//Procedure: Srvr_ReSelect
//Noah Dykoski  June 15, 1998 / 4:37 PM

MESSAGES OFF:C175
CREATE EMPTY SET:C140([Customer:2]; "CurCust")
CREATE EMPTY SET:C140([Contact:13]; "CurContact")
CREATE EMPTY SET:C140([Lead:48]; "CurLead")
CREATE EMPTY SET:C140([Service:6]; "CurServ")
CREATE EMPTY SET:C140([CallReport:34]; "CurCallReports")
C_LONGINT:C283($index; $soa)
$soa:=Size of array:C274(aSrvLines)
For ($index; 1; $soa)
	Case of 
		: (aServiceTableName{aSrvLines{$index}}="C")
			GOTO RECORD:C242([Customer:2]; aServiceRecs{aSrvLines{$index}})
			ADD TO SET:C119([Customer:2]; "CurCust")
		: (aServiceTableName{aSrvLines{$index}}="i")
			GOTO RECORD:C242([Contact:13]; aServiceRecs{aSrvLines{$index}})
			ADD TO SET:C119([Contact:13]; "CurContact")
		: (aServiceTableName{aSrvLines{$index}}="L")
			GOTO RECORD:C242([Lead:48]; aServiceRecs{aSrvLines{$index}})
			ADD TO SET:C119([Lead:48]; "CurLead")
		: (aServiceTableName{aSrvLines{$index}}="S")
			GOTO RECORD:C242([Service:6]; aServiceRecs{aSrvLines{$index}})
			ADD TO SET:C119([Service:6]; "CurServ")
		: (aServiceTableName{aSrvLines{$index}}="R")
			GOTO RECORD:C242([CallReport:34]; aServiceRecs{aSrvLines{$index}})
			ADD TO SET:C119([CallReport:34]; "CurCallReports")
	End case 
End for 
USE SET:C118("CurCust")
CLEAR SET:C117("CurCust")
USE SET:C118("CurContact")
CLEAR SET:C117("CurContact")
USE SET:C118("CurLead")
CLEAR SET:C117("CurLead")
USE SET:C118("CurServ")
CLEAR SET:C117("CurServ")
USE SET:C118("CurCallReports")
CLEAR SET:C117("CurCallReports")
If (Records in selection:C76([Customer:2])>0)
	ProcessTableOpen(Table:C252(->[Customer:2])*-1)
End if 
If (Records in selection:C76([Contact:13])>0)
	ProcessTableOpen(Table:C252(->[Contact:13])*-1)
End if 
If (Records in selection:C76([Lead:48])>0)
	ProcessTableOpen(Table:C252(->[Lead:48])*-1)
End if 
If (Records in selection:C76([Service:6])>0)
	ProcessTableOpen(Table:C252(->[Service:6])*-1)
End if 
If (Records in selection:C76([CallReport:34])>0)
	ProcessTableOpen(Table:C252(->[CallReport:34])*-1)
End if 


MESSAGES ON:C181