//%attributes = {"publishedWeb":true}
//Method: WccRptSaleByCustomer
vi9:=365*5
vDate1:=Current date:C33
vDate1:=vDate1-vi9
Temp_RayInit
QUERY:C277([OrderLine:49]; [OrderLine:49]altItem:31="wsj@"; *)
QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Bar@"; *)
QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="Ews@"; *)
QUERY:C277([OrderLine:49];  | [OrderLine:49]altItem:31="aws@")  //;*)
//QUERY([OrdLine];&[OrdLine]DateOrdered>vDate1)
SELECTION TO ARRAY:C260([OrderLine:49]altItem:31; aTmp35Str1; [OrderLine:49]description:5; aTmp80Str1; [OrderLine:49]qty:6; aTmpReal1; [OrderLine:49]extendedPrice:11; aTmpReal2; [OrderLine:49]customerID:2; aTmp10Str1; [OrderLine:49]orderNum:1; aTmpLong1; [OrderLine:49]dateOrdered:25; aTmpDate1)
vi2:=Size of array:C274(aTmp35Str1)
vText1:=""
SORT ARRAY:C229(aTmp10Str1; aTmp35Str1; aTmp80Str1; aTmpReal1; aTmpReal2; aTmpLong1; aTmpDate1)
For (vi1; 1; vi2)
	If (aTmp10Str1{vi1}#vText1)
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
vText6:="<Table width="+Txt_Quoted("100%")+">"
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
		vText3:="/WCC_Execute?TableName=TallyMasters&RecordID=28&ReportName=ArticleByCustomer"+"&variable1="+aTmp10Str2{vi4}
		vText6:=vText6+"<TR><TD>"
		vText6:=vText6+"<a HREF="+Txt_Quoted(vText3)+" target="+Txt_Quoted("Main_Frame")+">"+aTmp10Str2{vi4}+"</TD><TD>"
		vText6:=vText6+aTmp35Str2{vi4}+"</TD><TD>"
		vText6:=vText6+aTmp80Str2{vi4}+"</TD><TD align=right>"
		vText6:=vText6+vText2+"</TD><TD align=right>"
		vText6:=vText6+vText4+"</TD></TR>"+"\r"
	End if 
End for 
vText6:=vText6+"</TABLE>"+"\r"
Temp_RayInit
