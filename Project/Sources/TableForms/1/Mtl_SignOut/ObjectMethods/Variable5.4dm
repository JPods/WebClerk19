// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 13:58:19
// ----------------------------------------------------
// Method: Object Method: b1
// Description
// File: Object Method: [Control]MTl_SignOut.b1.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130319_1352

$k:=Size of array:C274(aWDItemLine)
If ($k>0)
	C_LONGINT:C283($i; $k; $rayElem)
	C_BOOLEAN:C305($endTest)
	$endTest:=False:C215
	TRACE:C157
	Repeat 
		$i:=$i+1
		If (aWdSo{aWDItemLine{$i}}=0)
			$endTest:=True:C214
		End if 
	Until (($i=$k) | ($endTest))
	If ($endTest)
		ALERT:C41("Material cannot be assigned Order '0'.")
	Else 
		IVNT_dRayInit
		$k:=Size of array:C274(aWDItemLine)
		For ($i; 1; $k)
			$rayElem:=aWDItemLine{$i}
			CREATE RECORD:C68([WOdraw:68])
			
			//GOTO RECORD([Item];aWdItemRec{$rayElem})
			[WOdraw:68]orderNum:1:=aWdSo{$rayElem}
			[WOdraw:68]itemNum:2:=aWdItem{$rayElem}
			[WOdraw:68]note:8:=aWdComment{$rayElem}
			[WOdraw:68]dateTaken:3:=aWdDate{$rayElem}
			[WOdraw:68]timeTaken:4:=Current time:C178
			[WOdraw:68]qtyTaken:5:=aWdQty{$rayElem}
			[WOdraw:68]nameID:6:=aWdNameID{$rayElem}
			[WOdraw:68]cost:7:=aWdCost{$rayElem}
			[WOdraw:68]status:9:=vtWdStatus
			[WOdraw:68]description:13:=aWdDscrp{$rayElem}
			[WOdraw:68]cause:12:=aWdReason{$rayElem}
			SAVE RECORD:C53([WOdraw:68])
			
			Invt_dRecCreate("MD"; [WOdraw:68]orderNum:1; [WOdraw:68]salesOrdLine:11; [Customer:2]customerID:1; [WOdraw:68]projectNum:10; "Material draw"; 1; 0; [WOdraw:68]itemNum:2; -[WOdraw:68]qtyTaken:5; 0; [WOdraw:68]cost:7; ""; vsiteID; 0)  //### jwm ### 20130319_1352
			
		End for 
		
		INVT_dInvtApply
		
		IVNT_dRayInit
		UNLOAD RECORD:C212([Item:4])
		viWdSalesOr:=0
		vtWdStatus:=""
		ALERT:C41("Posting complete.")
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 