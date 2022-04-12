//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/13/07, 19:17:40
// ----------------------------------------------------
// Method: PKNo_ScanPack
// Description
// 
//
// Parameters
// ----------------------------------------------------
vResponse:=""
C_BOOLEAN:C305($vbAllowItem; $0)
$vbAllowItem:=False:C215
$doChange:=UserInPassWordGroup("PackingManual")
If (Not:C34($doChange))
	If (aOQtyOrder{aoLnSelect{1}}<0)
		vResponse:="Quantity Negative"
		$vbAllowItem:=True:C214
	Else 
		//remove search by subrecord
		//QUERY([Item];[Item]ItemNum=aOItemNum{aoLnSelect{1}};*)
		//QUERY([Item]; & [Item]KeySub'WordOnly="No_ScanPack")
		
		//alternate search Items record
		//QUERY([Item];[Item]ItemNum=aOItemNum{aoLnSelect{1}};*)
		//QUERY([Item]; & [Item]KeyText="@No_ScanPack@")
		
		// ### jwm ### 20150123_2319 New search by keyword *** Test This ***
		
		QUERY BY FORMULA:C48([Item:4]; (([Item:4]itemNum:1=[Word:99]relatedAlpha:8) & ([Item:4]itemNum:1=aOItemNum{aoLnSelect{1}}) & ([Word:99]wordOnly:3="No_ScanPack")))
		
		If (Records in selection:C76([Item:4])>0)
			$vbAllowItem:=True:C214
			vResponse:="No_ScanPack"
		End if 
	End if 
Else 
	$vbAllowItem:=True:C214
	vResponse:="Password Override"
End if 
$0:=$vbAllowItem
//