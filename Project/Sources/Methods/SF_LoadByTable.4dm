//%attributes = {}
Case of 
	: (process_o.dataClassName="AdSource")
		Form:C1466.Document:=New object:C1471("up"; Form:C1466)
		OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
End case 