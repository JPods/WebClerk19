//%attributes = {}



QUERY:C277([Order:3]; [Order:3]orderNum:2=94063)
DELETE SELECTION:C66([Order:3])



//  46987-Orders
// 69713-Invoices
// 8016-Proposals
// 56291-POs

READ WRITE:C146([PO:39])
READ WRITE:C146([POLine:40])
QUERY:C277([PO:39]; [PO:39]poNum:5=114891)
QUERY:C277([POLine:40]; [POLine:40]poNum:1=114891)
[PO:39]poNum:5:=891
[PO:39]comment:27:="PONum changed from 114891 to 891"+"\r"+[PO:39]comment:27
SAVE RECORD:C53([PO:39])
vi2:=Records in selection:C76([POLine:40])
FIRST RECORD:C50([POLine:40])
For (vi1; 1; vi2)
	[POLine:40]poNum:1:=891
	SAVE RECORD:C53([POLine:40])
	NEXT RECORD:C51([POLine:40])
End for 

QUERY:C277([PO:39]; [PO:39]poNum:5=114273)
QUERY:C277([POLine:40]; [POLine:40]poNum:1=114273)
[PO:39]poNum:5:=891
[PO:39]comment:27:="PONum changed from 114273 to 273"+"\r"+[PO:39]comment:27
SAVE RECORD:C53([PO:39])
vi2:=Records in selection:C76([POLine:40])
FIRST RECORD:C50([POLine:40])
For (vi1; 1; vi2)
	[POLine:40]poNum:1:=273
	SAVE RECORD:C53([POLine:40])
	NEXT RECORD:C51([POLine:40])
End for 

QUERY:C277([PO:39]; [PO:39]poNum:5=114147)
QUERY:C277([POLine:40]; [POLine:40]poNum:1=114147)
[PO:39]poNum:5:=891
[PO:39]comment:27:="PONum changed from 114147 to 147"+"\r"+[PO:39]comment:27
SAVE RECORD:C53([PO:39])
vi2:=Records in selection:C76([POLine:40])
FIRST RECORD:C50([POLine:40])
For (vi1; 1; vi2)
	[POLine:40]poNum:1:=147
	SAVE RECORD:C53([POLine:40])
	NEXT RECORD:C51([POLine:40])
End for 

UNLOAD RECORD:C212([PO:39])
UNLOAD RECORD:C212([POLine:40])



QUERY:C277([PO:39];  | ; [PO:39]poNum:5=114147)
ALERT:C41("Pos "+String:C10(Records in selection:C76([PO:39])))
UNLOAD RECORD:C212([PO:39])

// Same with POLines

QUERY:C277([POLine:40];  | ; [POLine:40]poNum:1=114273; *)
QUERY:C277([POLine:40];  | ; [POLine:40]poNum:1=114147)
ALERT:C41("PoLines "+String:C10(Records in selection:C76([POLine:40])))
UNLOAD RECORD:C212([PO:39])

