//array TEXT(<>aWoTypes;0)
If (<>aWoTypes>0)
	QUERY:C277([WOTemplate:69]; [WOTemplate:69]TypeWO:9=<>aWoTypes{<>aWoTypes})
	WO_FillStepRays(Records in selection:C76([WOTemplate:69]))
	doSearch:=1
Else 
	<>aWoTypes:=1
End if 