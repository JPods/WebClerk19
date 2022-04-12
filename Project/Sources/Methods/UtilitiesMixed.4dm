//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/02/20, 23:28:54
// ----------------------------------------------------
// Method: UtilitiesMixed
// Description
// 
//
// Parameters
// ----------------------------------------------------





CONFIRM:C162("Run catalog comparison")
If (OK=1)
	ARRAY TEXT:C222(aText11; 0)
	ARRAY TEXT:C222(aText5; 0)
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1="@-CCS")
	SELECTION TO ARRAY:C260([Item:4]itemNum:1; aText11)
	C_TIME:C306(uTime1)
	vText4:=""
	vText11:=Select document:C905(""; ""; "Select catalog to compare"; 0; aText5)
	If ((OK=1) & (Size of array:C274(aText5)>0))
		vText1:=Document to text:C1236(aText5{1})
		TextToArray(vText1; ->aText1; "\r"; False:C215)
		vi2:=Size of array:C274(aText1)
		For (vi1; 1; vi2)
			TextToArray(aText1{vi1}; ->aText8; "\t"; True:C214)
			vi4:=Size of array:C274(aText8)
			If (vi4>0)
				
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aText8{1})
				Case of 
					: (Records in selection:C76([Item:4])>1)
						vText4:=vText4+"\r"+"MultipleRecs"+"\t"+"\t"+"\t"+aText1{vi1}
					: (Records in selection:C76([Item:4])=1)
						vText4:=vText4+"\r"+String:C10([Item:4]costLastInShip:47)+"\t"+[Item:4]description:7+"\t"+[Item:4]vendorID:45+"\t"+aText1{vi1}
					Else 
						vText4:=vText4+"\r"+"NoRecord"+"\t"+"\t"+"\t"+aText1{vi1}
				End case 
			End if 
		End for 
	End if 
	SET TEXT TO PASTEBOARD:C523(vText4)
	uTime1:=Create document:C266("")
	If (OK=1)
		CLOSE DOCUMENT:C267(uTime1)
		TEXT TO DOCUMENT:C1237(document; vText4)
	End if 
	vText4:=""
End if 


If (False:C215)  // import QA
	
	
	
	vText11:=Get text from pasteboard:C524
	vText12:=Request:C163("Enter Question Type to make from Pasteboard"; "Site Inspection")
	If ((OK=1) & (vText12#""))
		vText11:=Replace string:C233(vText11; "\n"; "\r")
		vText11:=Replace string:C233(vText11; "\r"+"\r"; "\r")
		
		ARRAY TEXT:C222(aText11; 0)
		TextToArray(vText11; ->aText11; "\r")
		vi2:=Size of array:C274(aText11)
		For (vi1; 1; vi2)
			ARRAY TEXT:C222(aText12; 0)
			TextToArray(aText11{vi1}; ->aText12; "\t")
			vi4:=Size of array:C274(aText12)
			If (vi4>0)
				If (Length:C16(aText12{1})>2)
					CREATE RECORD:C68([QAQuestion:71])
					[QAQuestion:71]questionType:2:=vText12
					[QAQuestion:71]question:3:=aText12{1}
					[QAQuestion:71]imageTag:12:=Substring:C12([QAQuestion:71]question:3; 1; 25)
					[QAQuestion:71]imageTag:12:=UtilClean2SafeChar([QAQuestion:71]imageTag:12)
					[QAQuestion:71]seq:4:=vi1
					SAVE RECORD:C53([QAQuestion:71])
					If (vi4>1)
						For (vi3; 2; vi4)
							CREATE RECORD:C68([QAAnswer:72])
							[QAAnswer:72]answer:3:=aText12{vi3}
							[QAAnswer:72]idNumQAQuestion:1:=[QAQuestion:71]idNum:1
							[QAAnswer:72]seq:7:=vi3
							SAVE RECORD:C53([QAQuestion:71])
						End for 
					End if 
				End if 
			End if 
		End for 
	End if 
	
End if 

If (False:C215)  // look for gaps in numbers to insert CloneAllowed
	// was not needed because numbers did not overlap with existing Proposals
	// keep as an example
	
	// ### bj ### 20200208_0030 find gaps in sequences
	ALL RECORDS:C47([Proposal:42])
	ARRAY LONGINT:C221(aLongInt11; 0)
	DISTINCT VALUES:C339([Proposal:42]proposalNum:5; aLongInt11)
	C_LONGINT:C283(uInteger1; uInteger2)
	uInteger2:=Size of array:C274(aLongInt11)-2
	SORT ARRAY:C229(aLongInt11; >)
	uInteger2:=Size of array:C274(aLongInt11)
	For (uInteger1; 1; uInteger2)
		If (uInteger1+1<uInteger2)
			If (aLongInt11{uInteger1}#(aLongInt11{uInteger1+1}-1))
				ConsoleMessage(String:C10(aLongInt11{uInteger1})+": "+String:C10(aLongInt11{uInteger1+1}))
			End if 
		End if 
	End for 
	
End if 