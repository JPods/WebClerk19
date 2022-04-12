//%attributes = {"publishedWeb":true}
C_LONGINT:C283($myOK)
myDocName:=""
$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; ""; Storage:C1525.folder.jitF)  //;jitQRsF
If ($myOK=1)
	C_TEXT:C284($inText; $recordText; $moreText)
	C_LONGINT:C283($endFound)
	$inText:=""
	$moreText:=""
	$endFound:=1
	myDocName:="Storage.folder.jitF"+"iSabrdFields.xmt"
	$myOK:=EI_OpenDoc(->myDocName; ->sumDoc; "Open iSabrd Template"; ""; Storage:C1525.folder.jitF)  //;jitQRsF
	If ($myOK=1)
		TextToArray
		
		Repeat 
			If (Length:C16($inText)<5000)
				If ($end found=1)
					RECEIVE PACKET:C104(myDoc; $moreText; 15000)
					$inText:=$inText+$moreText
					$moreText:=""
				End if 
				$p:=Position:C15("Personal Information"; $inText)
				$inText:=Substring:C12($inText; 2)
				$p:=Position:C15("Personal Information"; $inText)
				If ($p>0)
					$recordText:="P"+Substring:C12($inText; 1; $p-1)
				Else 
					$recordText:="P"+$inText
					$inText:=""
				End if 
				
				
			End if 
			
		Until (Length:C16($inText)=0)
		
		
	End if 
End if 
