//%attributes = {"publishedWeb":true}

CONFIRM:C162("Import Pay Approvals")
If (OK=1)
	sumDoc:=Create document:C266("PayPost"+String:C10(DateTime_Enter))
	myDoc:=Open document:C264("")
	If (OK=1)
		ARRAY TEXT:C222(aText1; 31)
		vi1:=0
		Repeat 
			RECEIVE PACKET:C104(myDoc; aText1{1}; "\t")  //1_MerchID
			RECEIVE PACKET:C104(myDoc; aText1{2}; "\t")  // 2_Auth with AVS
			
			RECEIVE PACKET:C104(myDoc; aText1{3}; "\t")  // 3
			RECEIVE PACKET:C104(myDoc; aText1{4}; "\t")  // 4
			
			RECEIVE PACKET:C104(myDoc; aText1{5}; "\t")  //5_OrdNum_PayID
			RECEIVE PACKET:C104(myDoc; aText1{6}; "\t")  //6_AcctNum
			RECEIVE PACKET:C104(myDoc; aText1{7}; "\t")  //7_TranAmt
			RECEIVE PACKET:C104(myDoc; aText1{8}; "\t")  //8_ExpDate
			RECEIVE PACKET:C104(myDoc; aText1{9}; "\t")  //9_OrdDate
			RECEIVE PACKET:C104(myDoc; aText1{10}; "\t")  //10_MoTo Flag
			RECEIVE PACKET:C104(myDoc; aText1{11}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{12}; "\t")  //12
			RECEIVE PACKET:C104(myDoc; aText1{13}; "\t")  //13_Name
			
			RECEIVE PACKET:C104(myDoc; aText1{14}; "\t")  //14
			RECEIVE PACKET:C104(myDoc; aText1{15}; "\t")  //15
			RECEIVE PACKET:C104(myDoc; aText1{16}; "\t")  //16
			RECEIVE PACKET:C104(myDoc; aText1{17}; "\t")  //17
			RECEIVE PACKET:C104(myDoc; aText1{18}; "\t")  //18
			RECEIVE PACKET:C104(myDoc; aText1{19}; "\t")  //19
			
			RECEIVE PACKET:C104(myDoc; aText1{20}; "\t")  //20_Avs Required
			
			
			RECEIVE PACKET:C104(myDoc; aText1{21}; "\t")  //11        
			RECEIVE PACKET:C104(myDoc; aText1{22}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{23}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{24}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{25}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{26}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{27}; "\t")  //11
			RECEIVE PACKET:C104(myDoc; aText1{28}; "\t")  //11
			
			RECEIVE PACKET:C104(myDoc; aText1{29}; "\t")  //29_Clerk
			RECEIVE PACKET:C104(myDoc; aText1{30}; "\t")  //30_TaxAmt
			RECEIVE PACKET:C104(myDoc; aText1{31}; "\r")  //31_CustID
			If (OK=1)
				QUERY:C277([Payment:28]; [Payment:28]idNum:8=Num:C11(aText1{5}))
				Case of 
					: (Records in selection:C76([Payment:28])=0)
						SEND PACKET:C103(sumDoc; aText1{5}+"\t"+"Not Found"+"\r")
					: (Locked:C147([Payment:28]))
						SEND PACKET:C103(sumDoc; aText1{5}+"\t"+"Locked, Not Posted"+"\r")
					: ([Payment:28]cardApproval:15#"Sent")
						SEND PACKET:C103(sumDoc; aText1{5}+"\t"+"Not Sent"+"\r")
					: ([Payment:28]cardApproval:15="Sent")
						[Payment:28]cardApproval:15:=aText1{11}
						SAVE RECORD:C53([Payment:28])
						SEND PACKET:C103(sumDoc; aText1{5}+"\t"+"Posted"+"\r")
				End case 
			Else 
				vi1:=1
			End if 
		Until (vi1=1)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
	CLOSE DOCUMENT:C267(sumDoc)
End if 