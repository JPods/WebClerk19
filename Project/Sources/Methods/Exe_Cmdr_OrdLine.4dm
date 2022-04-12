//%attributes = {"publishedWeb":true}
//(M) Exe_Cmdr_OrdLine
P_OrdLines
QUERY:C277([Item:4]; [Item:4]itemNum:1=pvItemNum)
QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=pvItemNum)
vText1:=""  //classification
vText2:=""  //packaging
vText3:=""  //bottle size
vText4:=""  //bottles/case
If ([Item:4]typeid:26#"Admin@")
	vText1:=[ItemSpec:31]profile9:13  //classification
	vText2:=[ItemSpec:31]profile14:18  //packaging
	vText3:=String:C10([ItemSpec:31]profile20:24)*(Num:C11([ItemSpec:31]profile20:24#0))
	vText4:=String:C10([ItemSpec:31]profile21:25)*(Num:C11([ItemSpec:31]profile21:25#0))
	vR4:=vR4+(Num:C11(pvQtyOrd))
End if 