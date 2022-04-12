//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: DocLoadFromFolder
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
$skipAlert:=1
$myOK:=1
C_LONGINT:C283($1; $skipAlert)
If (Count parameters:C259=1)
	If ($1=1)
		If (HFS_Exists(iLoText1)=0)
			jAlertMessage(17002)
			$myOK:=0
		Else 
			$skipAlert:=1
		End if 
	End if 
End if 
C_LONGINT:C283($i; $k)
OK:=0
TRACE:C157
If ($myOK=1)
	$currentFolder:=iLoText1
	If ($skipAlert=1)
		iLoText1:=Get_FolderName("Select folder picture rename.")
	End if 
	If (iLoText1#"")
		HtPageRay(0)
		$error:=HFS_CatToArray(iLoText1; "aText1")
		$k:=Size of array:C274(aText1)
		$w:=Find in array:C230(aText1; "jitDocRef.txt")
		ARRAY TEXT:C222($aDocs; 0)
		ARRAY TEXT:C222($aStrRecs; 0)
		ARRAY TEXT:C222($aTitle; 0)
		ARRAY TEXT:C222($aDescription; 0)
		ARRAY TEXT:C222($aName; 0)
		ARRAY TEXT:C222($aEvent; 0)
		ARRAY TEXT:C222($aPublish; 0)
		
		C_TEXT:C284($theOther; $theDoc; $theRecord; $theTitle; $theDesc; $theName; $theEvent; $thePublish)
		
		If ($w>0)
			myDoc:=Open document:C264(iLoText1+"jitDocRef.txt")
			If (OK=1)
				$theDoc:=""
				$theRecord:=""
				Repeat 
					RECEIVE PACKET:C104(myDoc; $theDoc; "\t")
					RECEIVE PACKET:C104(myDoc; $theRecord; "\t")
					RECEIVE PACKET:C104(myDoc; $theTitle; "\t")
					RECEIVE PACKET:C104(myDoc; $theDesc; "\t")
					RECEIVE PACKET:C104(myDoc; $theName; "\t")
					RECEIVE PACKET:C104(myDoc; $theEvent; "\t")
					RECEIVE PACKET:C104(myDoc; $thePublish; "\t")
					If (OK=1)
						$theDoc:=TxtStripLineFeed($theDoc)
						$w:=Size of array:C274($aDocs)+1
						INSERT IN ARRAY:C227($aDocs; $w; 1)
						$aDocs{$w}:=$theDoc
						INSERT IN ARRAY:C227($aStrRecs; $w; 1)
						$aStrRecs{$w}:=$theRecord
						INSERT IN ARRAY:C227($aTitle; $w; 1)
						$aTitle{$w}:=$theTitle
						INSERT IN ARRAY:C227($aDescription; $w; 1)
						$aDescription{$w}:=$theDesc
						INSERT IN ARRAY:C227($aName; $w; 1)
						$aName{$w}:=$theName
						INSERT IN ARRAY:C227($aEvent; $w; 1)
						$aEvent{$w}:=$theEvent
						INSERT IN ARRAY:C227($aPublish; $w; 1)
						$aPublish{$w}:=$thePublish
					End if 
					RECEIVE PACKET:C104(myDoc; $theOther; "\r")
				Until (OK=0)
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
		$doFillValues:=(Size of array:C274($aDocs)>0)
		$fia:=0
		For ($i; 1; $k)
			REDUCE SELECTION:C351([Document:100]; 0)
			$w:=Size of array:C274(aHtSelect)+1
			HtPageRay(-3; $w; 1)
			
			If (Position:C15(Folder separator:K24:12; aText1{$i})>0)
				aHtSelect{$w}:="f"
			Else 
				aHtSelect{$w}:="d"
			End if 
			If ($doFillValues)
				$fia:=Find in array:C230($aDocs; aText1{$i})
				If ($fia>0)
					$recID:=Num:C11($aStrRecs{$fia})
					If ($recID>9)
						QUERY:C277([Document:100]; [Document:100]idNum:1=$recID)
					End if 
				End if 
			End if 
			aHtPage{$w}:=aText1{$i}
			If (Records in selection:C76([Document:100])=1)
				aHtBkGraf{$w}:=[Document:100]title:8
				aHtBkColor{$w}:=[Document:100]description:3
				aHtLink{$w}:=[Document:100]keyTags:11
				aHtvLink{$w}:=$aStrRecs{$fia}
				aHtaLink{$w}:=[Document:100]pathTN:5
				aHtText{$w}:=[Document:100]imageName:2
				aHtBody{$w}:=[Document:100]event:9
				aHtReason{$w}:=String:C10([Document:100]publish:12)
				aHtStyle{$w}:=[Document:100]copyrightPath:15
				
				//
			Else 
				If (($doFillValues) & ($fia>0))
					aHtBkGraf{$w}:=$aTitle{$fia}
					aHtBkColor{$w}:=$aDescription{$fia}
					aHtLink{$w}:=""  //[DocPath]KeyText
					aHtvLink{$w}:=""
					aHtaLink{$w}:=""  //[DocPath]PathHiRes
					aHtText{$w}:=$aName{$fia}
					aHtBody{$w}:=$aEvent{$fia}
					aHtReason{$w}:=""
					aHtStyle{$w}:=""
				End if 
			End if 
		End for 
		//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
	Else 
		iLoText1:=$currentFolder
	End if 
	ARRAY TEXT:C222(aText1; 0)
End if 