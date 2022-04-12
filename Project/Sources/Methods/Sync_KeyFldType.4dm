//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4)  //aSyncFilePt{aSyncCnt}; syncPtFld; syncType
C_BOOLEAN:C305($doAlpha)
$doAlpha:=False:C215
Case of   //search for absolute duplicate (ie unique field)
	: ($1=(->[Customer:2]))
		$2->:=Field:C253(->[Customer:2]customerID:1)
		$3->:=0
		$4->:=Field:C253(->[Customer:2]obSync:10)
	: ($1=(->[Service:6]))
		$2->:=Field:C253(->[Service:6]idNum:26)
		$3->:=9
		$4->:=Field:C253(->[Service:6]obSync:29)
	: ($1=(->[Proposal:42]))
		$2->:=Field:C253(->[Proposal:42]proposalNum:5)
		$3->:=9
		$4->:=Field:C253(->[Proposal:42]obSync:44)
	: ($1=(->[Order:3]))
		$2->:=Field:C253(->[Order:3]orderNum:2)
		$3->:=9
		$4->:=Field:C253(->[Order:3]lng:34)
	: ($1=(->[Invoice:26]))
		$2->:=Field:C253(->[Invoice:26]invoiceNum:2)
		$3->:=9
		$4->:=Field:C253(->[Invoice:26]obSync:47)
	: ($1=(->[Contact:13]))
		$2->:=-1
		$3->:=-1
		$4->:=Field:C253(->[Contact:13]obSync:17)
	: ($1=(->[Lead:48]))
		$2->:=-1
		$3->:=-1
		$4->:=Field:C253(->[Lead:48]obSync:25)
End case 