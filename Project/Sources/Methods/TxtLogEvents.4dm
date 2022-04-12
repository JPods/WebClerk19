//%attributes = {"publishedWeb":true}
If (False:C215)
	//TxtLogEvents
	//Date: 03/11/03
	//Who: Bill
	//Description:  
End if 
//TRACE
C_TEXT:C284($reportFolder; $1; $strTime; $strDate; $2; $3; $4; $5)
C_LONGINT:C283($paraCount)
$paraCount:=Count parameters:C259
$docName:=String:C10(DateTime_Enter)+".txt"
$strDate:=String:C10(Current date:C33)
$strTime:=String:C10(Current time:C178)
$reportFolder:=Storage:C1525.folder.jitF+$1+Folder separator:K24:12
If (HFS_Exists($reportFolder)=0)
	$result:=New_Folder($reportFolder)
Else 
	Storage:C1525.folder.jitShip:=Storage:C1525.folder.jitF
End if 
If ($paraCount>0)
	myDoc:=Create document:C266($reportFolder+$docName)
	SEND PACKET:C103(myDoc; $strDate+"\t"+$strTime+"\t")
	SEND PACKET:C103(myDoc; $1+"\t")
	If ($paraCount>1)
		SEND PACKET:C103(myDoc; $2+"\t")
		If ($paraCount>2)
			SEND PACKET:C103(myDoc; $3+"\t")
			If ($paraCount>3)
				SEND PACKET:C103(myDoc; $4+"\t")
				If ($paraCount>4)
					SEND PACKET:C103(myDoc; $5+"\t")
				End if 
			End if 
		End if 
		SEND PACKET:C103(myDoc; "\r")
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 
