//%attributes = {"publishedWeb":true}
//(GP) SortFiles
myOK:=0
jCenterWindow(460; 414; -724; "Dups & Indexes"; "Wind_CloseBox")
DIALOG:C40([Control:1]; "SortFiles")
CLOSE WINDOW:C154
jaFilesClose
Case of 
	: (myOK=2)
		ProcessTableOpen(Table:C252(curTableNum))
	: (myOK=4)
		StructureCheckIndex
End case 