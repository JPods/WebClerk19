If ((viWdSalesOr>0) & (vNameID#"") & (vrWdQty#0) & (Size of array:C274(aWDItemLine)>0))
	C_LONGINT:C283($i; $k)
	IVNT_dRayInit
	$k:=Size of array:C274(aWDItemLine)
	For ($i; 1; $k)
		CREATE RECORD:C68([WOdraw:68])
		
		GOTO RECORD:C242([Item:4]; aWdItemRec{aWDItemLine{$i}})
		[WOdraw:68]orderNum:1:=viWdSalesOr
		[WOdraw:68]itemNum:2:=[Item:4]itemNum:1
		[WOdraw:68]dateTaken:3:=Current date:C33
		[WOdraw:68]timeTaken:4:=Current time:C178
		[WOdraw:68]qtyTaken:5:=vrWdQty
		[WOdraw:68]nameID:6:=vNameID
		[WOdraw:68]cost:7:=[Item:4]costAverage:13
		[WOdraw:68]status:9:=vtWdStatus
		[WOdraw:68]cause:12:=<>aCostCause{<>aCostCause}
		SAVE RECORD:C53([WOdraw:68])
		
		Invt_dRecCreate("WO"; viWdSalesOr; viWdSalesOr; [Customer:2]customerID:1; [Order:3]projectNum:50; "+WO draw"; 1; 0; [Item:4]itemNum:1; -vrWdQty; 0; [Item:4]costAverage:13; ""; vsiteID; 0)
		
	End for 
	
	INVT_dInvtApply
	
	IVNT_dRayInit
	CANCEL:C270
	UNLOAD RECORD:C212([Item:4])
	viWdSalesOr:=0
	vtWdStatus:=""
	ARRAY TEXT:C222(aWdItem; 0)
	ARRAY TEXT:C222(aWdDscrp; 0)
	ARRAY LONGINT:C221(aWdItemRec; 0)
Else 
	BEEP:C151
	BEEP:C151
End if 