//%attributes = {"publishedWeb":true}
//Exe_Cmdr_InvcLine
P_InvcLines
QUERY:C277([Item:4]; [Item:4]itemNum:1=pvItemNum)
QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=pvItemNum)
//[Item]Profile2  //vintage
//[Item]Profile1 //appellation
//[ItemSpec]Profile1  //chateau
If ([Item:4]typeid:26#"Administrative")
	vText1:=[ItemSpec:31]profile9:13  //classification
	vText2:=[ItemSpec:31]profile14:18  //packaging
	vText3:=String:C10([ItemSpec:31]profile20:24)*Num:C11([ItemSpec:31]profile20:24#0)  //bottle size
	vText4:=String:C10([ItemSpec:31]profile21:25)*Num:C11([ItemSpec:31]profile21:25#0)  //bottles/case
	vR4:=vR4+Num:C11(pvQtyShip)
	vR2:=vR2+Round:C94((0.001*(Num:C11(pvQtyShip)*[ItemSpec:31]profile20:24*[ItemSpec:31]profile18:22*[ItemSpec:31]profile21:25)); 2)
	vR3:=vR3+(Num:C11(pvQtyShip)*[ItemSpec:31]profile21:25)
Else 
	vText1:=""  //classification
	vText2:=""  //packaging
	vText3:=""  //bottle size
	vText4:=""  //bottles/case
End if 