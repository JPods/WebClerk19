//%attributes = {"publishedWeb":true}
//Method: WccRptItemsByCustomer
//TRACE


Temp_RayInit

QUERY:C277([OrderLine:49]; [OrderLine:49]altItem:31="wsj@"; *)
QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Bar@"; *)
QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Ews@"; *)
QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="aws@"; *)  //;*)
QUERY:C277([OrderLine:49];  & [OrderLine:49]customerID:2=variable1)
QUERY:C277([Customer:2]; [Customer:2]customerID:1=variable1)
//TRACE



UtArrayConsolidate(->[OrderLine:49]altItem:31; 1; ->[OrderLine:49]description:5; 1; ->[OrderLine:49]qty:6; 2; ->[OrderLine:49]extendedPrice:11; 2; ->[OrderLine:49]customerID:2; 1)
vi8:=Size of array:C274(aTmpReal4)


If (vi8>0)
	MULTI SORT ARRAY:C718(aTmpReal4; <; aTmpText2; >; aTmpText4; aTmpText6; aTmpReal2; aRptCount)
	vi2:=Size of array:C274(aTmpReal4)
	vi1:=0
	vi9:=0
	
	While (vi1<vi2)
		vi1:=vi1+1
		aTmpReal4{vi1}:=Round:C94(aTmpReal4{vi1}; 0)
		aTmpReal2{vi1}:=Round:C94(aTmpReal2{vi1}; 0)
	End while 
	ARRAY TEXT:C222(aTmpText1; vi2)
	For (vi1; 1; vi2)
		vText3:="/WCC_Execute?TableName=TallyMasters&RecordID=31&ReportName=ItemByCustomer"+"&variable1="+aTmpText2{vi1}+"&variable2="+aTmpText6{vi1}
		vText4:=" target="+Txt_Quoted("Main_Frame")
		aTmpText1{vi1}:="<a href="+Txt_Quoted(vText3)+vText4+">Link</a>"
	End for 
	INSERT IN ARRAY:C227(aRptAccumOut; 1; 1)
	aRptAccumOut{1}:=(->aTmpText1)
	vText6:=UtArray2Web("Link"; 1; "ItemNum"; 1; "Description"; 1; "Unit Sales"; 2; "$ Sales"; 2; "customerID"; 1; "Count"; 2)
Else 
	vText6:="No Records in Report"
End if 
Temp_RayInit





If (False:C215)
	vi9:=365*5
	vDate1:=Current date:C33
	vDate1:=vDate1-vi9
	Temp_RayInit
	QUERY:C277([OrderLine:49]; [OrderLine:49]altItem:31="wsj@"; *)
	QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Bar@"; *)
	QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Ews@"; *)
	QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="aws@"; *)  //;*)
	QUERY:C277([OrderLine:49];  & [OrderLine:49]customerID:2=variable1)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=variable1)
	//
	TRACE:C157
	SELECTION TO ARRAY:C260([OrderLine:49]altItem:31; aTmp35Str1; [OrderLine:49]description:5; aTmp80Str1; [OrderLine:49]qty:6; aTmpReal1; [OrderLine:49]extendedPrice:11; aTmpReal2; [OrderLine:49]orderNum:1; aTmpLong1; [OrderLine:49]dateOrdered:25; aTmpDate1)
	
	
	
	
	vi2:=Size of array:C274(aTmp35Str1)
	iLoText1:=""
	SORT ARRAY:C229(aTmp35Str1; aTmp80Str1; aTmpReal1; aTmpReal2; aTmpLong1; aTmpDate1)
	For (vi1; 1; vi2)
		If (aTmp35Str1{vi1}#iLoText1)
			vi4:=Size of array:C274(aTmp35Str2)
			vi4:=vi4+1
			INSERT IN ARRAY:C227(aTmp35Str2; vi4; 1)
			INSERT IN ARRAY:C227(aTmp80Str2; vi4; 1)
			INSERT IN ARRAY:C227(aTmpReal3; vi4; 1)
			INSERT IN ARRAY:C227(aTmpReal4; vi4; 1)
			INSERT IN ARRAY:C227(aTmpLong2; vi4; 1)
			INSERT IN ARRAY:C227(aTmpLong3; vi4; 1)
			INSERT IN ARRAY:C227(aTmpDate2; vi4; 1)
			// Else 
			//vi4:=Size of array(aTmp35Str2)
			aTmp35Str2{vi4}:=aTmp35Str1{vi1}
			iLoText1:=aTmp35Str1{vi1}
			aTmp80Str2{vi4}:=aTmp80Str1{vi1}
			aTmpLong2{vi4}:=aTmpLong1{vi1}
			aTmpDate2{vi4}:=aTmpDate1{vi1}
		End if 
		aTmpReal3{vi4}:=aTmpReal3{vi4}+aTmpReal1{vi1}
		aTmpReal4{vi4}:=aTmpReal4{vi4}+aTmpReal2{vi1}
		aTmpLong3{vi4}:=aTmpLong3{vi4}+1
	End for 
	MULTI SORT ARRAY:C718(aTmpReal4; <; aTmp35Str2; >; aTmp80Str2; aTmpReal3; aTmpLong2; aTmpLong3; aTmpDate2)
	vi2:=Size of array:C274(aTmp35Str2)
	If (vi2>30)
		vi2:=30
	End if 
	
	
	
	vText6:="<Table width="+Txt_Quoted("100%")+">"
	vText6:=vText6+"<TR><TD>"+"\r"
	vText6:=vText6+"ItemNum</TD><TD>"
	vText6:=vText6+"Description</TD><TD align=right>"
	vText6:=vText6+"Sales $</TD><TD align=right>"
	vText6:=vText6+"Qty Sold</TD><TD align=right>"
	vText6:=vText6+"Count</TD></TR>"+"\r"
	//vText6:=vText6+"An Order</TD><TD>"
	//vText6:=vText6+"Date</TD></TR>"
	For (vi4; 1; vi2)
		vR3:=Round:C94(aTmpReal3{vi4}; 0)
		iLoText2:=String:C10(vR3; "###,###,##0")
		vR4:=Round:C94(aTmpReal4{vi4}; 0)
		iLoText4:=String:C10(vR4; "###,###,##0")
		iLoText5:=String:C10(aTmpLong3{vi4}; "###,###,##0")
		
		vText6:=vText6+"<TR><TD>"
		vText6:=vText6+aTmp35Str2{vi4}+"</TD><TD>"  //ItemNum
		vText6:=vText6+aTmp80Str2{vi4}+"</TD><TD align=right>"  //Description
		vText6:=vText6+iLoText4+"</TD><TD align=right>"  //Sales
		vText6:=vText6+iLoText2+"</TD><TD align=right>"  //Qty
		vText6:=vText6+iLoText5+"</TD></TR>"+"\r"  //Count
		//If (aTmpLong3{vi4}>1)
		//iLoText3:="/WCC_Execute?TableName=TallyMasters&RecordID=29&ReportName
		//=OrdersByArtCust"+"&vVariable1="+[Customer]customerID+"&variable2="
		//+aTmp35Str2{vi4}
		//iLoText6:="<a HREF="+Txt_Quoted (iLoText3)+" target="+Txt_Quoted (
		//"Main_Frame")+">Orders"//Order or OrderList
		//Else 
		//iLoText6:=String(aTmpLong2{vi4})
		//iLoText3:="/WCC_Search?TableName=Orders&RecordID="+iLoText6
		//iLoText6:="<a HREF="+Txt_Quoted (iLoText3)+" target="+Txt_Quoted (
		//"Main_Frame")+">"+iLoText6//Order or OrderList
		//End if   
		//vText6:=vText6+iLoText6+"</TD><TD>"//Order or OrderList
		//vText6:=vText6+String(aTmpDate2{vi4})+"</TD></TR>"+"\r"//date
		
	End for 
	vText6:=vText6+"</TABLE>"+"\r"
	Temp_RayInit
	
End if 