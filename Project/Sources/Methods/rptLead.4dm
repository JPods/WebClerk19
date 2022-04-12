//%attributes = {"publishedWeb":true}
//(P) rptLead
C_LONGINT:C283($i; $k; $1; $1)
MESSAGES OFF:C175
v3:=""
READ ONLY:C145([Default:15])
QUERY:C277([Default:15]; [Default:15]primeDefault:176=1)
READ ONLY:C145([Contact:13])
READ ONLY:C145([Service:6])
PRINT SETTINGS:C106
If (OK=1)
	InitContactArra(0)
	ServiceArrayInit(0)
	If (vHere<2)
		FIRST RECORD:C50(ptCurTable->)
		$k:=Records in selection:C76(ptCurTable->)
	Else 
		$k:=1
		If (Record number:C243(ptCurTable->)=-3)
			SAVE RECORD:C53(ptCurTable->)
		End if 
	End if 
	For ($i; 1; $k)
		CustPrntSetVar(ptCurTable)
		If ($1=100)
			Print form:C5([Customer:2]; "rptLead")
		Else 
			Print form:C5([Customer:2]; "DayRunLead")
		End if 
		PAGE BREAK:C6
		If (vHere<2)
			SAVE RECORD:C53(ptCurTable->)
			NEXT RECORD:C51(ptCurTable->)
		End if 
	End for 
End if 
MESSAGES ON:C181
UNLOAD RECORD:C212([Default:15])
READ WRITE:C146([Contact:13])
READ WRITE:C146([Service:6])
InitContactArra(0)
ServiceArrayInit(0)