//%attributes = {"publishedWeb":true}
C_LONGINT:C283($0)
C_POINTER:C301($ptFile)
$ptFile:=aSyncFilePt{aSyncCnt}
aText3:=0
$0:=-1
Case of   //should always result in no question, if new is entered
	: (($ptFile=(->[Customer:2])) & (aText3{Field:C253(->[Customer:2]customerID:1)}="new"))
		$0:=Field:C253(->[Customer:2]customerID:1)
		aText3{$0}:=Storage:C1525.default.idPrefix+String:C10(CounterNew($ptFile); "000000")
	: (($ptFile=(->[Order:3])) & (aText3{Field:C253(->[Order:3]orderNum:2)}="new"))
		$0:=Field:C253(->[Order:3]orderNum:2)
		aText3{Field:C253(->[Order:3]orderNum:2)}:=String:C10(CounterNew($ptFile))
	: (($ptFile=(->[Service:6])) & (aText3{Field:C253(->[Service:6]idNum:26)}="new"))
		$0:=Field:C253(->[Service:6]idNum:26)
		aText3{Field:C253(->[Service:6]idNum:26)}:=String:C10(CounterNew($ptFile))
	: (($ptFile=(->[Invoice:26])) & (aText3{Field:C253(->[Invoice:26]invoiceNum:2)}="new"))
		$0:=Field:C253(->[Invoice:26]invoiceNum:2)
		aText3{Field:C253(->[Invoice:26]invoiceNum:2)}:=String:C10(CounterNew($ptFile))
	: (($ptFile=(->[Proposal:42])) & (aText3{Field:C253(->[Proposal:42]proposalNum:5)}="new"))
		$0:=Field:C253(->[Proposal:42]proposalNum:5)
		aText3{Field:C253(->[Proposal:42]proposalNum:5)}:=String:C10(CounterNew($ptFile))
End case 