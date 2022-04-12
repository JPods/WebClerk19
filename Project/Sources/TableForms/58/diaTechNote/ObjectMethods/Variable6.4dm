If (aTNName>1)
	GOTO SELECTED RECORD:C245([TechNote:58]; (aTNName-1))
	srTNName:=[TechNote:58]Name:2
	srTNSubject:=[TechNote:58]Subject:6
End if 
aTNName:=1