//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-08T00:00:00, 13:34:53
// ----------------------------------------------------
// Method: Item_SrRetire
// Description
// Modified: 12/08/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1)
Case of 
	: (<>tcSrItemSeq=1)
		QUERY:C277([Item:4];  & [Item:4]itemNum:1=$1+"@")
	: (<>tcSrItemSeq=2)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
		End if 
	: (<>tcSrItemSeq=3)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
		End if 
	: (<>tcSrItemSeq=4)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
			End if 
		End if 
	: (<>tcSrItemSeq=5)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1)
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]barCode:34=$1+"@")
			End if 
		End if 
		//
	: (<>tcSrItemSeq=6)
		QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
	: (<>tcSrItemSeq=7)
		QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		End if 
	: (<>tcSrItemSeq=8)
		QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
		End if 
	: (<>tcSrItemSeq=9)
		QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
			End if 
		End if 
	: (<>tcSrItemSeq=10)
		QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
			End if 
		End if 
		//
	: (<>tcSrItemSeq=11)
		QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
	: (<>tcSrItemSeq=12)
		QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		End if 
	: (<>tcSrItemSeq=13)
		QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
		End if 
	: (<>tcSrItemSeq=14)
		QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
			End if 
		End if 
	: (<>tcSrItemSeq=15)
		QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
			End if 
		End if 
	: (<>tcSrItemSeq=16)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=$1+"@")
		End if 
	: (<>tcSrItemSeq=17)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=$1+"@")
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
			End if 
		End if 
	: (<>tcSrItemSeq=18)
		QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
		End if 
	: (<>tcSrItemSeq=19)
		QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=$1+"@")
		If (Records in selection:C76([Item:4])=0)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$1+"@")
			If (Records in selection:C76([Item:4])=0)
				QUERY:C277([Item:4]; [Item:4]barCode:34=$1)
			End if 
		End if 
End case 
