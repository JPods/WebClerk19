
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (LB_Document_cur#Null:C1517)
				var $show_o : Object
				$show_o:=New object:C1471("tableName"; "Document"; "task"; "ShowRecords"; "form"; "Output"; "data"; LB_Document_sel)
				$obNewProcess:=New process:C317("ProcessObject"; 0; "Document-"+String:C10(Count tasks:C335); $show_o)
			Else 
				
				var $show_o : Object
				$show_o:=New object:C1471("tableName"; "Document"; "task"; "ShowRecords"; "form"; "Output"; "data"; LBDocument_ent)
				$obNewProcess:=New process:C317("ProcessObject"; 0; "Document-"+String:C10(Count tasks:C335); $show_o)
				
		End case 
End case 