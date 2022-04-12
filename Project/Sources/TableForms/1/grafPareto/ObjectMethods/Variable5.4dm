jCenterWindow(660; 400; 1)
DIALOG:C40([Control:1]; "diaPareto")
CLOSE WINDOW:C154
Case of 
	: (b1=1)
		//  StructureFields (File([Processe]))
		jParetoGraf(-><>aProcesses; 1; ->[Service:6]; 4)
	: (b2=1)
		//   StructureFields (File([Attribute]))
		jParetoGraf(->aAttributes; 2; ->[Service:6]; 5)
	: (b3=1)
		//   StructureFields (File([Cause]))
		jParetoGraf(->aCauses; 3; ->[Service:6]; 7)
End case 
viRecordsInSelection:=Records in selection:C76([Service:6])