//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: QA_Import
	//Date: 03/11/03
	//Who: Bill
	//Description:   Import QA from Spread Sheet Format
End if 
//If (Count parameters=0)
vText1:=Request:C163("Question")
//Else 
//vText1:=$1
//OK:=1
//End if 
If (OK=1)
	QUERY:C277([QAQuestion:71]; [QAQuestion:71]questionType:2=vText1)
	
	vi2:=Records in selection:C76([QAQuestion:71])
	If (vi2>0)
		myDoc:=EI_UniqueDoc(Storage:C1525.folder.jitF+vText1+".txt")
		For (vi1; 1; vi2)
			SEND PACKET:C103(myDoc; "Q"+"\t"+String:C10([QAQuestion:71]seq:4)+"\t"+String:C10([QAQuestion:71]TableGroup:7)+"\t"+[QAQuestion:71]questionType:2+"\t"+[QAQuestion:71]question:3+"\r")
			QUERY:C277([QAAnswer:72]; [QAAnswer:72]idNumQAQuestion:1=[QAQuestion:71]idNum:1)
			vi4:=Records in selection:C76([QAAnswer:72])
			If (vi4>0)
				For (vi3; 1; vi4)
					SEND PACKET:C103(myDoc; "A"+"\t"+String:C10([QAAnswer:72]idNumQAQuestion:1)+String:C10([QAAnswer:72]idNum:2)+"\t"+[QAAnswer:72]answer:3+"\r")
					NEXT RECORD:C51([QAAnswer:72])
				End for 
			End if 
			NEXT RECORD:C51([QAQuestion:71])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 
