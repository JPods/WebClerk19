//%attributes = {"publishedWeb":true}
//Method: TransAct_TunnelTo
Process_InitLocal
C_POINTER:C301($ptOrgFile)
TRACE:C157

$ptOrgFile:=<>ptCurTable
ptCurTable:=<>ptCurTable
USE SET:C118("<>curSelSet")
CLEAR SET:C117("<>curSelSet")
<>prcControl:=0
C_LONGINT:C283($i; $k; $tableNum; $docID)
$k:=Records in selection:C76(ptCurTable->)
CREATE EMPTY SET:C140([DCash:62]; "Current")
$tableNum:=Table:C252(ptCurTable)
ARRAY LONGINT:C221($docArray; 0)
If ($tableNum=26)
	SELECTION TO ARRAY:C260([Invoice:26]idNum:2; $docArray)
Else 
	SELECTION TO ARRAY:C260([Payment:28]idNum:8; $docArray)
End if 
REDUCE SELECTION:C351(ptCurTable->; 0)
For ($i; 1; $k)
	QUERY:C277([DCash:62]; [DCash:62]docApply:3=$docArray{$i}; *)
	QUERY:C277([DCash:62];  & [DCash:62]tableApply:2=$tableNum)
	If (Records in selection:C76([DCash:62])>0)
		CREATE SET:C116([DCash:62]; "Temp")
		UNION:C120("Current"; "Temp"; "Current")
		CLEAR SET:C117("Temp")
	End if 
	QUERY:C277([DCash:62]; [DCash:62]dtDocument:4=$docArray{$i}; *)
	QUERY:C277([DCash:62];  & [DCash:62]tableReceive:8=$tableNum)
	If (Records in selection:C76([DCash:62])>0)
		CREATE SET:C116([DCash:62]; "Temp")
		UNION:C120("Current"; "Temp"; "Current")
		CLEAR SET:C117("Temp")
	End if 
End for 
USE SET:C118("Current")
CLEAR SET:C117("Current")
If (Records in selection:C76([DCash:62])=0)
	ALERT:C41("There are no associated TransAct Records.")
Else 
	iLoPagePopUpMenuBar(->[DCash:62])
	$fia:=Size of array:C274(<>aPrsName)
	<>aPrsName{$fia}:=Substring:C12(<>aPrsName{$fia}+"-"+Table name:C256(<>ptCurTable); 1; 20)
	Open window:C153(4; 40; 635; 475; 8)
	$ptOrgFile:=ptCurTable
	MODIFY SELECTION:C204(ptCurTable->)
	While (($ptOrgFile#ptCurTable) & (Records in selection:C76(ptCurTable->)>0))  //for Join calls
		$ptOrgFile:=ptCurTable
		MODIFY SELECTION:C204(ptCurTable->)
	End while 
End if 
Process_ListActive