//%attributes = {"publishedWeb":true}
C_LONGINT:C283($reports; $w)
C_POINTER:C301($1)
Case of 
	: ($1=(->[Customer:2]))
		$w:=Size of array:C274(aRptFiles)+1
		$reports:=2
		Ray_InsertElems($w; $reports; ->aRptCreator; ->aWhens; ->aWhys; ->aRptNames; ->aRptRecs; ->aRptFiles; ->aRptAuthLevel)
		//aWhens{$w}:="Internal"
		//aWhys{$w}:="Collect Receivables"
		//aRptNames{$w}:="Statement"
		//aRptRecs{$w}:=-141
		//aRptFiles{$w}:=File([Customer])
		//
		aWhens{$w}:="Internal"
		aWhys{$w}:="Sales Relationship"
		aRptNames{$w}:="Lead Sheet"
		aRptRecs{$w}:=-100
		aRptFiles{$w}:=Table:C252(->[Customer:2])
		//
		aWhens{$w+1}:="Internal"
		aWhys{$w+1}:="Sales Relationship"
		aRptNames{$w+1}:="Lead Sheet, Small"
		aRptRecs{$w+1}:=-101
		aRptFiles{$w+1}:=Table:C252(->[Customer:2])
		//   
		
	: ($1=(->[Invoice:26]))
		$w:=Size of array:C274(aRptFiles)+1
		$reports:=2
		Ray_InsertElems($w; $reports; ->aRptCreator; ->aWhens; ->aWhys; ->aRptNames; ->aRptRecs; ->aRptFiles; ->aRptAuthLevel)
		aWhens{$w}:="Internal"
		aWhys{$w}:="Current shipments"
		aRptNames{$w}:="Manifest"
		aRptRecs{$w}:=-102
		aRptFiles{$w}:=Table:C252(->[Invoice:26])
		//
		aWhens{$w+1}:="Internal"
		aWhys{$w+1}:="Current shipments"
		aRptNames{$w+1}:="COD labels"
		aRptRecs{$w+1}:=-105
		aRptFiles{$w+1}:=Table:C252(->[Customer:2])
		//
	: ($1=(->[Employee:19]))
		$w:=Size of array:C274(aRptFiles)+1
		$reports:=2
		Ray_InsertElems($w; $reports; ->aRptCreator; ->aWhens; ->aWhys; ->aRptNames; ->aRptRecs; ->aRptFiles; ->aRptAuthLevel)
		//
		aWhens{$w}:="Internal"
		aWhys{$w}:="Paid Invoice Commissions"
		aRptNames{$w}:="Commission Report"
		aRptRecs{$w}:=-200
		aRptFiles{$w}:=Table:C252(->[Employee:19])
		//
		aWhens{$w+1}:="Internal"
		aWhys{$w+1}:="Paid Invoice Commissions"
		aRptNames{$w+1}:="Commission Report, Bulk"
		aRptRecs{$w+1}:=-202
		aRptFiles{$w+1}:=Table:C252(->[Employee:19])
		
	: ($1=(->[Rep:8]))
		$w:=Size of array:C274(aRptFiles)+1
		$reports:=2
		Ray_InsertElems($w; $reports; ->aRptCreator; ->aWhens; ->aWhys; ->aRptNames; ->aRptRecs; ->aRptFiles; ->aRptAuthLevel)
		//
		aWhens{$w}:="Internal"
		aWhys{$w}:="Paid Invoice Commissions"
		aRptNames{$w}:="Commission Report"
		aRptRecs{$w}:=-201
		aRptFiles{$w}:=Table:C252(->[Rep:8])
		//
		aWhens{$w+1}:="Internal"
		aWhys{$w+1}:="Paid Invoice Commissions"
		aRptNames{$w+1}:="Commission Report, Bulk"
		aRptRecs{$w+1}:=-203
		aRptFiles{$w+1}:=Table:C252(->[Rep:8])
		
		//: ($1=([WorkOrder]))
		//$w:=Size of array(aFileNums)+1
		//$reports:=1
		//Ray_InsertElems ($w;$reports;aRptCreator;aWhens;aWhys;aRptNames;aRptRecs
		//;aFileNums;->aRptAuthLevel)
		//
		//aWhens{$w}:="Internal"
		//aWhys{$w}:="Current WOs"
		//aRptNames{$w}:="Worksheet"
		//aRptRecs{$w}:=-104
		//aFileNums{$w}:=File([WorkOrder])
		//  
End case 