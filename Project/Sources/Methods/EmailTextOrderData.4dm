//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-24T00:00:00, 16:32:53
// ----------------------------------------------------
// Method: EmailTextOrderData
// Description
// Modified: 01/24/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $orderNum)
$orderNum:=$1
QUERY:C277([Order:3]; [Order:3]idNum:2=$orderNum)

///   Execute_TallyMaster ("emailOrdersLines";"WccOrder")

C_TEXT:C284(variable2; variable3)
If (False:C215)
	variable2:="01/24/11"
	
	variable3:="01/24/11"
	variable1:=""
	
	
	vDate2:=Date:C102(variable3)
	vDate1:=Date:C102(variable2)
	QUERY:C277([Order:3]; [Order:3]total:27#0; *)
	QUERY:C277([Order:3]; [Order:3]repID:8=variable1+"@"; *)
	If (vDate1>!00-00-00!)
		QUERY:C277([Order:3]; [Order:3]dateDocument:4>=vDate1; *)
	End if 
	If (vDate2>!00-00-00!)
		QUERY:C277([Order:3];  & [Order:3]dateDocument:4<=vDate2; *)
	End if 
	If (variable4#"")
		QUERY:C277([Order:3];  & [Order:3]adSource:41=variable4+"@"; *)
	End if 
	If (variable5#"")
		QUERY:C277([Order:3];  & [Order:3]profile3:63=variable5+"@"; *)
	End if 
	If (variable6#"")
		QUERY:C277([Order:3];  & [Order:3]mfrID:52=variable6+"@"; *)
	End if 
	If (variable7#"")
		QUERY:C277([Order:3];  & [Order:3]consignment:70=variable7+"@"; *)
	End if 
	If (variable8#"")
		QUERY:C277([Order:3];  & [Order:3]customerID:1=variable8+"@"; *)
	End if 
	If (variable12#"")
		QUERY:C277([Order:3];  & [Order:3]typeSale:22=variable12+"@"; *)
	End if 
	If (variable11#"")
		QUERY:C277([Order:3];  & [Order:3]complete:83=variable11+"@"; *)
	End if 
	If (variable10#"")
		QUERY:C277([Order:3];  & [Order:3]salesNameID:10=variable10+"@"; *)
	End if 
	QUERY:C277([Order:3])
	
	
	vText11:=Substring:C12(vText11; 6)
	
End if 
//Alert(vText11)
//Alert(string(viEndUserSecurityLevel))
//ALERT("variable12 = "+variable12)

//If (variable12="sendema@")

RELATE MANY SELECTION:C340([OrderLine:49]idNumOrder:1)
SMTP_EmailExport("emailOrderLines"; "emailExport")

If (False:C215)
	
	
	myDoc:=Open document:C264("")
	If (OK=1)
		Repeat 
			RECEIVE PACKET:C104(myDoc; vText1; "\r")
			If (OK=1)
				//Open window(500;300)
				
				TextToArray(vText1; ->aText8; "\t")
				If (Size of array:C274(aText8)>2)
					aText8{3}:=Replace string:C233(aText8{3}; "-"; "")
					QUERY:C277([Customer:2]; [Customer:2]phone:13=aText8{3})
					If (Records in selection:C76([Customer:2])>0)
						vi2:=Records in selection:C76([Customer:2])
						FIRST RECORD:C50([Customer:2])
						For (vi1; 1; vi2)
							[Customer:2]dateLastUpdated:107:=!2009-02-03!
							SAVE RECORD:C53([Customer:2])
							NEXT RECORD:C51([Customer:2])
						End for 
					Else 
						CREATE RECORD:C68([Customer:2])
						DB_InitCustomer
						[Customer:2]dateLastUpdated:107:=!2009-02-03!
						[Customer:2]city:6:=aText8{2}
						[Customer:2]phone:13:=aText8{3}
						[Customer:2]state:7:=aText8{4}
						[Customer:2]dateOpened:14:=Date:C102(aText8{5})
						[Customer:2]company:2:=aText8{6}
						[Customer:2]comment:15:=aText8{1}
						[Customer:2]profile5:30:="090202_new"
						SAVE RECORD:C53([Customer:2])
					End if 
				End if 
			End if 
		Until (OK=0)
	End if 
	
	
	If (False:C215)
		vText1:=Request:C163("Enter CallReports Action.")
		If ((OK=1) & (vText1#""))
			CREATE SET:C116([Customer:2]; "Current")
			USE SET:C118("UserSet")  //select the highlighted records
			FIRST RECORD:C50([Customer:2])
			vi2:=Records in selection:C76([Customer:2])
			ALERT:C41(String:C10(vi2))
			For (vi1; 1; vi2)
				CREATE RECORD:C68([Call:34])
				
				//ALERT(String([CallReport]UniqueID))
				[Call:34]customerID:1:=[Customer:2]customerID:1
				[Call:34]company:42:=[Customer:2]company:2
				[Call:34]tableNum:2:=2
				[Call:34]attention:18:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
				[Call:34]actionBy:3:=Current user:C182
				[Call:34]initiatedBy:23:=Current user:C182
				[Call:34]dtAction:4:=DateTime_DTTo
				[Call:34]dateDocument:17:=Current date:C33
				[Call:34]action:15:=vText1
				SAVE RECORD:C53([Call:34])
				NEXT RECORD:C51([Customer:2])
			End for 
			USE SET:C118("Current")
			CLEAR SET:C117("Current")  //don't let the set hang around unnecessarily        
		End if 
		
		
		REDRAW WINDOW:C456
		
		
		
		
		
		vText1:="ItemSalesByPrice"
		vText2:="Monthly"
		vDate1:=Date:C102(Request:C163("Report Date"; String:C10(Date_ThisMon(Current date:C33-10))))
		vi10:=DateTime_DTTo(vDate1)
		If (OK=1)
			ORDER BY:C49([InvoiceLine:54]; [InvoiceLine:54]itemNum:4; [InvoiceLine:54]typeSale:27)
			vi2:=Records in selection:C76([InvoiceLine:54])
			FIRST RECORD:C50([InvoiceLine:54])
			For (vi1; 1; vi2)
				If (Not:C34(([TallyResult:73]itemNum:34=[InvoiceLine:54]itemNum:4) & ([TallyResult:73]profile1:17=vText1) & ([TallyResult:73]profile2:18=vText2) & ([TallyResult:73]profile3:19=[InvoiceLine:54]typeSale:27) & ([TallyResult:73]dtReport:12=vi10)))
					QUERY:C277([TallyResult:73]; [TallyResult:73]itemNum:34=[InvoiceLine:54]itemNum:4; *)
					QUERY:C277([TallyResult:73];  & [TallyResult:73]profile1:17=vText1; *)
					QUERY:C277([TallyResult:73];  & [TallyResult:73]profile2:18=vText2; *)
					QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=vi10)
					If (Records in selection:C76([TallyResult:73])=0)
						CREATE RECORD:C68([TallyResult:73])
						
						[TallyResult:73]itemNum:34:=[InvoiceLine:54]itemNum:4
						[TallyResult:73]profile1:17:=vText1
						[TallyResult:73]nameProfile1:26:="TypeReport"
						[TallyResult:73]profile2:18:=vText2
						[TallyResult:73]nameProfile2:27:="Period"
						[TallyResult:73]dtReport:12:=vi10
						[TallyResult:73]nameReal1:20:="Quantity"
						[TallyResult:73]nameReal2:21:="Sales"
						[TallyResult:73]nameReal3:22:="Costs"
						[TallyResult:73]nameReal4:23:="Margin$"
						[TallyResult:73]nameReal5:33:="Margin%"
						[TallyResult:73]nameProfile3:28:="TypeSale"
						SAVE RECORD:C53([TallyResult:73])
					End if 
				End if 
				[TallyResult:73]real1:13:=[TallyResult:73]real1:13+[InvoiceLine:54]qty:7
				[TallyResult:73]real2:14:=[TallyResult:73]real2:14+[InvoiceLine:54]extendedPrice:11
				[TallyResult:73]real3:15:=[TallyResult:73]real3:15+[InvoiceLine:54]extendedCost:13
				[TallyResult:73]real4:16:=[TallyResult:73]real2:14-[TallyResult:73]real3:15
				If ([TallyResult:73]real2:14>0)
					[TallyResult:73]real5:32:=Round:C94([TallyResult:73]real4:16/[TallyResult:73]real2:14; 3)*100
				End if 
				SAVE RECORD:C53([TallyResult:73])
				NEXT RECORD:C51([InvoiceLine:54])
			End for 
			QUERY:C277([TallyResult:73]; [TallyResult:73]dtReport:12=vi10; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]profile1:17=vText1; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]profile2:18=vText2)
			ProcessTableOpen(-Table:C252(->[TallyResult:73]))
		End if 
		
		
		
		vDate1:=!2004-01-01!
		vDate2:=Current date:C33
		
		ALL RECORDS:C47([Customer:2])
		vi2:=Records in selection:C76([Customer:2])
		For (vi1; 1; vi2)
			MESSAGE:C88(String:C10(vi2))
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4>=vDate1)
			[Customer:2]salesYTD:47:=Sum:C1([Invoice:26]amount:14)
			SAVE RECORD:C53([Customer:2])
			NEXT RECORD:C51([Customer:2])
		End for 
		//
		ALL RECORDS:C47([Item:4])
		vi2:=Records in selection:C76([Item:4])
		For (vi1; 1; vi2)
			MESSAGE:C88(String:C10(vi2))
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]itemNum:4=[Item:4]itemNum:1; *)
			QUERY:C277([InvoiceLine:54];  & [Invoice:26]dateShipped:4>=vDate1)
			[Item:4]costofSales:50:=Sum:C1([InvoiceLine:54]extendedCost:13)
			[Item:4]sales:49:=Sum:C1([InvoiceLine:54]extendedPrice:11)
			[Item:4]qtySold:25:=Sum:C1([InvoiceLine:54]qty:7)
			SAVE RECORD:C53([Item:4])
			NEXT RECORD:C51([Item:4])
		End for 
		//
		//
		//
		
		[Order:3]shipFreightCost:38:=0
		[Order:3]shipMiscCosts:25:=0
		[Order:3]shipAdjustments:26:=0
		[Order:3]shipTotal:30:=0
		Case of 
			: ([Order:3]amount:24<=20)
				[Order:3]shipFreightCost:38:=7.5
			: ([Order:3]amount:24<=35)
				[Order:3]shipFreightCost:38:=8.5
			: ([Order:3]amount:24<=45)
				[Order:3]shipFreightCost:38:=9.5
			: ([Order:3]amount:24<=60)
				[Order:3]shipFreightCost:38:=10.5
			: ([Order:3]amount:24<=80)
				[Order:3]shipFreightCost:38:=11.5
			: ([Order:3]amount:24<=100)
				[Order:3]shipFreightCost:38:=12.5
			: ([Order:3]amount:24<=125)
				[Order:3]shipFreightCost:38:=14.5
			: ([Order:3]amount:24<=170)
				[Order:3]shipFreightCost:38:=17.5
			: ([Order:3]amount:24<=200)
				[Order:3]shipFreightCost:38:=19.5
			: ([Order:3]amount:24<=250)
				[Order:3]shipFreightCost:38:=21.5
			Else   //: ([Order]Amount<more than$250)
				[Order:3]shipFreightCost:38:=Round:C94(0.095*[Order:3]amount:24; 2)
		End case 
		Case of 
			: (([Order:3]country:21="CA") | ([Order:3]country:21="Canada"))
				viBoxCnt:=viBoxCnt-1
				[Order:3]shipAdjustments:26:=7.5+(viBoxCnt*3)
			: (([Order:3]state:19="AK") | ([Order:3]state:19="Alaska") | (([Order:3]zip:20>="99501@") & ([Order:3]zip:20<="99950@")))
				viBoxCnt:=viBoxCnt-1
				[Order:3]shipAdjustments:26:=7.5+(viBoxCnt*3)
			: (([Order:3]state:19="HI") | ([Order:3]state:19="Hawaii") | (([Order:3]zip:20>="99501@") & ([Order:3]zip:20<="99950@")))
				viBoxCnt:=viBoxCnt-1
				[Order:3]shipAdjustments:26:=7.5+(viBoxCnt*3)
			: (([Order:3]state:19="apo@") | ([Order:3]state:19="fpo@") | ([Order:3]address1:16="apo@") | ([Order:3]address1:16="fpo@") | ([Order:3]address2:17="apo@") | ([Order:3]address2:17="fpo@") | (([Order:3]zip:20>="34002@") & ([Order:3]zip:20<="34099@")))
				[Order:3]shipAdjustments:26:=2
			: (([Order:3]address1:16="@POBox@") | ([Order:3]address1:16="@PO Box@") | ([Order:3]address1:16="@P.O.@") | ([Order:3]address1:16="Box ") | ([Order:3]address1:16="Box#") | ([Order:3]address2:17="@POBox@") | ([Order:3]address2:17="@PO Box@") | ([Order:3]address2:17="@P.O.@") | ([Order:3]address2:17="Box ") | ([Order:3]address2:17="Box#"))
				[Order:3]shipAdjustments:26:=2
		End case 
		
		
		
		myDoc:=Open document:C264("")
		If (OK=1)
			Repeat 
				RECEIVE PACKET:C104(myDoc; vText1; "\r")
				If (OK=1)
					READ WRITE:C146([OrderLine:49])
					READ WRITE:C146([InvoiceLine:54])
					TextToArray(vText1; ->aText8; "\t")
					If (Size of array:C274(aText8)>2)
						vi9:=Num:C11(aText8{3})
						vi8:=Num:C11(aText8{2})
						vi7:=Num:C11(aText8{1})
						If (vi9>0)
							CONFIRM:C162("C_Ord: "+aText8{3}+", N_Ord: "+aText8{1}+", N_Inv: "+aText8{2})
							If (OK=1)
								myOK:=1
								QUERY:C277([Order:3]; [Order:3]idNum:2=vi7)
								If (Records in selection:C76([Order:3])=1)
									ALERT:C41("New Order "+aText8{1}+" already exists.")
									myOK:=2
								End if 
								QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=vi8)
								If (Records in selection:C76([Invoice:26])=1)
									ALERT:C41("New Invoices "+aText8{2}+" already exists.")
									myOK:=3
								End if 
								If (myOK=1)
									QUERY:C277([Order:3]; [Order:3]idNum:2=vi9)
									If (Records in selection:C76([Order:3])=1)
										QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=vi9)
										QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=vi9)
										QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
										//
										[Order:3]idNum:2:=vi7
										SAVE RECORD:C53([Order:3])
										If (Records in selection:C76([OrderLine:49])>0)
											FIRST RECORD:C50([OrderLine:49])
											vi2:=Records in selection:C76([OrderLine:49])
											For (vi1; 1; vi2)
												[OrderLine:49]idNumOrder:1:=vi7
												SAVE RECORD:C53([OrderLine:49])
												NEXT RECORD:C51([OrderLine:49])
											End for 
										End if 
										
										[Invoice:26]idNum:2:=vi8
										[Invoice:26]dateDocument:35:=[Order:3]dateDocument:4
										[Invoice:26]dateShipped:4:=[Order:3]dateDocument:4
										[Invoice:26]datePaid:26:=[Order:3]dateDocument:4
										SAVE RECORD:C53([Invoice:26])
										If (Records in selection:C76([InvoiceLine:54])>0)
											FIRST RECORD:C50([InvoiceLine:54])
											vi2:=Records in selection:C76([InvoiceLine:54])
											For (vi1; 1; vi2)
												[InvoiceLine:54]idNumInvoice:1:=vi8
												SAVE RECORD:C53([InvoiceLine:54])
												NEXT RECORD:C51([InvoiceLine:54])
											End for 
										End if 
									Else 
										ALERT:C41("No Order: "+aText8{3})
									End if 
									FLUSH CACHE:C297
								End if 
							End if 
						Else 
							ALERT:C41("Order=0")
						End if 
					Else 
						ALERT:C41("Less than 3 inputs")
					End if 
				End if 
			Until (OK=0)
		End if 
		
		
		
		vDate1:=Date:C102(variable1)
		vDate1:=Date_ThisQtr(vDate1; 0)
		vDate2:=Date_ThisQtr(vDate1; 1)
		vR1:=Num:C11(variable2)
		Temp_RayInit
		//QUERY([OrderLine];[OrderLine]AltItem="wsj@";*)
		//QUERY([OrderLine];|[OrderLine]AltItem="Bar@";*)
		//QUERY([OrderLine];|[OrderLine]AltItem="Ews@";*)
		//QUERY([OrderLine];|[OrderLine]AltItem="aws@")//;*)
		QUERY:C277([OrderLine:49]; [OrderLine:49]extendedPrice:11>=vR1; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]dateDocument:25>=vDate1; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]dateDocument:25<=vDate2)
		ALERT:C41(String:C10(vDate1)+": "+String:C10(vDate2)+": "+String:C10(vR1)+": "+String:C10(Records in selection:C76([OrderLine:49])))
		SELECTION TO ARRAY:C260([OrderLine:49]itemNumAlt:31; aTmp35Str1; [OrderLine:49]description:5; aTmp80Str1; [OrderLine:49]qty:6; aTmpReal1; [OrderLine:49]extendedPrice:11; aTmpReal2; [OrderLine:49]customerID:2; aTmp10Str1; [OrderLine:49]idNumOrder:1; aTmpLong1; [OrderLine:49]dateDocument:25; aTmpDate1)
		iLoText8:=">"
		iLoText9:="<"
		iLoText10:="="
		MULTI SORT ARRAY:C718(aTmp10Str1; >; aTmp35Str1; >; aTmp80Str1; >; aTmpReal1; >; aTmpReal2; >; aTmpLong1; >; aTmpDate1; >)
		//
		vText1:="3 523452 345 gsfg"
		vi2:=Size of array:C274(aTmp35Str1)
		For (vi1; 1; vi2)
			If (aTmp10Str1{vi1}#Text1)
				vi4:=Size of array:C274(aTmp35Str2)
				vi4:=vi4+1
				INSERT IN ARRAY:C227(aTmp35Str2; vi4; 1)
				INSERT IN ARRAY:C227(aTmp80Str2; vi4; 1)
				INSERT IN ARRAY:C227(aTmpReal3; vi4; 1)
				INSERT IN ARRAY:C227(aTmpReal4; vi4; 1)
				INSERT IN ARRAY:C227(aTmp10Str2; vi4; 1)
				INSERT IN ARRAY:C227(aTmpLong2; vi4; 1)
				INSERT IN ARRAY:C227(aTmpDate2; vi4; 1)
				// Else 
				//vi4:=Size of array(aTmp35Str2)
				aTmp10Str2{vi4}:=aTmp10Str1{vi1}
				vText1:=aTmp10Str1{vi1}
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=aTmp10Str1{vi1})
				aTmp80Str2{vi4}:=[Customer:2]company:2
				aTmp35Str2{vi4}:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
			End if 
			aTmpReal3{vi4}:=aTmpReal3{vi4}+aTmpReal1{vi1}
			aTmpReal4{vi4}:=aTmpReal4{vi4}+aTmpReal2{vi1}
		End for 
		MULTI SORT ARRAY:C718(aTmpReal4; <; aTmp35Str2; >; aTmp80Str2; aTmpReal3; aTmp10Str2; aTmpDate2)
		vi2:=Size of array:C274(aTmp35Str2)
		If (vi2>30)
			vi2:=30
		End if 
		vText6:="<Table width=100%>"
		vText6:=vText6+"<TR><TD>"+"\r"
		vText6:=vText6+"Details</TD><TD>"
		vText6:=vText6+"Name</TD><TD>"
		vText6:=vText6+"Company</TD><TD align=right>"
		vText6:=vText6+"Qty Sold</TD><TD align=right>"
		vText6:=vText6+"Sales $</TD></TR>"+"\r"
		For (vi4; 1; vi2)
			If (aTmpReal4{vi4}>6000)
				vR3:=Round:C94(aTmpReal3{vi4}; 0)
				vText2:=String:C10(vR3; "###,###,##0")
				vR4:=Round:C94(aTmpReal4{vi4}; 0)
				vText4:=String:C10(vR4; "###,###,##0")
				vText3:="/WCC_Execute?TableName=TallyMasters&RecordID=28&ReportName=ArticleByCustomer"+"&vVariable1="+aTmp10Str2{vi4}
				vText6:=vText6+"<TR><TD>"
				vText6:=vText6+"<a HREF="+Txt_Quoted(vText3)+"target="+Txt_Quoted("Main_Frame")+">"+aTmp10Str2{vi4}+"</TD><TD>"
				vText6:=vText6+aTmp35Str2{vi4}+"</TD><TD>"
				vText6:=vText6+aTmp80Str2{vi4}+"</TD><TD align=right>"
				vText6:=vText6+vText2+"</TD><TD align=right>"
				vText6:=vText6+vText4+"</TD></TR>"+"\r"
			End if 
		End for 
		vText6:=vText6+"</TABLE>"+"\r"
		Temp_RayInit
		
		
	End if 
	
	
	
	vDate2:=Date:C102(variable3)
	vDate1:=Date:C102(variable2)
	QUERY:C277([Invoice:26]; [Invoice:26]repID:22=variable1+"@"; *)
	If (vDate1>!00-00-00!)
		QUERY:C277([Invoice:26]; [Invoice:26]dateShipped:4>=vDate1; *)
	End if 
	If (vDate2>!00-00-00!)
		QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4<=vDate2; *)
	End if 
	If (variable4#"")
		QUERY:C277([Invoice:26];  & [Invoice:26]adSource:52=variable4+"@"; *)
	End if 
	If (variable5#"")
		QUERY:C277([Invoice:26];  & [Invoice:26]profile3:70=variable5+"@"; *)
	End if 
	If (variable7#"")
		QUERY:C277([Invoice:26];  & [Invoice:26]consignment:63=variable7+"@"; *)
	End if 
	
	QUERY:C277([Invoice:26])
	
	
End if 
