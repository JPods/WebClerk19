If (aTNSub>1)
	GOTO SELECTED RECORD:C245([TechNote:58]; (aTNSub-1))
	srTNName:=[TechNote:58]Name:2
	srTNSubject:=[TechNote:58]Subject:6
End if 
aTNSub:=1