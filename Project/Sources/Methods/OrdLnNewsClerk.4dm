//%attributes = {"publishedWeb":true}
//Method: OrdLnNewsClerk
QUERY:C277([TallyResult:73]; [TallyResult:73]Purpose:2="NewsClerk"; *)
If (pvLnProfile3#"")
	QUERY:C277([TallyResult:73];  & [TallyResult:73]Profile1:17=pvLnProfile3; *)
End if 
QUERY:C277([TallyResult:73];  & [TallyResult:73]Name:1=pvLnProfile2)
pBasePrice:=[TallyResult:73]Real1:13
pUnitPrice:=[TallyResult:73]Real1:13
pExtPrice:=Round:C94(pUnitPrice*[TallyResult:73]Real2:14; <>tcDecimalTt)
pQtyOrd:=[TallyResult:73]Real2:14
pDiscnt:=0
UNLOAD RECORD:C212([TallyResult:73])