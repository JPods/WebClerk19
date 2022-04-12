//COPY SET("UserSet";"<>curSelSet")
//UNLOAD RECORD(ptCurTable->)
TRACE:C157
If ([QQQMenu:107]ParentID:4>0)
	$viProcess:=New process:C317("PrsQueryMenu"; <>tcPrsMemory; "Query-"+String:C10(Count tasks:C335+1)+"-"+Table name:C256(ptCurTable); ptCurTable; (->[QQQMenu:107]ParentID:4); String:C10([QQQMenu:107]ParentID:4))
Else 
	ALERT:C41("This is a master menu")
End if 