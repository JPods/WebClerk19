
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (LB_QA_sel#Null:C1517)
				var $show_o : Object
				$show_o:=New object:C1471("tableName"; "QA"; "task"; "ShowRecords"; "form"; "Output"; "data"; LB_QA_sel)
				$obNewProcess:=New process:C317("ProcessObject"; 0; "QA-"+String:C10(Count tasks:C335); $show_o)
				
			: (LB_QA_data#Null:C1517)
				var $show_o : Object
				$show_o:=New object:C1471("tableName"; "QA"; "task"; "ShowRecords"; "form"; "Output"; "data"; LB_QA_data)
				$obNewProcess:=New process:C317("ProcessObject"; 0; "QA-"+String:C10(Count tasks:C335); $show_o)
				
		End case 
End case 