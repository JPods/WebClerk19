//%attributes = {}
//http_OrderLineSalesByItem


variable1:=variable1+"@"
vDate1:=Date:C102(variable2)
vDate2:=Date:C102(variable3)
QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=variable1+"@"; *)
QUERY:C277([OrderLine:49];  & [OrderLine:49]dateOrdered:25>=vDate1; *)
QUERY:C277([OrderLine:49];  & [OrderLine:49]dateOrdered:25<=vDate2)
//

If (False:C215)
	//alert(string(records in selection([OrderLine]))+"; "
	//+variable1+"; "+variable2+"; "+variable3)
	CREATE EMPTY SET:C140([Order:3]; "Current")
	vi2:=Records in selection:C76([OrderLine:49])
	FIRST RECORD:C50([OrderLine:49])
	For (vi1; 1; vi2)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
		ADD TO SET:C119("Current")
		NEXT RECORD:C51([OrderLine:49])
	End for 
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	//
End if 





//WccOrderLinesList.html

If (False:C215)
	//OrderHistRepWcc_1
	//WccOrdersList.html
	
	vDate2:=Date:C102(variable3)
	vDate1:=Date:C102(variable2)
	QUERY:C277([Order:3]; [Order:3]repID:8=variable1; *)
	If (vDate1>!00-00-00!)
		QUERY:C277([Order:3]; [Order:3]dateOrdered:4>=vDate1; *)
	End if 
	If (vDate2>!00-00-00!)
		QUERY:C277([Order:3];  & [Order:3]dateOrdered:4<=vDate2; *)
	End if 
	If (variable4#"")
		QUERY:C277([Order:3];  & [Order:3]adSource:41=variable4+"@"; *)
	End if 
	If (variable5#"")
		QUERY:C277([Order:3];  & [Order:3]status:59=variable5+"@"; *)
	End if 
	
	If (variable6#"")
		QUERY:C277([Order:3];  & [Order:3]mfrid:52=variable6+"@"; *)
	End if 
	
	If (variable7#"")
		QUERY:C277([Order:3];  & [Order:3]city:18=variable7+"@"; *)
	End if 
	
	If (variable8#"")
		QUERY:C277([Order:3];  & [Order:3]city:18=variable8+"@"; *)
	End if 
	
	If (variable9#"")
		QUERY:C277([Order:3];  & [Order:3]zip:20=variable9+"@"; *)
	End if 
	QUERY:C277([Order:3])
End if 