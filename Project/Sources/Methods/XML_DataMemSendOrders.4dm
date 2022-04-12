//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/01/12, 08:49:34
// ----------------------------------------------------
// Method: XML_DataMemSendOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(vRef; vtCode)
C_LONGINT:C283($myDays)
C_BOOLEAN:C305(vbDoName; vboolean1)
C_TEXT:C284(attribValue; Struct_Ref; vFound; vComment; v)
C_TEXT:C284(vRefInvoice; vRefCustomer; vRefOrder; vRefItems; vRefPayments; vRefPaymentMethod; vtDescription)
C_LONGINT:C283(vi1; vi2; vi9)

If (Count parameters:C259>0)
	vText7:=$1
End if 

If (vText7="Export")
	
	QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="SendOrders"; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="DataMemory")
	If (Records in selection:C76([TallyResult:73])=0)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]purpose:2:="DataMemory"
		[TallyResult:73]name:1:="SendOrders"
		[TallyResult:73]nameLong1:24:="NextOrderNum"
		[TallyResult:73]longint1:7:=0
		[TallyResult:73]nameProfile1:26:=""
		[TallyResult:73]profile1:17:=""
		ALERT:C41("Choose folder for passing records.")
		[TallyResult:73]textBlk1:5:=Select folder:C670("")
		If ([TallyResult:73]textBlk1:5="")
			ALERT:C41("Folder not selected.")
		End if 
		[TallyResult:73]textBlk2:6:=""
		SAVE RECORD:C53([TallyResult:73])
	End if 
	
	vi9:=Test path name:C476([TallyResult:73]textBlk1:5)
	If (vi9#0)
		ALERT:C41("Folder not selected.")
	Else 
		QUERY:C277([Order:3]; [Order:3]idNum:2>[TallyResult:73]longint1:7)
		ORDER BY:C49([Order:3]; [Order:3]idNum:2)
		vi2:=Records in selection:C76([Order:3])
		FIRST RECORD:C50([Order:3])
		vText9:=""
		For (vi1; 1; vi2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			//vText9:=[TallyResult]TextBlk1+"002"+"Recs_"+String(DateTime_Enter)+".out"
			Records_Out(->[Customer:2]; vText9; 0)  //File; name of file; keep selection//
			QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
			If (Records in selection:C76([Payment:28])>0)
				//vText9:=[TallyResult]TextBlk1+"028"+"Recs_"+String(DateTime_Enter)+".out"
				Records_Out(->[Payment:28]; vText9; 0)  //File; name of file; keep selection//
			End if 
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Order:3]contactBillTo:87)
			If (Records in selection:C76([Contact:13])>0)
				//vText9:=[TallyResult]TextBlk1+String(Table(->[Contact]))+"Recs_b"+String(DateTime_Enter)+".out"
				Records_Out(->[Contact:13]; vText9; 0)  //File; name of file; keep selection//
			End if 
			If ([Order:3]contactBillTo:87#0)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Order:3]contactBillTo:87)
				If (Records in selection:C76([Contact:13])>0)
					//vText9:=[TallyResult]TextBlk1+String(Table(->[Contact]))+"Recs_s"+String(DateTime_Enter)+".out"
					Records_Out(->[Contact:13]; vText9; 0)  //File; name of file; keep selection//
				End if 
			End if 
			//vText9:=[TallyResult]TextBlk1+"003"+"Recs_"+String(DateTime_Enter)+".out"
			Records_Out(->[Order:3]; vText9; 0)  //File; name of file; keep selection//
			NEXT RECORD:C51([Order:3])
		End for 
		[TallyResult:73]longint1:7:=[Order:3]idNum:2
		SAVE RECORD:C53([TallyResult:73])
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		REDUCE SELECTION:C351([Customer:2]; 0)
		REDUCE SELECTION:C351([Payment:28]; 0)
		REDUCE SELECTION:C351([Order:3]; 0)
	End if 
	
End if 

If (vText7="Import")
	
	QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="NewOrders"; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="DataMemory")
	If (Records in selection:C76([TallyResult:73])=0)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]purpose:2:="DataMemory"
		[TallyResult:73]name:1:="NewOrders"
		[TallyResult:73]nameLong1:24:="NextOrderNum"
		[TallyResult:73]longint1:7:=0
		[TallyResult:73]nameProfile1:26:=""
		[TallyResult:73]profile1:17:=""
		ALERT:C41("Choose folder for passing records.")
		[TallyResult:73]textBlk1:5:=Select folder:C670("")
		If ([TallyResult:73]textBlk1:5="")
			ALERT:C41("Folder not selected.")
		End if 
		[TallyResult:73]textBlk2:6:=""
		SAVE RECORD:C53([TallyResult:73])
	End if 
	
	vi9:=Test path name:C476([TallyResult:73]textBlk1:5)
	
	If (vi9#0)
		ALERT:C41("Folder not selected.")
	Else 
		
		vi9:=Test path name:C476([TallyResult:73]textBlk1:5+"completed")
		If (vi9#0)
			ALERT:C41("No destination folder")
		Else 
			
			ARRAY TEXT:C222(aText1; 0)
			DOCUMENT LIST:C474([TallyResult:73]textBlk1:5; aText1)
			vi2:=Size of array:C274(aText1)
			For (vi1; 1; vi2)
				vi9:=1
				Case of 
					: (aText1{vi1}="002@")
						vText9:=[TallyResult:73]textBlk1:5+aText1{vi1}
						Records_In(->[Customer:2]; ->vText9)
						
					: (aText1{vi1}="003@")
						vText9:=[TallyResult:73]textBlk1:5+aText1{vi1}
						Records_In(->[Order:3]; ->vText9)
						
					: (aText1{vi1}="028@")  //table number of payments
						vText9:=[TallyResult:73]textBlk1:5+aText1{vi1}
						Records_In(->[Payment:28]; ->vText9)
					Else 
						vi9:=0
				End case 
				If (vi9=1)
					vText10:=[TallyResult:73]textBlk1:5+"completed"+Folder separator:K24:12+aText1{vi1}
					MOVE DOCUMENT:C540(vText9; vText10)
				End if 
			End for 
		End if 
	End if 
	
End if 
