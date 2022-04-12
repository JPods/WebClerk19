//%attributes = {"publishedWeb":true}
If (vHere>1)
	If (Modified record:C314(ptCurTable->))  //NO CANCEL
		myCycle:=6
		jAcceptButton
	End if 
	$recNum:=Record number:C243(ptCurTable->)
End if 

//srItem:=Request("Search Items")

vDiaCom:="Search Items"
jCenterWindow(330; 70; 1)
DIALOG:C40([Control:1]; "RequestDialog")
CLOSE WINDOW:C154
vDiaCom:=""

If ((OK=1) & (srItem#""))
	srItem:=srItem+"@"
	QUERY:C277([Item:4]; [Item:4]itemNum:1=srItem)
	If (Records in selection:C76([Item:4])=0)
		QUERY:C277([Item:4]; [Item:4]barCode:34=srItem)
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]ean:82=srItem)
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=srItem)
				If (Records in selection:C76([Item:4])=0)
					QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=srItem)
					If (Records in selection:C76([Item:4])=0)
					Else 
						iLoText1:="ItemNum, Barcode, MfgItemNum not found"
					End if 
				End if 
			End if 
		End if 
	End if 
	$recDo:=1
	
	If ((vHere<2) & (ptCurTable#(->[Item:4])))
		//Assure that the menus and screens are set w/o (P) jSetDefaultFile     
		iLoPagePopUpMenuBar(->[Item:4])  // This should be reviewed for removal
	End if 
	MESSAGES ON:C181
	JSrchEnd($recDo; $recNum)  //assumes you know the file you want
End if 
