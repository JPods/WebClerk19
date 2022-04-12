//%attributes = {"publishedWeb":true}
// Method J_FindZipSalesRepFields
// 02/13/02
// Peter Fleming
// Used in method DropShipFill

//$1 pointer to current file
//$2 pointer to Zip field pointer
//$2 pointer to salesNameID field pointer
//$3 pointer to RepID field pointer

$0:=True:C214
Case of 
		
	: ($1=(->[Order:3]))
		$2->:=->[Order:3]zip:20
		$3->:=->[Order:3]salesNameID:10
		$4->:=->[Order:3]repID:8
		
	: ($1=(->[Proposal:42]))
		$2->:=->[Proposal:42]zip:16
		$3->:=->[Proposal:42]salesNameID:9
		$4->:=->[Proposal:42]repID:7
		
	: ($1=(->[Invoice:26]))
		$2->:=->[Invoice:26]zip:12
		$3->:=->[Invoice:26]salesNameID:23
		$4->:=->[Invoice:26]repID:22
		
	Else 
		$0:=False:C215
End case 