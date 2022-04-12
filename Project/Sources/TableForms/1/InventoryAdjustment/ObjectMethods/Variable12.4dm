// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/01/15, 16:45:46
// ----------------------------------------------------
// Method: [Default].diaInvAdjusts.Variable12
// Description
// variable: srItem
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150601_1641 literal search

doSearch:=2
// ### jwm ### 20150601_1620
//strip leading Brace
If (Length:C16(srItem)>0)
	If (srItem[[1]]="{")
		srItem:=Substring:C12(srItem; 2)
		
		// ### jwm ### 20161021_1410 split qty and part number borrowed from packing window
		vsBarCdFld:=srItem
		C_TEXT:C284(<>vBarCodeQtyItemDelim)
		<>vBarCodeQtyItemDelim:=" "
		$qtyBarCode:=0
		pPartNum:=vsBarCdFld
		If (<>vBarCodeQtyItemDelim#"")
			C_LONGINT:C283($p)
			$p:=Position:C15(<>vBarCodeQtyItemDelim; vsBarCdFld)
			If ($p>0)
				pPartNum:=Substring:C12(vsBarCdFld; $p+1)
				$qtyBarCode:=Num:C11(Substring:C12(vsBarCdFld; 1; $p-1))
			End if 
		End if 
		srItem:=pPartNum
		
		doSearch:=14  // ### jwm ### 20150601_1641 literal search
	End if 
End if 
