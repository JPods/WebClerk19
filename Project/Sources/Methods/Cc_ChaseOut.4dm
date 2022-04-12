//%attributes = {"publishedWeb":true}
CONFIRM:C162("Post Payments to Chase")
TRACE:C157
If (OK=1)
	FIRST RECORD:C50([Payment:28])
	vi2:=Records in selection:C76([Payment:28])
	vText1:="asdfasdf"  //Merchant ID
	If (vi2>0)
		myDoc:=Create document:C266("")
		For (vi1; 1; vi2)
			LOAD RECORD:C52([Payment:28])
			If ([Payment:28]customerID:4#[Customer:2]customerID:1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
			End if 
			Case of 
				: (Locked:C147([Payment:28]))
					// : ([Payment]CardApproval#"Pend")
				Else 
					If ([Order:3]orderNum:2#[Payment:28]orderNum:2)
						QUERY:C277([Order:3]; [Order:3]orderNum:2=[Payment:28]orderNum:2)
					End if 
					SEND PACKET:C103(myDoc; vText1+"\t")  //1_MerchID
					SEND PACKET:C103(myDoc; "1"+"\t")  // 2_Auth with AVS
					SEND PACKET:C103(myDoc; "\t"+"\t")  //3 & 4
					SEND PACKET:C103(myDoc; String:C10([Payment:28]idNum:8)+"\t")  //5_OrdNum_PayID
					SEND PACKET:C103(myDoc; CC_EncodeDecode(0; ""; ->[Payment:28]creditCardBlob:53)+"\t")  //6_AcctNum
					SEND PACKET:C103(myDoc; String:C10([Payment:28]amount:1; "###,###,##0.00")+"\t")  //7_TranAmt
					SEND PACKET:C103(myDoc; Date_StrMMYY([Payment:28]dateExpires:14)+"\t")  //8_ExpDate
					SEND PACKET:C103(myDoc; Date_strYrMmDd([Payment:28]dateReceived:10)+"\t")  //9_OrdDate
					SEND PACKET:C103(myDoc; "M"+"\t")  //10_MoTo Flag
					SEND PACKET:C103(myDoc; "\t"+"\t")  //11 & 12
					SEND PACKET:C103(myDoc; [Payment:28]nameOnAcct:11+"\t")  //13_Name
					SEND PACKET:C103(myDoc; [Payment:28]bankFrom:9+"\t")  //14_Addr1
					SEND PACKET:C103(myDoc; "\t")  //15_Addr2
					SEND PACKET:C103(myDoc; "\t")  //16_City
					SEND PACKET:C103(myDoc; "\t")  //17_Phone
					SEND PACKET:C103(myDoc; "\t")  //18_State
					SEND PACKET:C103(myDoc; [Payment:28]checkNum:12+"\t")  //19_Zip
					SEND PACKET:C103(myDoc; "Y"+"\t")  //20_Avs Required
					SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t")  //21 - 28
					SEND PACKET:C103(myDoc; "jit"+"\t")  //29_Clerk
					SEND PACKET:C103(myDoc; String:C10([Order:3]salesTax:28; "###,###,##0.00")+"\t")  //30_TaxAmt
					SEND PACKET:C103(myDoc; [Order:3]customerID:1+"\r")  //31_CustID
					[Payment:28]cardApproval:15:="sent"
					//   SAVE RECORD([Payment])
			End case 
			NEXT RECORD:C51([Payment:28])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 

//