//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: DocSave2Folder
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($i; $k; $myOK)
$myOK:=0
If (HFS_Exists(iLoText1)=0)
	jAlertMessage(17002)
Else 
	$doDoc:=True:C214
	If (HFS_Exists(iLoText1+"jitDocRef.txt")>0)
		$error:=HFS_Delete(iLoText1+"jitDocRef.txt")
		If ($error#0)
			jAlertMessage(17003)
			$doDoc:=False:C215
		End if 
	End if 
	If ($doDoc)
		myDoc:=Create document:C266(iLoText1+"jitDocRef.txt")
		If (OK=1)
			C_LONGINT:C283($i; $k)
			$k:=Size of array:C274(aHtPage)
			For ($i; 1; $k)
				SEND PACKET:C103(myDoc; aHtPage{$i}+"\t")  //doc
				SEND PACKET:C103(myDoc; aHtvLink{$i}+"\t")  //RecordID
				SEND PACKET:C103(myDoc; aHtBkGraf{$i}+"\t")  //Title
				SEND PACKET:C103(myDoc; aHtBkColor{$i}+"\t")  //Description
				SEND PACKET:C103(myDoc; aHtText{$i}+"\t")  //Name
				SEND PACKET:C103(myDoc; aHtBody{$i}+"\t")  //Event
				SEND PACKET:C103(myDoc; aHtReason{$i}+"\t")  //Event
				SEND PACKET:C103(myDoc; "</recordEnd>"+"\r")  //Event
			End for 
			CLOSE DOCUMENT:C267(myDoc)
		End if 
		jAlertMessage(17004)
	End if 
End if 