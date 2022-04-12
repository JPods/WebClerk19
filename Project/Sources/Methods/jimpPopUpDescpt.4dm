//%attributes = {"publishedWeb":true}
//Procedure: jimpPopUpDescpt
//October 25, 1995
C_TEXT:C284($Comment)
C_TEXT:C284($popName)
C_LONGINT:C283($CurRec; $i; $k)
myDocName:=Storage:C1525.folder.jitF+"Setups :Popup Descriptions"
If (HFS_Exists(myDocName)=1)
	myDoc:=Open document:C264(myDocName)
	$myOK:=1
Else 
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Popup Descriptions"; vDocType; Storage:C1525.folder.jitF)  //;jitQRsF
End if 
If ($myOK=1)
	$CurRec:=Selected record number:C246([PopUp:23])
	CREATE SET:C116([PopUp:23]; "Current")
	$k:=Records in table:C83([PopUp:23])
	$i:=0
	Repeat 
		$i:=$i+1
		RECEIVE PACKET:C104(myDoc; $popName; "\t")
		RECEIVE PACKET:C104(myDoc; $Comment; Char:C90(165))
		If (ok=0)
			$i:=$k
		End if 
		QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3=$popName)
		If (Records in selection:C76([PopUp:23])=1)
			[PopUp:23]whereUsed:7:=$Comment
			SAVE RECORD:C53([PopUp:23])
		End if 
	Until ((Character code:C91($popName)=0) | ($i=$k))  //$k is for endless loop protection
	CLOSE DOCUMENT:C267(myDoc)
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	GOTO SELECTED RECORD:C245([PopUp:23]; $curRec)
End if 