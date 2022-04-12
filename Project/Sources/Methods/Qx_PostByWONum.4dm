//%attributes = {"publishedWeb":true}
//Procedure: Qx_PostByWONum
C_TEXT:C284($workingText; $curWOData; $tempWOStr)
C_LONGINT:C283($WoNum; $p; $pT; $pP)
C_TEXT:C284($endWOstring)
$endWOstring:=Char:C90(34)+")>"
C_LONGINT:C283($i; $k; $p)
CREATE EMPTY SET:C140([WorkOrder:66]; "Empty")
READ WRITE:C146([WorkOrder:66])
ARRAY LONGINT:C221($aWONums; 0)
ARRAY TEXT:C222($aWOText; 0)
$workingText:=Get text from pasteboard:C524
$p:=Position:C15("jitWO="; $workingText)
While ($p>0)
	$pT:=Position:C15("<&tbu2"; $workingText)
	$pP:=Position:C15("<&pbu2"; $workingText)
	//  
	If ((($pT<$pP) & ($pP>0)) | (($pT>0) & ($pP=0)))
		$pEnd:=Position:C15("<&te>"; $workingText)
		//
		$curWOData:=Substring:C12($workingText; $pT; $pEnd+4-$pT+1)
		$tempWOStr:=Substring:C12($workingText; $p+6)
		$p:=Position:C15($endWOstring; $tempWOStr)
		$WoNum:=Num:C11(Substring:C12($tempWOStr; 1; $p-1))
		//
		$workingText:=Substring:C12($workingText; $pEnd+5)
	Else 
		$pEnd:=Position:C15(">"; $workingText)
		//
		$curWOData:=Substring:C12($workingText; $pT; $pEnd-$pT+1)
		$tempWOStr:=Substring:C12($workingText; $p+6)
		$p:=Position:C15($endWOstring; $tempWOStr)
		$WoNum:=Num:C11(Substring:C12($tempWOStr; 1; $p-1))
		//    
		$workingText:=Substring:C12($workingText; $pEnd+1)
	End if 
	$w:=Find in array:C230($aWONums; $WoNum)
	If ($w<1)
		INSERT IN ARRAY:C227($aWONums; 1)
		INSERT IN ARRAY:C227($aWOText; 1)
		$aWONums{1}:=$WoNum
		$aWOText{1}:=$curWOData
	Else 
		$aWOText{$w}:=$aWOText{$w}+$curWOData
	End if 
	$p:=Position:C15("jitWO="; $workingText)
End while 
$k:=Size of array:C274($aWoNums)
If ($k>0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]name:1:="ProofingError"
	[TallyResult:73]purpose:2:="Quark"
	For ($i; 1; $k)
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$aWoNums{$i})
		LOAD RECORD:C52([WorkOrder:66])
		If ((Locked:C147([WorkOrder:66])) | (Records in selection:C76([WorkOrder:66])#1))
			[TallyResult:73]textBlk1:5:=[TallyResult:73]textBlk1:5+$aWOText{$i}
		Else 
			[WorkOrder:66]description:3:=$aWOText{$i}
			[WorkOrder:66]dtReleased:4:=DateTime_Enter
			[WorkOrder:66]activity:7:="InvoiceThis"
			[WorkOrder:66]actionBy:8:=Current user:C182
			[WorkOrder:66]comment:17:=String:C10(Current date:C33; 1)+":  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - Posted Proof"
			SAVE RECORD:C53([WorkOrder:66])
			ADD TO SET:C119([WorkOrder:66]; "Empty")
		End if 
	End for 
	USE SET:C118("Empty")
	CLEAR SET:C117("Empty")
	If ([TallyResult:73]textBlk1:5#"")
		SAVE RECORD:C53([TallyResult:73])
	End if 
End if 
READ ONLY:C145([WorkOrder:66])