//%attributes = {"publishedWeb":true}
//Method: WccRptSaleByItem
//TRACE
$doSearch:=1
If (Count parameters:C259=1)
	$doSearch:=$1
End if 
Case of 
	: ($doSearch=1)
		vi9:=365*5
		vDate1:=Current date:C33
		vDate1:=vDate1-vi9
		Temp_RayInit
		QUERY:C277([OrderLine:49]; [OrderLine:49]altItem:31="wsj@"; *)
		QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Bar@"; *)
		QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Ews@"; *)
		QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="aws@")  //;*)
		//QUERY([OrderLine];&[OrderLine]DateOrdered>vDate1)
	: ($doSearch=2)
		vDate1:=Date:C102(variable1)
		vDate2:=Date:C102(variable2)
		vR1:=Num:C11(variable3)
		If (vR1=0)
			vR1:=10000
		End if 
		//vDate1:=Current date
		//vDate1:=vDate1-vi9
		Temp_RayInit
		QUERY:C277([OrderLine:49]; [OrderLine:49]altItem:31="wsj@"; *)
		QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Bar@"; *)
		QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Ews@"; *)
		QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="aws@"; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]extendedPrice:11>=vR1; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]dateOrdered:25>=vDate1; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]dateOrdered:25<=vDate2)
End case 
vText6:="start"
UtArrayConsolidate(->[OrderLine:49]altItem:31; 1; ->[OrderLine:49]description:5; 1; ->[OrderLine:49]qty:6; 2; ->[OrderLine:49]extendedPrice:11; 2)
vi8:=Size of array:C274(aTmpReal4)
If (vi8>0)
	MULTI SORT ARRAY:C718(aTmpReal4; <; aTmpText2; >; aTmpText4; aTmpReal2; aRptCount)
	vi2:=Size of array:C274(aTmpReal4)
	vi1:=0
	vi9:=0
	While (vi1<=vi2)
		vi1:=vi1+1
		aTmpReal4{vi1}:=Round:C94(aTmpReal4{vi1}; 0)
		aTmpReal2{vi1}:=Round:C94(aTmpReal2{vi1}; 0)
		If (aTmpReal4{vi1}<6000)
			vi9:=vi1
			vi1:=vi2+1
		End if 
	End while 
	If (vi9>0)
		ARRAY REAL:C219(aTmpReal4; vi9)
		ARRAY TEXT:C222(aTmpText2; vi9)
		ARRAY TEXT:C222(aTmpText4; vi9)
		ARRAY REAL:C219(aTmpReal2; vi9)
		ARRAY LONGINT:C221(aRptCount; vi9)
	End if 
	vi2:=Size of array:C274(aTmpReal4)
	ARRAY TEXT:C222(aTmpText1; vi2)
	For (vi1; 1; vi2)
		vText3:="/WCC_Execute?TableName=TallyMasters&RecordID=30&ReportName=ArticleOrders"+"&variable1="+aTmpText2{vi1}
		vText4:=" target="+Txt_Quoted("Main_Frame")
		aTmpText1{vi1}:="<a href="+Txt_Quoted(vText3)+vText4+">Link</a>"
	End for 
	INSERT IN ARRAY:C227(aRptAccumOut; 1; 1)
	aRptAccumOut{1}:=(->aTmpText1)
	vText6:=UtArray2Web("Link"; 1; "ItemNum"; 1; "Description"; 1; "$ Sales"; 2; "Unit Sales"; 2; "Count"; 2)
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
	QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="aws@")  //;*)
	//QUERY([OrderLine];&[OrderLine]DateOrdered>vDate1)
	SELECTION TO ARRAY:C260([OrderLine:49]altItem:31; aTmp35Str1; [OrderLine:49]description:5; aTmp80Str1; [OrderLine:49]qty:6; aTmpReal1; [OrderLine:49]extendedPrice:11; aTmpReal2; [OrderLine:49]customerID:2; aTmp10Str1; [OrderLine:49]orderNum:1; aTmpLong1; [OrderLine:49]dateOrdered:25; aTmpDate1)
	vi2:=Size of array:C274(aTmp35Str1)
	vText1:=""
	SORT ARRAY:C229(aTmp35Str1; aTmp80Str1; aTmpReal1; aTmpReal2; aTmp10Str1; aTmpLong1; aTmpDate1)
	For (vi1; 1; vi2)
		If (aTmp35Str1{vi1}#vText1)
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
			aTmp35Str2{vi4}:=aTmp35Str1{vi1}
			vText1:=aTmp35Str1{vi1}
			aTmp80Str2{vi4}:=aTmp80Str1{vi1}
		End if 
		aTmpReal3{vi4}:=aTmpReal3{vi4}+aTmpReal1{vi1}
		aTmpReal4{vi4}:=aTmpReal4{vi4}+aTmpReal2{vi1}
	End for 
	//SORT ARRAY(aTmpReal4;aTmp35Str2;aTmp80Str2;aTmpReal3;aTmp10Str2;aTmpLong2;aTmpDa
	MULTI SORT ARRAY:C718(aTmpReal4; <; aTmp35Str2; >; aTmp80Str2; aTmpReal3; aTmp10Str2; aTmpLong2; aTmpDate2)
	vi2:=Size of array:C274(aTmp35Str2)
	vText6:="<Table width="+Txt_Quoted("100%")+">"
	vText6:=vText6+"<TR><TD>"+"\r"
	vText6:=vText6+"ItemNum</TD><TD>"
	vText6:=vText6+"Description</TD><TD align=right>"
	vText6:=vText6+"Qty Sold</TD><TD align=right>"
	vText6:=vText6+"Sales $</TD></TR>"+"\r"
	For (vi4; 1; vi2)
		If (aTmpReal4{vi4}>6000)
			vR3:=Round:C94(aTmpReal3{vi4}; 0)
			vText2:=String:C10(vR3; "###,###,##0")
			vR4:=Round:C94(aTmpReal4{vi4}; 0)
			vText4:=String:C10(vR4; "###,###,##0")
			vText3:="/WCC_Execute?TableName=TallyMasters&RecordID=29&ReportName=ArticleCustomers"+"&variable1="+aTmp35Str2{vi4}
			
			vText6:=vText6+"<TR><TD>"
			vText6:=vText6+aTmp35Str2{vi4}+"</TD><TD>"
			vText6:=vText6+aTmp80Str2{vi4}+"</TD><TD align=right>"
			vText6:=vText6+vText2+"</TD><TD align=right>"
			vText6:=vText6+vText4+"</TD></TR>"+"\r"
		End if 
	End for 
	vText6:=vText6+"</TABLE>"+"\r"
	Temp_RayInit
	
End if 









