//%attributes = {"publishedWeb":true}
C_LONGINT:C283(bBarCodeSt)
vsBarCdFld:=""
Open window:C153(19; 165; 19; 165; 1)  //(40;40;200;65;1)//
DIALOG:C40([DefaultQQQ:15]; "diaBarCode")
CLOSE WINDOW:C154
QUERY:C277([Item:4]; [Item:4]barCode:34=vsBarCdFld)
//TRACE
C_POINTER:C301($ptCurTable)
$ptCurTable:=ptCurTable
Case of 
	: (vsBarCdFld="")
		//
	: (Records in selection:C76([Item:4])=1)
		listItemsFill(ptCurTable; False:C215)
	: (False:C215)  ////(<>vlitemAutoManages=1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=vsBarCdFld)
		If (Records in selection:C76([Item:4])=1)
			listItemsFill($ptCurTable; False:C215)
		Else 
			vPartNum:=vsBarCdFld
			ADD RECORD:C56([Item:4])
			listItemsFill($ptCurTable; False:C215)
		End if 
	: (<>vlitemAutoManages=1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=vsBarCdFld)
		If (Records in selection:C76([Item:4])=1)
			listItemsFill($ptCurTable; False:C215)
		Else 
			CONFIRM:C162("Add new item")
			If (OK=1)
				vPartNum:=vsBarCdFld
				ADD RECORD:C56([Item:4])
				listItemsFill($ptCurTable; False:C215)
			End if 
		End if 
End case 