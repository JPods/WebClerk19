QUERY:C277([QA:70]; [QA:70]tableNum:11=Table:C252(->[Contact:13]); *)
QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Contact:13]idNum:28))
Self:C308->:=(Records in selection:C76([QA:70])>0)
If (Self:C308->)
	DB_ShowCurrentSelection(->[QA:70]; ""; 1; "")
Else 
	BEEP:C151
	BEEP:C151
End if 