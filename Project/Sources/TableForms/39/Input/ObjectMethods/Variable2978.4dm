TRACE:C157
acceptPO
myOK:=12
//Try_AdjWin 

If (False:C215)
	ControlRecCheck
	DISABLE MENU ITEM:C150(1; 4)
	FORM SET INPUT:C55([Control:1]; "InshipAdj")
	MODIFY RECORD:C57([Control:1])
	Try_AdjRayFill(0)
	myOK:=33
	
End if 
//Try_AdjWin 


C_TEXT:C284($script1; $script2; $title)

$title:="For PO: "+String:C10([PO:39]poNum:5)

$script1:="Query([PO];[PO]PONum="+String:C10([PO:39]poNum:5)+")"+<>vCR+"myOK:=12"+<>vCR+"<>prcControl:=1"+<>vCR

$script2:="Try_AdjWin"

$childProcess:=New process:C317("Prs_ExecuteProcedures"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- Inships PO"; Current process:C322; $title; $script1; $script2)
APPEND TO ARRAY:C911(aChildProcesses; $childProcess)
vLastProcessLaunched:=$childProcess


