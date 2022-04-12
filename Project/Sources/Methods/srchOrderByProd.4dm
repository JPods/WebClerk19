//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 09:05:44
// ----------------------------------------------------
// Method: srchOrderByProd
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(vHere)
C_POINTER:C301(ptCurTable)

SET MENU BAR:C67(6; Current process:C322; *)  // ### jwm ### 20180710_1526

If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Order:3])
End if 
vPartNum:=Request:C163("Enter Item Number.")
If (OK=1)
	QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=vPartNum+"@")
	RELATE ONE SELECTION:C349([OrderLine:49]; [Order:3])
	ProcessTableOpen(->[Order:3])
End if 