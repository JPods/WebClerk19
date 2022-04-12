//%attributes = {"publishedWeb":true}
//Procedure: Srch_PObySONum
C_LONGINT:C283($i; $k; $w; $soNum)
ARRAY LONGINT:C221($aPOTest; 0)
ARRAY LONGINT:C221($aPOLineTest; 0)
TRACE:C157
$response:=Request:C163("Search POs for Sales Order?"; "")
$response:=Replace string:C233($response; "-"; "")
If (OK=1)
	$soNum:=Num:C11($response)
	QUERY:C277([PO:39]; [PO:39]orderNum:18=$soNum)
	SELECTION TO ARRAY:C260([PO:39]poNum:5; $aPOTest)
	CREATE SET:C116([PO:39]; "Current")
	QUERY:C277([POLine:40]; [POLine:40]orderNum:16=$soNum)
	SELECTION TO ARRAY:C260([POLine:40]poNum:1; $aPOLineTest)
	$k:=Size of array:C274($aPOLineTest)
	For ($i; 1; $k)
		$w:=Find in array:C230($aPOTest; $aPOLineTest{$i})
		If ($w=-1)
			QUERY:C277([PO:39]; [PO:39]poNum:5=$aPOLineTest{$i})
			INSERT IN ARRAY:C227($aPOTest; 1; 1)
			$aPOTest{1}:=$aPOLineTest{$i}
			ADD TO SET:C119([PO:39]; "current")
		End if 
	End for 
	USE SET:C118("current")
	CLEAR SET:C117("Current")
	If (Records in selection:C76([PO:39])>0)
		ProcessTableOpen(->[PO:39])
	Else 
		ALERT:C41("No PO found for SO "+$response)
	End if 
End if 