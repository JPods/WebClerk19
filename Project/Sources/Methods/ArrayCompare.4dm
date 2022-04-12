//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($i; syncDtFld)
C_BOOLEAN:C305($doThis)
$doThis:=False:C215
For ($i; 1; Size of array:C274($1->))
	Case of 
		: ($i=syncDtFld)
			aText3{$i}:=String:C10(dtSession)
		: ($1->{$i}#$2->{$i})
			$3->{$i}:=$2->{$i}
			$doThis:=True:C214
		Else 
			$3->{$i}:=""
	End case 
End for 
Case of 
	: (Not:C34($doThis))
		//display on the screen
	: (b5=1)
		C_POINTER:C301($ptFile)
		$ptFile:=aSyncFilePt{aSyncCnt}
		Case of   //should always result in no question, if new is entered
			: ($ptFile=(->[Customer:2]))
				aText3{Field:C253(->[Customer:2]customerID:1)}:=aText1{Field:C253(->[Customer:2]customerID:1)}
			: ($ptFile=(->[Order:3]))
				aText3{Field:C253(->[Order:3]orderNum:2)}:=aText1{Field:C253(->[Order:3]orderNum:2)}
			: ($ptFile=(->[Service:6]))
				aText3{Field:C253(->[Service:6]idNum:26)}:=aText1{Field:C253(->[Service:6]idNum:26)}
			: ($ptFile=(->[Invoice:26]))
				aText3{Field:C253(->[Invoice:26]invoiceNum:2)}:=aText1{Field:C253(->[Invoice:26]invoiceNum:2)}
			: ($ptFile=(->[Proposal:42]))
				aText3{Field:C253(->[Proposal:42]proposalNum:5)}:=aText1{Field:C253(->[Proposal:42]proposalNum:5)}
		End case 
End case 